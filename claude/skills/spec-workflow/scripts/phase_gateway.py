#!/usr/bin/env python3
"""
阶段检查点网关（Phase Gateway）- 简化版

核心职责：
- 防止跳过阶段：必须按 0 → 1 → 2 → 3 顺序执行
- 防止跳过验证：每个阶段的验证脚本必须通过
- 状态推断：直接从文档内容推断当前状态（无需额外状态文件）

使用方式：
  python3 scripts/phase_gateway.py --check-phase 0      # 检查是否可进入阶段0
  python3 scripts/phase_gateway.py --check-phase 1      # 检查阶段0是否完成
  python3 scripts/phase_gateway.py --status              # 显示当前工作流状态
  python3 scripts/phase_gateway.py --approve-phase 1 "审批通过"  # 审批阶段1
  python3 scripts/phase_gateway.py --check-env          # 检查环境依赖

返回码：
  0 = ✅ 可以进入该阶段
  1 = ❌ 前置条件未满足，禁止进入
  2 = ⚠️ 异常错误
"""

from __future__ import annotations
import sys
import re
import argparse
import subprocess
from pathlib import Path
from datetime import datetime
from typing import Any


# ============================================================
# 环境依赖检查
# ============================================================

def check_python_version() -> tuple[bool, str]:
    """检查Python版本是否满足要求（3.8+）"""
    required_version = (3, 8)
    current_version = sys.version_info[:2]

    if current_version < required_version:
        return False, (
            f"❌ Python版本过低\n"
            f"   当前版本: {current_version[0]}.{current_version[1]}\n"
            f"   要求版本: {required_version[0]}.{required_version[1]}+\n"
            f"   → 请升级Python: https://www.python.org/downloads/"
        )

    return True, f"✅ Python版本: {current_version[0]}.{current_version[1]}"


def check_dependencies() -> tuple[bool, list[str]]:
    """检查所有依赖项

    返回: (是否全部满足, 详细信息列表)
    """
    checks = []
    all_passed = True

    # 1. Python版本检查
    py_passed, py_msg = check_python_version()
    checks.append(py_msg)
    if not py_passed:
        all_passed = False

    # 2. 验证脚本存在性检查
    required_scripts = [
        ("1+3文档验证脚本", VALIDATE_WIKI_SCRIPT),
        ("设计验证脚本", VALIDATE_DESIGN_SCRIPT),
        ("任务验证脚本", VALIDATE_TASKS_SCRIPT),
    ]

    for name, script_path in required_scripts:
        if script_path.exists():
            checks.append(f"✅ {name}: {script_path.name}")
        else:
            checks.append(f"❌ {name}不存在: {script_path}")
            all_passed = False

    # 3. 项目根目录检查
    try:
        root = get_project_root()
        checks.append(f"✅ 项目根目录: {root}")
    except (FileNotFoundError, RuntimeError, ValueError, OSError) as e:
        checks.append(f"❌ 无法定位项目根目录: {e}")
        all_passed = False

    return all_passed, checks


def handle_check_env_command() -> int:
    """处理 --check-env 命令"""
    print("\n" + "="*60)
    print("🔍 环境依赖检查")
    print("="*60 + "\n")

    passed, checks = check_dependencies()

    for check in checks:
        print(check)

    print("\n" + "="*60)
    if passed:
        print("✅ 所有依赖检查通过")
        print("="*60)
        return 0
    else:
        print("❌ 依赖检查失败，请修复上述问题后重试")
        print("="*60)
        return 1



# 导入路径工具（兼容直接运行和模块导入）
try:
    from .path_utils import (
        VALIDATE_WIKI_SCRIPT,
        VALIDATE_DESIGN_SCRIPT,
        VALIDATE_TASKS_SCRIPT,
        get_project_root,
        find_wiki_docs_dir,
        find_preparation_files,
        find_design_files,
        find_tasks_files,
    )
