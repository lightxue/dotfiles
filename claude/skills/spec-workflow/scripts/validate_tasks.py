#!/usr/bin/env python3
"""
验证任务规划文档（tasks.md）的完整性

检查项：
- 任务分组结构是否合理
- 分组依赖关系是否清晰
- 任务字段是否完整
- 任务粒度是否符合 10-15 分钟要求

返回格式：JSON
退出码：0=成功, 1=验证失败, 2=异常错误
"""

import sys
import re
import json
from pathlib import Path
from typing import Any, Union

# 任务必需字段
REQUIRED_TASK_FIELDS = [
    "描述",
    "设计参考",
    "文件操作",
    "预计用时",
    "状态",
    "分组"
]

# 文档头必需字段（基于 tasks.md.template）
REQUIRED_HEADERS = [
    "创建时间",
    "需求来源",
    "关联设计"
]


def validate_file_exists(file_path):
    """验证文件是否存在"""
    path = Path(file_path)
    if not path.exists():
        print(f"❌ 错误：文件不存在 - {file_path}")
        return False
    if not path.is_file():
        print(f"❌ 错误：不是文件 - {file_path}")
        return False
    return True


def validate_file_path(file_path: str) -> tuple[list[str], list[str]]:
    """验证文件路径格式是否符合规范

    检查项：
    - 文件名必须为 tasks.md
    - 建议在 .specs/ 目录下
    - 目录命名格式：{feature_name}-{requirement_id}
    - requirement_id 格式：TAPD为19位数字，文字描述为YYYYMMDDXXX
    """
    errors: list[str] = []
    warnings: list[str] = []

    path = Path(file_path)

    # 1. 检查文件名
    if path.name != 'tasks.md':
        errors.append(f"文件名错误：期望 'tasks.md'，实际 '{path.name}'")

    # 2. 检查是否在 .specs/ 目录下
    path_str = str(path.resolve())
    if '.specs' not in path_str:
        warnings.append(
            f"建议将文件放在 .specs/ 目录下\n"
            f"  当前路径：{path_str}\n"
            f"  推荐路径：.specs/{{feature_name}}-{{requirement_id}}/tasks.md"
        )
    else:
        # 3. 检查目录命名格式
        parent_name = path.parent.name

        if '-' not in parent_name:
            warnings.append(
                f"目录命名不符合规范：'{parent_name}'\n"
                f"  期望格式：{{feature_name}}-{{requirement_id}}\n"
                f"  示例：h5-subscribe-optimize-1020426960128093915"
            )
        else:
            # 分离 feature_name 和 requirement_id（简化版本）
            parts = parent_name.rsplit('-', 1)
            if len(parts) == 2:
                feature_name, _ = parts

                # 验证 feature_name（基本检查）
                if not feature_name:
                    warnings.append("feature_name 不能为空")
                elif not re.match(r'^[a-z0-9-]+$', feature_name):
                    warnings.append(
                        f"feature_name 建议使用小写字母、数字和连字符：'{feature_name}'\n"
                        f"  推荐格式：user-login, h5-subscribe-optimize"
                    )

    return errors, warnings


def validate_headers(content: str) -> list[str]:
    """验证文档头信息"""
    errors: list[str] = []

    # 提取文档头信息（以 > 开头的行）
    header_lines = [line.strip() for line in content.split('\n') if line.strip().startswith('>')]

    for required_header in REQUIRED_HEADERS:
        found = any(required_header in line for line in header_lines)
        if not found:
            errors.append(f"缺少文档头字段：{required_header}")

    return errors