except (ImportError, ValueError):
    # pylint: disable=import-outside-toplevel
    # type: ignore[reportImplicitRelativeImport]
    from path_utils import (  # noqa: I001
        VALIDATE_WIKI_SCRIPT,
        VALIDATE_DESIGN_SCRIPT,
        VALIDATE_TASKS_SCRIPT,
        get_project_root,
        find_wiki_docs_dir,
        find_preparation_files,
        find_design_files,
        find_tasks_files,
    )

# 项目根目录
PROJECT_ROOT = get_project_root()

# 审批有效用语
VALID_APPROVAL_PHRASES = [
    "确认无误", "审批通过", "同意", "批准", "可以", "没问题",
]

# 阶段定义（简化版）
PHASES: dict[int, dict[str, Any]] = {
    0: {
        "name": "前置准备",
        "check_complete": lambda: (
            find_wiki_docs_dir() is not None
            and validate_wiki_docs_passes()[0]
            and is_phase_approved(0)
        ),
        "requires_approval": True,
        "approval_doc": lambda: (
            find_preparation_files()[0]
            if len(find_preparation_files()) > 0
            else None
        ),
    },
    1: {
        "name": "设计方案",
        "check_complete": lambda: (
            has_design_doc()
            and validate_design_passes()[0]
            and is_phase_approved(1)
        ),
        "requires_approval": True,
        "approval_doc": lambda: (
            find_design_files()[0]
            if len(find_design_files()) > 0
            else None
        ),
    },
    2: {
        "name": "任务规划",
        "check_complete": lambda: (
            has_tasks_doc()
            and validate_tasks_passes()[0]
            and is_phase_approved(2)
        ),
        "requires_approval": True,
        "approval_doc": lambda: (
            find_tasks_files()[0]
            if len(find_tasks_files()) > 0
            else None
        ),
    },
    3: {
        "name": "计划执行",
        "check_complete": lambda: is_phase_approved(3),  # 只需审批确认
        "requires_approval": True,
        # 复用tasks.md
        "approval_doc": lambda: (
            find_tasks_files()[0]
            if len(find_tasks_files()) > 0
            else None
        ),
    },
}


# ============================================================
# 审批标记管理（基于文档注释）
# ============================================================

def get_approval_marker(phase_id: int) -> dict[str, str]:
    """从文档中读取审批标记

    返回: {"status": "pending|approved", "by": "审批人", "time": "时间", "comment": "意见"}
    """
    phase = PHASES.get(phase_id)
    if not phase or not phase.get("requires_approval"):
        return {"status": "n/a"}

    doc_func = phase.get("approval_doc")
    if not doc_func:
        return {"status": "pending"}

    doc_file = doc_func()
    if not doc_file or not doc_file.exists():
        return {"status": "pending"}

    try:
        content = doc_file.read_text(encoding="utf-8")

        # 匹配审批标记（新增 APPROVAL_PHASE 字段用于区分阶段）
        # <!-- APPROVAL_STATUS: approved -->
        # <!-- APPROVAL_PHASE: 2 -->
        # <!-- APPROVAL_BY: 张三 -->
        # <!-- APPROVAL_TIME: 2025-11-13T10:30:00 -->
        # <!-- APPROVAL_COMMENT: 审批通过 -->

        # 查找所有审批标记块
        approval_blocks = re.finditer(
            r'<!-- APPROVAL_STATUS:\s*(\w+)\s*-->\s*'
            r'<!-- APPROVAL_PHASE:\s*(\d+)\s*-->\s*'
            r'<!-- APPROVAL_BY:\s*(.+?)\s*-->\s*'
            r'<!-- APPROVAL_TIME:\s*(.+?)\s*-->\s*'
            r'<!-- APPROVAL_COMMENT:\s*(.+?)\s*-->',
            content
        )

        # 查找匹配当前阶段的审批标记
        for match in approval_blocks:
            status = match.group(1)
            phase = int(match.group(2))
            by = match.group(3).strip()
            time = match.group(4).strip()
            comment = match.group(5).strip()

            if phase == phase_id:
                return {
                    "status": status,
                    "by": by,
                    "time": time,
                    "comment": comment,
                }

        # 没有找到匹配当前阶段的审批标记，返回 pending
        return {"status": "pending"}

    except (IOError, OSError) as e:
        print(f"⚠️ 读取审批标记失败: {e}")
        return {"status": "pending"}


def set_approval_marker(phase_id: int, approved_by: str, comment: str) -> bool:
    """在文档中写入审批标记

    返回: 是否成功
    """
    phase = PHASES.get(phase_id)
    if not phase or not phase.get("requires_approval"):
        return False

    doc_func = phase.get("approval_doc")
    if not doc_func:
        return False

    doc_file = doc_func()
    if not doc_file or not doc_file.exists():
        print(f"❌ 找不到阶段{phase_id}的文档文件")
        return False

    # 备份文件路径
    backup_file = doc_file.parent / f"{doc_file.stem}.backup{doc_file.suffix}"

    try:
        content = doc_file.read_text(encoding="utf-8")

        # 防止内容为空导致文件被清空
        if not content.strip():
            print(f"⚠️ 警告：文档 {doc_file.name} 内容为空，跳过审批标记")
            return False

        # 创建备份
        try:
            backup_file.write_text(content, encoding="utf-8")
            print(f"📦 已创建备份：{backup_file.name}")
        except (IOError, OSError) as backup_error:
            print(f"⚠️ 备份创建失败（继续执行）: {backup_error}")

        # 准备新的审批标记（增加 APPROVAL_PHASE 字段区分阶段）
        approval_time = datetime.now().isoformat()
        new_markers = f"""<!-- APPROVAL_STATUS: approved -->
<!-- APPROVAL_PHASE: {phase_id} -->
<!-- APPROVAL_BY: {approved_by} -->
<!-- APPROVAL_TIME: {approval_time} -->
<!-- APPROVAL_COMMENT: {comment} -->"""

        # 检查是否已有当前阶段的审批标记
        approval_pattern = (
            r"<!-- APPROVAL_STATUS:[^>]*-->\s*"
            rf"<!-- APPROVAL_PHASE:\s*{phase_id}\s*-->\s*"
            r"<!-- APPROVAL_BY:[^>]*-->\s*"
            r"<!-- APPROVAL_TIME:[^>]*-->\s*"
            r"<!-- APPROVAL_COMMENT:[^>]*-->"
        )

        if re.search(approval_pattern, content):
            # 替换当前阶段的现有审批标记
            new_content = re.sub(
                approval_pattern,
                new_markers,
                content,
                count=1  # 只替换第一个匹配
            )

            # 验证替换是否成功（内容长度应该相近）
            if len(new_content) < len(content) * 0.8:
                print("⚠️ 警告：替换后内容缩短过多，可能存在错误，跳过写入")
                print(f"   原始长度: {len(content)}, 新长度: {len(new_content)}")
                return False

            content = new_content
        else:
            # 在文档开头添加当前阶段的审批标记
            # 如果文档已有其他阶段的审批标记，新标记会追加在开头
            content = new_markers + "\n\n" + content

        # 再次验证内容不为空
        if not content.strip():
            print("❌ 错误：处理后的内容为空，拒绝写入")
            return False

        # 写回文件
        doc_file.write_text(content, encoding="utf-8")
        print(f"✅ 已在 {doc_file.name} 中记录审批标记")

        # 写入成功后删除备份
        try:
            if backup_file.exists():
                backup_file.unlink()
        except OSError:
            pass  # 忽略删除备份的错误

        return True

    except (IOError, OSError) as e:
        print(f"❌ 写入审批标记失败: {e}")
        import traceback
        traceback.print_exc()

        # 尝试从备份恢复
        if backup_file.exists():
            try:
                backup_content = backup_file.read_text(encoding="utf-8")
                doc_file.write_text(backup_content, encoding="utf-8")
                print(f"🔄 已从备份恢复文件：{doc_file.name}")
            except (IOError, OSError) as restore_error:
                print(f"❌ 从备份恢复失败: {restore_error}")

        return False