def extract_tasks(content: str, exclude_qa_group: bool = False) -> list[dict[str, Union[str, None]]]:
    """提取所有任务

    支持的任务格式：
    - [ ] T{数字} {任务标题}（如 T1, T2, T3）
    - [ ] T{分组}.{序号} {任务标题}（如 T1.1, T1.2, T2.1）

    任务字段可以是缩进列表或加粗格式：
      - 描述：...
      - 设计参考：...
    或：
    **描述**：...
    **设计参考**：...

    Args:
        content: 文档内容
        exclude_qa_group: 是否排除「最终验收与审批」分组的任务（阶段3执行时使用）
    """
    tasks: list[dict[str, Union[str, None]]] = []

    # 1. 提取所有分组信息（确定哪个是「最终验收与审批」分组）
    group_pattern = r'###\s+分组\s+(\d+)[：:](.+)'
    groups = re.findall(group_pattern, content)

    qa_group_num = None
    if exclude_qa_group and groups:
        # 精确查找「最终验收与审批」分组（通过完整短语或标记）
        # 注意：分组 N-1 是"文档更新与验证"，分组 N 才是"最终验收与审批"
        for group_num, group_name in groups:
            if '最终验收与审批' in group_name or '最终分组' in group_name:
                qa_group_num = group_num
                break

        # 后备方案：如果没找到，取最后一个分组（最终验收分组永远是最后一个）
        if qa_group_num is None and groups:
            qa_group_num = groups[-1][0]

    # 2. 提取所有任务
    # 匹配任务格式：- [ ] T{数字或数字.数字} {任务标题}
    # 支持 T1、T2、T1.1、T1.2 等格式
    # 支持多种勾选符号：空格、x、X、✅、⏭️ 等
    # 捕获任务 ID 及其后续内容，直到下一个任务或章节
    task_pattern = r'- \[(?:[ xX✅⏭️]|)\] (T[\d.]+)\s+(.+?)(?=\n- \[(?:[ xX✅⏭️]|)\] T[\d.]+|\n#{2,}|\Z)'
    matches = re.finditer(task_pattern, content, re.DOTALL)

    for match in matches:
        task_id = match.group(1)
        task_content = match.group(2).strip()

        # 3. 确定任务所属分组
        task_group = None
        # 查找任务所在分组（向上查找最近的分组标题）
        task_start_pos = match.start()
        preceding_content = content[:task_start_pos]
        group_matches = list(re.finditer(r'###\s+分组\s+(\d+)', preceding_content))
        if group_matches:
            task_group = group_matches[-1].group(1)

        # 4. 如果需要排除质量检查分组，且当前任务属于该分组，则跳过
        if exclude_qa_group and qa_group_num and task_group == qa_group_num:
            continue

        tasks.append({
            'id': task_id,
            'content': task_content,
            'group': task_group
        })

    return tasks


def validate_task_fields(task: dict[str, str]) -> list[str]:
    """验证单个任务的字段完整性

    支持的字段格式：
    - 描述：...（缩进格式）
    或
    **描述**：...（加粗格式）
    """
    errors: list[str] = []
    missing_fields = []

    for field in REQUIRED_TASK_FIELDS:
        # 支持多种格式：
        # 1. 缩进列表：  - 描述：
        # 2. 加粗格式：**描述**：
        # 3. 普通格式：描述：
        patterns = [
            rf'-\s+{re.escape(field)}[：:]',  # 缩进列表格式
            rf'\*\*{re.escape(field)}\*\*[：:]',  # 加粗格式
            rf'{re.escape(field)}[：:]'  # 普通格式
        ]

        found = any(re.search(pattern, task['content']) for pattern in patterns)
        if not found:
            missing_fields.append(field)

    if missing_fields:
        errors.append(f"任务 {task['id']} 缺少字段：{', '.join(missing_fields)}")

    return errors


def validate_task_time(task: dict[str, str]) -> list[str]:
    """验证任务预计用时"""
    warnings: list[str] = []

    # 提取预计用时
    time_match = re.search(r'预计用时[：:]\s*(\d+)m', task['content'])
    if time_match:
        minutes = int(time_match.group(1))
        if minutes < 10:
            warnings.append(f"任务 {task['id']} 预计用时 {minutes}分钟过短，建议 ≥10分钟")
        elif minutes > 30:
            warnings.append(f"任务 {task['id']} 预计用时 {minutes}分钟过长，建议拆分为更小的任务（10-15分钟）")

    return warnings