def is_phase_approved(phase_id: int) -> bool:
    """检查阶段是否已审批通过"""
    marker = get_approval_marker(phase_id)
    return marker.get("status") == "approved"


def is_valid_approval(user_input: str) -> bool:
    """检查用户输入是否包含有效的审批用语"""
    user_input_lower = user_input.lower().strip()
    return any(phrase.lower() in user_input_lower for phrase in VALID_APPROVAL_PHRASES)


# ============================================================
# 状态推断（基于文档内容）
# ============================================================

def get_current_phase() -> int:
    """推断当前所处的阶段（基于文档完成情况）

    返回: 当前阶段号 (0-3)
    """
    for phase_id in range(3, -1, -1):  # 从后往前检查
        if is_phase_complete(phase_id):
            # 如果阶段N已完成，则当前在阶段N+1（或已全部完成）
            return min(phase_id + 1, 3)

    return 0  # 所有阶段都未完成，从阶段0开始


def is_phase_complete(phase_id: int) -> bool:
    """检查某个阶段是否已完成

    返回: True/False
    """
    phase = PHASES.get(phase_id)
    if not phase:
        return False

    check_func = phase.get("check_complete")
    if not check_func:
        return False

    try:
        return check_func()
    except (IOError, OSError) as e:
        print(f"⚠️ 检查阶段{phase_id}完成状态异常: {e}")
        return False


# ============================================================
# 文档验证辅助函数
# ============================================================

def validate_wiki_docs_passes() -> tuple[bool, str]:
    """运行 validate_wiki.py 检查 1+3 文档是否通过

    返回: (是否通过, 错误信息)
    """
    try:
        wiki_docs_dir = find_wiki_docs_dir()
        if not wiki_docs_dir:
            return False, "❌ 未找到 1+3 文档目录（doc/）"

        result = subprocess.run(
            ["python3", str(VALIDATE_WIKI_SCRIPT), str(wiki_docs_dir)],
            cwd=PROJECT_ROOT,
            capture_output=True,
            text=True,
            timeout=30,
            check=False,
        )
        if result.returncode != 0:
            error_msg = result.stderr.strip() or result.stdout.strip()
            return False, f"❌ 1+3文档验证失败:\n{error_msg}"
        return True, "✅ 1+3文档验证通过"
    except subprocess.TimeoutExpired:
        return False, "❌ 1+3文档验证超时（>30秒）"
    except FileNotFoundError:
        return False, f"❌ 未找到验证脚本: {VALIDATE_WIKI_SCRIPT}"
    except OSError as e:
        return False, f"❌ 执行验证脚本失败: {e}"


def has_design_doc() -> bool:
    """检查是否存在设计文档"""
    return len(find_design_files()) > 0


def validate_design_passes() -> tuple[bool, str]:
    """检查设计文档验证是否通过

    返回: (是否通过, 错误信息)
    """
    design_files = find_design_files()
    if not design_files:
        return False, "❌ 未找到设计文档（.specs/{name}-{id}/design.md）"

    for design_file in design_files:
        try:
            result = subprocess.run(
                ["python3", str(VALIDATE_DESIGN_SCRIPT), str(design_file)],
                cwd=PROJECT_ROOT,
                capture_output=True,
                text=True,
                timeout=30,
                check=False,
            )
            if result.returncode == 0:
                return True, "✅ 设计验证通过"
            else:
                error_msg = result.stderr.strip() or result.stdout.strip()
                return False, f"❌ 设计验证失败:\n{error_msg}"
        except subprocess.TimeoutExpired:
            return False, f"❌ 设计验证超时（>30秒）: {design_file.name}"
        except FileNotFoundError:
            return False, f"❌ 未找到验证脚本: {VALIDATE_DESIGN_SCRIPT}"
        except OSError as e:
            return False, f"❌ 执行验证脚本失败: {e}"

    return False, "❌ 设计文档验证失败"


def has_tasks_doc() -> bool:
    """检查是否存在任务计划文档"""
    return len(find_tasks_files()) > 0


def validate_tasks_passes() -> tuple[bool, str]:
    """检查任务计划验证是否通过

    返回: (是否通过, 错误信息)
    """
    tasks_files = find_tasks_files()
    if not tasks_files:
        return False, "❌ 未找到任务计划文档（.specs/{name}-{id}/tasks.md）"

    for tasks_file in tasks_files:
        try:
            result = subprocess.run(
                ["python3", str(VALIDATE_TASKS_SCRIPT), str(tasks_file)],
                cwd=PROJECT_ROOT,
                capture_output=True,
                text=True,
                timeout=30,
                check=False,
            )
            if result.returncode == 0:
                return True, "✅ 任务计划验证通过"
            else:
                error_msg = result.stderr.strip() or result.stdout.strip()
                return False, f"❌ 任务计划验证失败:\n{error_msg}"
        except subprocess.TimeoutExpired:
            return False, f"❌ 任务计划验证超时（>30秒）: {tasks_file.name}"
        except FileNotFoundError:
            return False, f"❌ 未找到验证脚本: {VALIDATE_TASKS_SCRIPT}"
        except OSError as e:
            return False, f"❌ 执行验证脚本失败: {e}"

    return False, "❌ 任务计划验证失败"


# ============================================================
# 阶段检查逻辑（简化版）
# ============================================================

def check_phase_entry(phase_id: int) -> tuple[bool, list[str]]:
    """检查能否进入某个阶段（只检查前置阶段是否完成）

    返回：(可进入, 失败原因列表)
    """
    if phase_id == 0:
        return True, []  # 阶段0无前置条件

    # 检查前一个阶段是否完成
    prev_phase_id = phase_id - 1

    if not is_phase_complete(prev_phase_id):
        return False, [
            f"❌ 必须先完成阶段 {prev_phase_id}：{PHASES[prev_phase_id]['name']}",
            "",
            "⚠️ 禁止操作：",
            f"  - ❌ 不可跳过阶段{prev_phase_id}直接进入阶段{phase_id}",
            "  - ❌ 不可\"先做阶段{phase_id}，后补阶段{prev_phase_id}\"",
            f"  - ❌ 不可生成阶段{phase_id}的文档",
            "",
            "✅ 正确做法：",
            f"  1. 完成阶段{prev_phase_id}的所有步骤",
            "  2. 运行验证脚本确保通过",
            "  3. 如需审批，执行审批流程",
            "  4. 重新运行此检查命令",
        ]

    # 前置阶段已完成，可以进入
    return True, []


def _check_phase0_details(details: list[str]) -> tuple[str, list[str]]:
    """检查阶段0的详细状态"""
    wiki_docs_exists = find_wiki_docs_dir() is not None
    wiki_docs_valid, wiki_docs_msg = validate_wiki_docs_passes()
    approved = is_phase_approved(0)

    details.append(f"   {'✅' if wiki_docs_exists else '❌'} 1+3文档目录存在")
    details.append(f"   {'✅' if wiki_docs_valid else '❌'} 1+3文档验证通过")
    if not wiki_docs_valid and wiki_docs_msg:
        details.append(f"      {wiki_docs_msg}")
    details.append(f"   {'✅' if approved else '❌'} 审批通过")

    status = "in_progress" if (wiki_docs_exists or wiki_docs_valid) else "pending"
    return status, details


def _check_phase1_details(details: list[str]) -> tuple[str, list[str]]:
    """检查阶段1的详细状态"""
    design_exists = has_design_doc()
    design_valid, design_msg = validate_design_passes()
    approved = is_phase_approved(1)

    details.append(f"   {'✅' if design_exists else '❌'} 设计文档存在")
    details.append(f"   {'✅' if design_valid else '❌'} 设计验证通过")
    if not design_valid and design_msg:
        details.append(f"      {design_msg}")
    details.append(f"   {'✅' if approved else '❌'} 审批通过")

    status = "in_progress" if (design_exists or design_valid) else "pending"
    return status, details