def validate_task_groups(content: str) -> tuple[list[str], list[str]]:
    """验证任务分组"""
    errors: list[str] = []
    warnings: list[str] = []

    # 查找所有分组
    group_pattern = r'###\s+分组\s+(\d+)[：:]\s*(.+?)\n'
    groups = re.findall(group_pattern, content)

    if not groups:
        errors.append("未找到任务分组，必须按分组组织任务")
        return errors, warnings

    if len(groups) < 2:
        warnings.append(f"只有 {len(groups)} 个分组，建议至少分为 2-3 个分组")

    # 验证每个分组的任务数量
    for group_num, _group_name in groups:
        # 查找该分组的任务
        group_section_pattern = rf'###\s+分组\s+{group_num}[：:].*?\n(.*?)(?=\n###|\Z)'
        match = re.search(group_section_pattern, content, re.DOTALL)

        if match:
            group_content = match.group(1)
            # 支持 T1、T1.1 等格式，以及多种勾选符号
            task_count = len(re.findall(r'- \[(?:[ xX✅⏭️]|)\] T[\d.]+', group_content))

            if task_count == 0:
                errors.append(f"分组 {group_num} 没有任务")
            elif task_count > 6:
                warnings.append(f"分组 {group_num} 有 {task_count} 个任务，建议每组 3-5 个任务")

    return errors, warnings


def validate_dependency_diagram(content: str) -> tuple[list[str], list[str]]:
    """验证分组依赖关系图/分组执行顺序"""
    errors: list[str] = []
    warnings: list[str] = []

    # 查找依赖关系图章节（兼容两种标题格式）
    has_dependency_section = '分组依赖关系' in content or '分组执行顺序' in content

    if not has_dependency_section:
        errors.append("缺少「分组依赖关系」或「分组执行顺序」章节")
        return errors, warnings

    # 查找章节附近的 mermaid 图（兼容两种标题）
    dependency_patterns = [
        r'##\s+分组依赖关系(.*?)(?=\n##|\Z)',
        r'##\s+分组执行顺序(.*?)(?=\n##|\Z)'
    ]

    section_found = False
    for pattern in dependency_patterns:
        match = re.search(pattern, content, re.DOTALL)
        if match:
            section_found = True
            section_content = match.group(1)

            # 检查是否有 mermaid 图（可选，因为模板中可能使用列表格式）
            has_mermaid = '```mermaid' in section_content
            has_ordered_list = bool(re.search(r'^\d+\.', section_content, re.MULTILINE))

            if not has_mermaid and not has_ordered_list:
                warnings.append(
                    "分组执行顺序建议使用 mermaid 依赖图或编号列表清晰展示"
                )
            break

    if not section_found:
        errors.append("无法解析分组执行顺序章节内容")

    return errors, warnings


def _check_required_subsections(checklist_content: str) -> list[str]:
    """检查必需的验收子章节"""
    warnings = []
    # 必需的验收子章节（允许带括号备注）
    required_subsections = [
        ('功能验收', r'###\s+功能验收'),
        ('质量验收', r'###\s+质量验收'),
        ('文档验收', r'###\s+文档验收'),
        ('部署验收', r'###\s+部署验收')  # 允许"部署验收（如涉及后端变更）"等格式
    ]

    for name, pattern in required_subsections:
        if not re.search(pattern, checklist_content):
            warnings.append(f"建议添加验收子章节：### {name}")
    return warnings


def _has_empty_marker(checklist_content: str) -> bool:
    """检查是否标注为「无」或「待补充」"""
    empty_patterns = [
        r'[「『（\(]无[」』）\)]',  # 「无」、（无）
        r'[:：]\s*无\s*[。，\n]',  # ：无。、：无，
        r'[-*]\s*无\s*[。，\n]',  # - 无。
        r'无验收项',
        r'待补充'
    ]
    return any(re.search(pattern, checklist_content) for pattern in empty_patterns)