def _check_phase2_details(details: list[str]) -> tuple[str, list[str]]:
    """检查阶段2的详细状态"""
    tasks_exists = has_tasks_doc()
    tasks_valid, tasks_msg = validate_tasks_passes()
    approved = is_phase_approved(2)

    details.append(f"   {'✅' if tasks_exists else '❌'} 任务计划存在")
    details.append(f"   {'✅' if tasks_valid else '❌'} 计划验证通过")
    if not tasks_valid and tasks_msg:
        details.append(f"      {tasks_msg}")
    details.append(f"   {'✅' if approved else '❌'} 审批通过")

    status = "in_progress" if (tasks_exists or tasks_valid) else "pending"
    return status, details


def _check_phase3_details(details: list[str]) -> tuple[str, list[str]]:
    """检查阶段3的详细状态"""
    approved = is_phase_approved(3)
    details.append(f"   {'✅' if approved else '❌'} 执行完成审批")

    status = "in_progress" if not approved else "pending"
    return status, details


# 阶段检查策略映射表
_PHASE_CHECKERS = {
    0: _check_phase0_details,
    1: _check_phase1_details,
    2: _check_phase2_details,
    3: _check_phase3_details,
}


def check_phase_status(phase_id: int) -> tuple[str, list[str]]:
    """检查某个阶段的状态

    返回：(状态, 详细信息列表)
    状态: "completed" | "in_progress" | "pending" | "blocked"
    """
    phase = PHASES[phase_id]
    details = []

    # 检查是否已完成
    if is_phase_complete(phase_id):
        details.append(f"✅ 阶段{phase_id}已完成")
        if phase.get("requires_approval"):
            marker = get_approval_marker(phase_id)
            details.append(f"   审批人: {marker.get('by', 'N/A')}")
            details.append(f"   审批时间: {marker.get('time', 'N/A')}")
        return "completed", details

    # 检查前置条件
    if phase_id > 0 and not is_phase_complete(phase_id - 1):
        details.append(f"⏸️  阶段{phase_id}被阻塞：等待阶段{phase_id - 1}完成")
        return "blocked", details

    # 检查各个条件（使用策略模式）
    details.append(f"⏳ 阶段{phase_id}进行中：")

    checker = _PHASE_CHECKERS.get(phase_id)
    if checker:
        return checker(details)

    return "pending", details


# ============================================================
# 命令处理函数（降低复杂度）
# ============================================================