def _build_unchecked_errors(unchecked_items: list[str]) -> list[str]:
    """构建未勾选项的错误信息（阶段3）"""
    errors = [
        f"❌ 阶段3验证失败：存在 {len(unchecked_items)} 个未完成的验收项",
        "",
        "📋 未完成的验收项："
    ]
    for i, item in enumerate(unchecked_items[:10], 1):
        errors.append(f"   {i}. [ ] {item.strip()}")
    if len(unchecked_items) > 10:
        errors.append(f"   ... 还有 {len(unchecked_items) - 10} 个未完成验收项")
    errors.extend([
        "",
        "🔧 必须完成以下操作才能通过审批：",
        "   1. 将已完成的验收项改为 - [x]（勾选）",
        "   2. 如某些验收项不适用，请删除或标注原因",
        "   3. 确保所有验收标准都已满足"
    ])
    return errors


def _build_unchecked_warnings(unchecked_items: list[str]) -> list[str]:
    """构建未勾选项的警告信息（阶段2）"""
    warnings = [f"⚠️ 存在 {len(unchecked_items)} 个未完成的验收项"]
    for i, item in enumerate(unchecked_items[:5], 1):
        warnings.append(f"   {i}. [ ] {item.strip()}")
    if len(unchecked_items) > 5:
        warnings.append(f"   ... 还有 {len(unchecked_items) - 5} 个未完成验收项")
    warnings.extend([
        "",
        "💡 说明：",
        "   - 阶段2（计划阶段）：可以有未勾选的验收项",
        "   - ❗️ 阶段3（执行完成）：必须全部勾选才能审批通过",
        "",
        "🔧 解决方法：",
        "   1. 将已完成的验收项改为 - [x]（勾选）",
        "   2. 如某些验收项不适用，请删除或标注原因"
    ])
    return warnings


def _check_key_items(checklist_content: str) -> list[str]:
    """检查关键验收项是否存在"""
    warnings = []
    key_items = {
        '所有分组执行完成': '功能验收',
        '代码审查通过': '质量验收',
        '单元测试覆盖率': '质量验收',
        'wiki 文档已更新': '文档验收',  # 与模板一致：wiki 文档已更新（而非"已同步"）
        '发布方案已制定': '部署验收'  # 更新为模板中的用词
    }
    for key_item, category in key_items.items():
        if key_item not in checklist_content:
            warnings.append(f"建议在「{category}」中添加验收项：{key_item}")
    return warnings


def validate_acceptance_checklist(content: str, phase: str = "planning") -> tuple[list[str], list[str]]:
    """验证验收清单（基于 tasks.md.template，强制检查未勾选项）

    根据模板要求，验收清单应包含：
    - ### 功能验收
    - ### 质量验收
    - ### 文档验收
    - ### 部署验收

    Args:
        content: 文档内容
        phase: 验证阶段 - "planning"(阶段2) | "execution"(阶段3)
    """
    errors: list[str] = []
    warnings: list[str] = []

    if '验收清单' not in content:
        errors.append("缺少「验收清单」章节")
        return errors, warnings

    # 提取验收清单内容
    checklist_pattern = r'##\s+验收清单(.*?)(?=\n##\s+[^#]|\Z)'
    match = re.search(checklist_pattern, content, re.DOTALL)

    if not match:
        errors.append("无法解析验收清单内容")
        return errors, warnings

    checklist_content = match.group(1)

    # 1. 检查必需的验收子章节
    warnings.extend(_check_required_subsections(checklist_content))

    # 2. 检查是否明确标注「无」或「待补充」
    if _has_empty_marker(checklist_content):
        warnings.append("验收清单标注为「无」或「待补充」，建议在执行前补充完整")
        return errors, warnings

    # 3. 查找所有未勾选的验收项
    unchecked_items = re.findall(r'-\s*\[\s*\]\s*(.+)', checklist_content)
    checked_items = re.findall(r'-\s*\[[xX]\]\s*(.+)', checklist_content)

    # 4. 关键检查：阶段3执行完成时，必须全部勾选
    if unchecked_items:
        if phase == "execution":
            errors.extend(_build_unchecked_errors(unchecked_items))
        else:
            warnings.extend(_build_unchecked_warnings(unchecked_items))

    # 5. 检查验收清单数量
    total_items = len(unchecked_items) + len(checked_items)
    if total_items < 4:
        warnings.append(
            f"验收清单只有 {total_items} 项，建议补充更详细的验收标准\n"
            f"  期望至少包含：功能验收、质量验收、文档验收、部署验收"
        )

    # 6. 检查关键验收项是否存在
    warnings.extend(_check_key_items(checklist_content))

    return errors, warnings


def _read_file_content(file_path: str) -> tuple[str | None, list[str]]:
    """读取文件内容

    Returns:
        (content, errors): 文件内容和错误列表
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            return f.read(), []
    except OSError as e:
        return None, [f"读取文件失败: {str(e)}"]


def _check_incomplete_tasks(tasks: list[dict[str, str | None]]) -> list[str]:
    """检查未完成的任务（阶段3执行时使用）

    Returns:
        errors: 错误信息列表
    """
    incomplete_tasks = []
    for task in tasks:
        content_str = task.get('content', '')
        if content_str:
            status_match = re.search(r'状态[：:]\s*(\w+)', content_str)
            if status_match:
                status = status_match.group(1).strip()
                if status != 'done':
                    incomplete_tasks.append({
                        'id': task.get('id', '未知'),
                        'status': status,
                        'group': task.get('group', '未知')
                    })

    if not incomplete_tasks:
        return []

    # 构建错误信息
    errors = [
        f"❌ 阶段3验证失败：存在 {len(incomplete_tasks)} 个未完成的任务（不含质量检查分组）",
        "",
        "📋 未完成的任务："
    ]

    for i, task in enumerate(incomplete_tasks[:10], 1):
        errors.append(f"   {i}. {task['id']} (状态: {task['status']}, 分组: {task['group']})")

    if len(incomplete_tasks) > 10:
        errors.append(f"   ... 还有 {len(incomplete_tasks) - 10} 个未完成任务")

    errors.extend([
        "",
        "🔧 必须完成以下操作才能通过 T{N+1} 验证：",
        "   1. 将已完成的任务状态改为 'done'",
        "   2. 确保所有功能分组和文档分组的任务都已完成",
        "   3. 最终验收分组（分组N）的任务不在此验证范围内"
    ])

    return errors


def _validate_task_list(tasks: list[dict[str, str | None]], phase: str) -> tuple[list[str], list[str]]:
    """验证任务列表

    Returns:
        (errors, warnings): 错误和警告列表
    """
    errors = []
    warnings = []

    if not tasks:
        return ["未找到任何任务，请添加任务列表"], []

    # 阶段3执行时，检查任务完成状态
    if phase == "execution":
        errors.extend(_check_incomplete_tasks(tasks))

    # 验证每个任务的字段和用时
    for task in tasks:
        task_id = task.get('id') or ''
        task_content = task.get('content') or ''
        task_for_validation: dict[str, str] = {'id': task_id, 'content': task_content}

        errors.extend(validate_task_fields(task_for_validation))
        warnings.extend(validate_task_time(task_for_validation))

    return errors, warnings


def _build_suggestions(errors: list[str], warnings: list[str]) -> list[str]:
    """构建修复建议

    Returns:
        suggestions: 建议列表
    """
    suggestions = []

    if errors:
        suggestions.append("请修复上述错误后重新验证")
        error_str = str(errors)
        if "缺少文档头字段" in error_str:
            suggestions.append("参考 assets/templates/tasks.md.template 模板补充文档头")
        if "未找到任务分组" in error_str:
            suggestions.append("参考 assets/templates/tasks.md.template 模板按分组组织任务")
    elif warnings:
        suggestions.append("建议改进警告项后再提交审批")

    return suggestions


def validate_tasks(file_path: str, phase: str = "planning") -> dict[str, Any]:
    """主验证函数 - 返回结构化数据

    Args:
        file_path: 文档路径
        phase: 验证阶段 - "planning"(阶段2) | "execution"(阶段3)
    """
    all_errors = []
    all_warnings = []

    # 1. 检查文件存在性
    if not validate_file_exists(file_path):
        return {
            "success": False,
            "errors": [f"文件不存在或无法访问: {file_path}"],
            "warnings": [],
            "suggestions": ["检查文件路径是否正确", "确认文件是否存在"]
        }

    # 2. 验证文件路径格式
    errors, warnings = validate_file_path(file_path)
    all_errors.extend(errors)
    all_warnings.extend(warnings)

    # 3. 读取文件内容
    content, errors = _read_file_content(file_path)
    if content is None:
        return {
            "success": False,
            "errors": errors,
            "warnings": [],
            "suggestions": ["检查文件编码是否为 UTF-8", "确认文件权限"]
        }

    # 4. 验证文档头信息
    all_errors.extend(validate_headers(content))

    # 5. 验证任务分组
    errors, warnings = validate_task_groups(content)
    all_errors.extend(errors)
    all_warnings.extend(warnings)

    # 6. 提取并验证任务
    exclude_qa_group = (phase == "execution")
    tasks = extract_tasks(content, exclude_qa_group=exclude_qa_group)
    errors, warnings = _validate_task_list(tasks, phase)
    all_errors.extend(errors)
    all_warnings.extend(warnings)

    # 7. 验证分组依赖关系图
    errors, warnings = validate_dependency_diagram(content)
    all_errors.extend(errors)
    all_warnings.extend(warnings)

    # 8. 验证验收清单
    errors, warnings = validate_acceptance_checklist(content, phase=phase)
    all_errors.extend(errors)
    all_warnings.extend(warnings)

    # 构建修复建议
    suggestions = _build_suggestions(all_errors, all_warnings)

    # 返回结构化结果
    return {
        "success": len(all_errors) == 0,
        "errors": all_errors,
        "warnings": all_warnings,
        "suggestions": suggestions,
        "stats": {
            "error_count": len(all_errors),
            "warning_count": len(all_warnings),
            "task_count": len(tasks) if tasks else 0
        }
    }


def main():
    """主程序入口 - 支持 JSON 输出模式"""
    import argparse  # pylint: disable=import-outside-toplevel

    parser = argparse.ArgumentParser(
        description='验证任务规划文档格式规范',
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument('file_path', help='任务规划文档路径（如 .specs/xxx/tasks.md）')
    parser.add_argument('--json', action='store_true', help='JSON 格式输出（用于自动化）')
    parser.add_argument('--quiet', action='store_true', help='静默模式（仅输出 JSON）')
    parser.add_argument('--phase', choices=['planning', 'execution'], default='planning',
                        help='验证阶段：planning(阶段2) 或 execution(阶段3，排除最终验收分组)')

    args = parser.parse_args()

    # 执行验证
    result = validate_tasks(args.file_path, phase=args.phase)

    # JSON 输出模式
    if args.json or args.quiet:
        print(json.dumps(result, ensure_ascii=False, indent=2))
        sys.exit(0 if result["success"] else 1)

    # 人类可读输出模式（原有格式）
    print(f"\n{'='*60}")
    print(f"📄 验证任务规划文档：{args.file_path}")
    print(f"{'='*60}\n")

    if result.get("stats", {}).get("task_count"):
        print(f"📊 找到 {result['stats']['task_count']} 个任务\n")

    if result["errors"]:
        print("❌ 发现以下错误（必须修复）：\n")
        for i, error in enumerate(result["errors"], 1):
            print(f"  {i}. {error}")
        print()

    if result["warnings"]:
        print("⚠️  发现以下警告（建议改进）：\n")
        for i, warning in enumerate(result["warnings"], 1):
            print(f"  {i}. {warning}")
        print()

    if not result["errors"] and not result["warnings"]:
        print("✅ 所有检查通过！任务规划文档格式规范。\n")
    elif not result["errors"]:
        print("⚠️  格式检查通过，但存在警告项，建议改进后再提交审批。\n")
    else:
        print(f"❌ 验证失败：发现 {len(result['errors'])} 个错误，{len(result['warnings'])} 个警告\n")

    if result["suggestions"]:
        print("💡 修复建议：\n")
        for i, suggestion in enumerate(result["suggestions"], 1):
            print(f"  {i}. {suggestion}")
        print()

    # 退出码：0=成功，1=验证失败
    sys.exit(0 if result["success"] else 1)


if __name__ == "__main__":
    main()