def print_phase_in_progress_suggestions(current_phase: int) -> None:
    """打印阶段进行中的建议"""
    print(f"⏳ 阶段{current_phase}进行中，请完成以下步骤：\n")

    if current_phase == 0:
        wiki_docs_exists = find_wiki_docs_dir() is not None
        wiki_docs_valid, wiki_docs_msg = validate_wiki_docs_passes()
        approved = is_phase_approved(0)

        if not wiki_docs_exists:
            print("  ❌ 缺少1+3文档目录")
            print("     → 请执行阶段0步骤生成 1+3 文档（doc/）")
        elif not wiki_docs_valid:
            print("  ❌ 1+3文档验证未通过")
            print(f"     {wiki_docs_msg}")
            print("     → 运行: python3 scripts/validate_wiki.py doc")
            print("     → 根据错误提示修复后重新验证")
        elif not approved:
            print("  ✅ 1+3文档已验证通过")
            print("  ❌ 等待人工审批")
            print("\n     → 请在对话框中输入有效审批用语（如：'审批通过'、'确认无误'）")
            print("     → AI会自动执行审批命令")

    elif current_phase == 1:
        design_exists = has_design_doc()
        design_valid, design_msg = validate_design_passes()
        approved = is_phase_approved(1)

        if not design_exists:
            print("  ❌ 缺少设计文档")
            print("     → 请执行阶段1步骤生成 design.md")
        elif not design_valid:
            print("  ❌ 设计验证未通过")
            print(f"     {design_msg}")
            print("     → 运行: python3 scripts/validate_design.py .specs/{name}-{id}/design.md")
            print("     → 根据错误提示修复后重新验证")
        elif not approved:
            print("  ✅ 设计文档已验证通过")
            print("  ❌ 等待人工审批")
            print("\n     → 请在对话框中输入有效审批用语（如：'审批通过'、'确认无误'）")
            print("     → AI会自动执行审批命令")

    elif current_phase == 2:
        tasks_exists = has_tasks_doc()
        tasks_valid, tasks_msg = validate_tasks_passes()
        approved = is_phase_approved(2)

        if not tasks_exists:
            print("  ❌ 缺少任务计划文档")
            print("     → 请执行阶段2步骤生成 tasks.md")
        elif not tasks_valid:
            print("  ❌ 任务计划验证未通过")
            print(f"     {tasks_msg}")
            print("     → 运行: python3 scripts/validate_tasks.py .specs/{name}-{id}/tasks.md")
            print("     → 根据错误提示修复后重新验证")
        elif not approved:
            print("  ✅ 任务计划已验证通过")
            print("  ❌ 等待人工审批")
            print("\n     → 请在对话框中输入有效审批用语（如：'审批通过'、'确认无误'）")
            print("     → AI会自动执行审批命令")

    elif current_phase == 3:
        approved = is_phase_approved(3)

        if not approved:
            print("  ❌ 等待执行完成审批")
            print("\n     → 请在对话框中输入有效审批用语（如：'审批通过'、'确认无误'）")
            print("     → AI会自动执行审批命令")


def print_next_step_suggestions(current_phase: int, current_status: str) -> None:
    """打印下一步建议"""
    print("="*60)
    print("💡 下一步建议")
    print("="*60)

    if current_status == "completed":
        if current_phase < 3:
            next_phase = current_phase + 1
            print(f"✅ 阶段{current_phase}已完成，可以进入下一阶段")
            print("\n推荐操作：")
            print(f"  1. 检查能否进入阶段{next_phase}：")
            print(f"     python3 scripts/phase_gateway.py --check-phase {next_phase}")
            print(f"\n  2. 读取阶段{next_phase}步骤文档：")
            print(f"     references/phases/phase-{next_phase}-*.md")
        else:
            print("🎉 所有阶段已完成！需求开发工作流结束。")

    elif current_status == "in_progress":
        print_phase_in_progress_suggestions(current_phase)

    elif current_status == "pending":
        print(f"⏸️  阶段{current_phase}尚未开始")
        print("\n推荐操作：")
        print(f"  1. 读取阶段{current_phase}步骤文档：")
        print(f"     references/phases/phase-{current_phase}-*.md")
        print("\n  2. 按文档步骤执行")

    elif current_status == "blocked":
        print(f"🔒 阶段{current_phase}被阻塞")
        if current_phase > 0:
            prev_phase = current_phase - 1
            print(f"   → 请先完成阶段{prev_phase}：{PHASES[prev_phase]['name']}")


def handle_status_command() -> int:
    """处理 --status 命令"""
    print("\n" + "="*60)
    print("📊 工作流整体状态（基于文档推断）")
    print("="*60)

    current_phase = get_current_phase()
    print(f"当前阶段：{current_phase} ({PHASES[current_phase]['name']})\n")

    for phase_id in range(4):  # 修复：工作流只有4个阶段（0-3）
        status, details = check_phase_status(phase_id)
        status_icon = {
            "completed": "✅",
            "in_progress": "⏳",
            "pending": "⏸️ ",
            "blocked": "🔒",
        }.get(status, "❓")

        print(f"{status_icon} 阶段{phase_id}: {PHASES[phase_id]['name']} ({status})")
        for detail in details[1:]:  # 跳过第一行总结
            print(f"  {detail}")
        print()

    # 快速诊断和下一步建议
    current_status, _ = check_phase_status(current_phase)
    print_next_step_suggestions(current_phase, current_status)

    print("\n" + "="*60)
    return 0


def handle_approve_command(phase_id: int, approval: str | None, approver: str | None) -> int:
    """处理 --approve-phase 命令"""
    # 严格检查审批参数
    if not approval or not approval.strip():
        print("\n❌ 缺少必需参数: --approval \"审批意见\"")
        print("\n用法示例：")
        print(f"  python3 {Path(__file__).name} --approve-phase {phase_id} --approval \"审批通过\" --approver \"张三\"")
        print("\n⚠️ 请勿直接重试此命令，等待用户输入有效审批用语后再执行！")
        return 1

    approval_comment = approval.strip()
    approver_name = approver or "未署名"

    # 检查审批用语（严格验证）
    if not is_valid_approval(approval_comment):
        print(f"\n{'='*60}")
        print("❌ 审批未通过：未检测到有效的审批用语")
        print(f"{'='*60}")
        print(f"\n您输入的审批意见：「{approval_comment}」")
        print("\n💡 建议使用以下审批用语：")
        for phrase in VALID_APPROVAL_PHRASES:
            print(f"  - {phrase}")
        print("\n⚠️ AI 注意：")
        print("  - 不要重试此命令！")
        print("  - 停止执行，等待用户在对话框中输入有效审批用语")
        print("  - 用户输入有效审批用语后，再使用新的审批意见执行命令")
        return 1

    # 写入审批标记
    success = set_approval_marker(phase_id, approver_name, approval_comment)

    if success:
        print(f"\n✅ 阶段{phase_id}审批成功！")
        print(f"   审批人: {approver_name}")
        print(f"   意见: {approval_comment}")
        print(f"   时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        return 0
    else:
        print("\n❌ 审批失败")
        return 1


def handle_check_phase_command(phase_id: int) -> int:
    """处理 --check-phase 命令"""
    print(f"\n🔐 检查能否进入阶段 {phase_id}（{PHASES[phase_id]['name']})...")
    print("="*60)

    can_enter, failures = check_phase_entry(phase_id)

    if can_enter:
        print(f"✅ 可以进入阶段 {phase_id}")
        print(f"\n💡 下一步：开始阶段 {phase_id} 的工作")
        return 0
    else:
        print(f"❌ 无法进入阶段 {phase_id}，原因如下：")
        for failure in failures:
            print(f"  {failure}")
        return 1


# ============================================================
# 主函数（简化版）
# ============================================================

def main() -> int:
    """主函数入口"""
    parser = argparse.ArgumentParser(description="阶段检查点网关（Phase Gateway）- 简化版")
    _ = parser.add_argument(
        "--check-phase",
        type=int,
        choices=[0, 1, 2, 3],
        help="检查是否可以进入指定阶段（0-3）",
    )
    _ = parser.add_argument(
        "--status",
        action="store_true",
        help="显示当前工作流状态",
    )
    _ = parser.add_argument(
        "--approve-phase",
        type=int,
        choices=[0, 1, 2, 3],
        help="审批指定阶段（0, 1, 2, 3）",
    )
    _ = parser.add_argument(
        "--approval",
        type=str,
        help="审批意见（配合 --approve-phase 使用）",
    )
    _ = parser.add_argument(
        "--approver",
        type=str,
        help="审批人姓名（配合 --approve-phase 使用）",
    )
    _ = parser.add_argument(
        "--check-env",
        action="store_true",
        help="检查环境依赖（Python版本、验证脚本等）",
    )

    args = parser.parse_args()

    if args.check_env:
        return handle_check_env_command()

    if args.status:
        return handle_status_command()

    if args.approve_phase is not None:
        return handle_approve_command(args.approve_phase, args.approval, args.approver)

    if args.check_phase is not None:
        return handle_check_phase_command(args.check_phase)

    # 如果没有参数，显示帮助
    parser.print_help()
    return 0


if __name__ == "__main__":
    sys.exit(main())
