#!/usr/bin/env python3
"""
验证 wiki 文档（1+3文档结构）的完整性

检查项：
- 4个文档是否存在（README + architecture + interfaces + implementation）
- 必需章节是否完整
- mermaid 图数量和质量
- 接口文档表格格式
- 代码位置标注
- 占位符检查

返回格式：JSON
退出码：0=成功, 1=验证失败, 2=异常错误
"""

import sys
import re
import json
import argparse
from pathlib import Path

# 1+3文档结构定义
DOC_STRUCTURE = {
    "README.md": {
        "required_sections": ["快速导航", "项目结构", "核心模块"],
        "min_mermaid": 0,  # README不强制要求mermaid图
        "description": "入口索引 - 项目概览、快速导航、核心模块"
    },
    "architecture.md": {
        "required_sections": ["整体架构", "模块划分", "数据模型", "技术选型"],
        "min_mermaid": 1,  # 至少1个架构图
        "description": "架构核心 - 架构设计、模块划分、数据模型"
    },
    "interfaces.md": {
        "required_sections": ["接口总览", "核心接口详细定义"],
        "min_mermaid": 0,  # 流程图在implementation.md
        "description": "接口汇总 - 接口清单、请求响应定义"
    },
    "implementation.md": {
        "required_sections": ["核心业务流程", "关键实现点"],
        "min_mermaid": 1,  # 至少1个核心流程图（精简后减少要求）
        "description": "实现细节 - 业务流程图、关键实现说明"
    }
}

# 占位符关键词
PLACEHOLDER_KEYWORDS = [
    "TODO", "待补充", "待完善", "TBD", "待添加", "待实现", "待确认"
]

# 最小章节内容字数
MIN_SECTION_LENGTH = 50


def validate_directory_structure(doc_dir):
    """验证doc目录结构和文档存在性"""
    errors = []
    warnings = []

    doc_path = Path(doc_dir)

    # 检查目录是否存在
    if not doc_path.exists():
        errors.append(f"文档目录不存在: {doc_dir}")
        return errors, warnings, {}

    if not doc_path.is_dir():
        errors.append(f"路径不是目录: {doc_dir}")
        return errors, warnings, {}

    # 检查4个文档是否都存在
    found_docs = {}
    for doc_name in DOC_STRUCTURE:
        doc_file = doc_path / doc_name
        if doc_file.exists():
            found_docs[doc_name] = str(doc_file)
        else:
            errors.append(f"缺少文档: {doc_name}")

    # 如果有缺失文档，直接返回
    if len(found_docs) != 4:
        warnings.append(
            f"文档不完整，期望4个文档，实际找到{len(found_docs)}个\n"
            f"  期望文档: {', '.join(DOC_STRUCTURE.keys())}\n"
            f"  已找到: {', '.join(found_docs.keys())}"
        )

    return errors, warnings, found_docs


def validate_required_sections(content, required_sections, doc_name):
    """验证必需章节"""
    errors = []
    warnings = []

    for section in required_sections:
        # 匹配二级或三级标题（支持带序号、emoji和不带序号的情况）
        # 使用 .*? 来匹配可能存在的emoji、序号等前缀

        # Pattern 1: ## [任意前缀] 章节名
        # 例如: ## 快速导航, ## 📋 快速导航
        pattern1 = f"^##\\s+(?!#).*?{re.escape(section)}"

        # Pattern 2: ### [任意前缀] 章节名
        pattern2 = f"^###\\s+(?!#).*?{re.escape(section)}"

        if not (re.search(pattern1, content, re.MULTILINE) or
                re.search(pattern2, content, re.MULTILINE)):
            errors.append(f"{doc_name}: 缺少必需章节「{section}」")

    return errors, warnings


def validate_mermaid_diagrams(content, min_count, doc_name):
    """验证mermaid图数量和质量"""
    errors = []
    warnings = []

    # 查找所有mermaid代码块
    mermaid_blocks = re.findall(r'```mermaid\s+(.*?)```', content, re.DOTALL)

    if len(mermaid_blocks) < min_count:
        errors.append(
            f"{doc_name}: mermaid图数量不足（需要≥{min_count}个，实际{len(mermaid_blocks)}个）"
        )
        return errors, warnings

    # 检查每个mermaid图的质量
    for i, block in enumerate(mermaid_blocks, 1):
        block = block.strip()

        # 检查图类型
        valid_types = ['graph', 'flowchart', 'sequenceDiagram', 'classDiagram', 'stateDiagram']
        if not any(block.startswith(t) for t in valid_types):
            warnings.append(f"{doc_name}: 第{i}个mermaid图缺少图类型声明")

        # 检查是否为空
        if len(block) < 20:
            errors.append(f"{doc_name}: 第{i}个mermaid图内容过少或为空")

        # 精简后的流程图不强制要求Note over标注（AI会从代码位置表格推断）
        # 原策略：检查代码位置标注
        # 新策略：仅在表格化实现步骤中验证代码位置

    return errors, warnings


def validate_interface_table(content, doc_name):
    """验证接口表格（仅interfaces.md需要）"""
    errors = []
    warnings = []

    if doc_name != "interfaces.md":
        return errors, warnings

    # 查找接口总览章节（支持emoji、序号等任意前缀）
    section_match = re.search(
        r'##\s+(?!#).*?接口总览\s+(.*?)(?=^##\s+(?!#)|\Z)',
        content, re.DOTALL | re.MULTILINE
    )

    if not section_match:
        errors.append(f"{doc_name}: 未找到「接口总览」章节")
        return errors, warnings

    section_content = section_match.group(1)

    # 检查接口表格
    table_pattern = r'\|.*\|.*\|'
    tables = re.findall(table_pattern, section_content)

    if not tables:
        errors.append(f"{doc_name}: 「接口总览」章节缺少接口表格")
        return errors, warnings

    # 查找包含所有必需列的表头（支持\"接口名称\"或\"接口路径\"或\"接口\"）
    required_columns = ['协议', '功能', '代码位置']
    header_line = None

    for line in tables:
        # 检查是否包含接口名称相关的列
        has_interface = '接口名称' in line or '接口路径' in line or ('接口' in line and '接口数量' not in line)
        # 检查是否包含协议、功能、代码位置
        has_all_required = all(col in line for col in required_columns)

        if has_interface and has_all_required:
            header_line = line
            break

    if not header_line:
        warnings.append(
            f"{doc_name}: 接口表格缺少关键列，期望包含: "
            f"接口名称(或接口路径)、协议、功能、代码位置\n"
            f"  参考格式: | 接口名称 | 协议 | 功能 | 代码位置 | 认证 |"
        )

    # 统计接口数量
    interface_count = 0
    for row in tables[1:]:  # 跳过表头
        if '---' not in row and row.strip():
            interface_count += 1

    if interface_count == 0:
        errors.append(f"{doc_name}: 接口表格为空，请添加接口定义")
    if 0 < interface_count < 3:
        warnings.append(
            f"{doc_name}: 接口数量较少（{interface_count}个），请确认是否有遗漏"
        )

    return errors, warnings


def validate_code_locations(content, doc_name):
    """验证代码位置标注"""
    errors = []
    warnings = []

    # 提取所有代码位置标注
    # 格式1: 表格中的 `file.go:10-50`
    table_locs = re.findall(r'`([^`]+\.(?:go|java|py|js|ts|tsx|jsx|cpp|c|h|hpp):\d+-\d+)`', content)

    # 格式2: Note over中的 (file.go:10-50)
    note_locs = re.findall(
        r'Note over [^:]+:[^(]*\(([^)]+\.(?:go|java|py|js|ts|tsx|jsx|cpp|c|h|hpp):\d+-\d+)\)',
        content
    )

    # 格式3: 节点中的 file.go:10-50
    node_locs = re.findall(r'<br/>([^<]+\.(?:go|java|py|js|ts|tsx|jsx|cpp|c|h|hpp):\d+-\d+)\]', content)

    all_locs = table_locs + note_locs + node_locs

    if not all_locs:
        # interfaces.md和implementation.md必须有代码位置标注
        if doc_name in ["interfaces.md", "implementation.md"]:
            warnings.append(
                f"{doc_name}: 未找到代码位置标注\n"
                f"  建议标注格式: `logic/user.go:25-60`"
            )
        return errors, warnings

    # 验证格式（支持更多语言扩展名）
    valid_pattern = r'^[\w/.-]+\.(go|java|py|js|ts|tsx|jsx|cpp|c|h|hpp):\d+-\d+$'
    invalid_locs = []

    for loc in all_locs:
        loc = loc.strip()
        if not re.match(valid_pattern, loc):
            invalid_locs.append(loc)

    if invalid_locs:
        errors.append(
            f"{doc_name}: 发现{len(invalid_locs)}处代码位置格式不规范:\n" +
            "\n".join(f"  - {loc}" for loc in invalid_locs[:3]) +
            ("\n  ..." if len(invalid_locs) > 3 else "")
        )

    # 检查行号合理性（精简后允许更大跨度，因为删除了代码片段）
    for loc in all_locs:
        match = re.search(r':(\d+)-(\d+)$', loc)
        if match:
            start, end = int(match.group(1)), int(match.group(2))
            if start > end:
                errors.append(f"{doc_name}: 代码位置行号错误（起始>结束）: {loc}")
            # 精简后删除了代码片段，AI会自己read_file，所以放宽跨度限制到500行
            elif end - start > 500:
                warnings.append(f"{doc_name}: 代码跨度过大（>{end-start}行）: {loc}")

    return errors, warnings


def validate_placeholders(content, doc_name):
    """检查占位符"""
    errors = []
    warnings = []

    for keyword in PLACEHOLDER_KEYWORDS:
        if re.search(keyword, content, re.IGNORECASE):
            warnings.append(f"{doc_name}: 发现占位符「{keyword}」，建议补充完整内容")

    return errors, warnings


def validate_single_document(file_path, doc_name, config):
    """验证单个文档"""
    errors = []
    warnings = []

    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except (IOError, OSError) as e:
        errors.append(f"{doc_name}: 读取文件失败 - {str(e)}")
        return errors, warnings

    # 1. 验证必需章节
    errs, warns = validate_required_sections(
        content, config["required_sections"], doc_name
    )
    errors.extend(errs)
    warnings.extend(warns)

    # 2. 验证mermaid图
    if config["min_mermaid"] > 0:
        errs, warns = validate_mermaid_diagrams(
            content, config["min_mermaid"], doc_name
        )
        errors.extend(errs)
        warnings.extend(warns)

    # 3. 验证接口表格（仅interfaces.md）
    errs, warns = validate_interface_table(content, doc_name)
    errors.extend(errs)
    warnings.extend(warns)

    # 4. 验证代码位置标注
    errs, warns = validate_code_locations(content, doc_name)
    errors.extend(errs)
    warnings.extend(warns)

    # 5. 检查占位符
    errs, warns = validate_placeholders(content, doc_name)
    errors.extend(errs)
    warnings.extend(warns)

    return errors, warnings


def validate_wiki(doc_path):
    """主验证函数

    Args:
        doc_path: doc目录路径 或 单个文档文件路径

    Returns:
        验证结果字典
    """
    path = Path(doc_path)

    # 判断是单文件还是目录
    if path.is_file():
        # 单文件验证模式
        return validate_single_file(doc_path)
    if path.is_dir():
        # 目录验证模式（原逻辑）
        return validate_directory(doc_path)
    return {
        "success": False,
        "doc_type": "未知",
        "errors": [f"路径不存在或无效: {doc_path}"],
        "warnings": [],
        "suggestions": ["检查路径是否正确"],
        "stats": {"error_count": 1, "warning_count": 0}
    }


def validate_single_file(file_path):
    """验证单个文档文件

    Args:
        file_path: 文档文件路径（如 doc/README.md）

    Returns:
        验证结果字典
    """
    path = Path(file_path)
    doc_name = path.name

    # 检查是否为支持的文档类型
    if doc_name not in DOC_STRUCTURE:
        return {
            "success": False,
            "doc_type": "单文档验证",
            "errors": [f"不支持的文档类型: {doc_name}，支持的类型: {', '.join(DOC_STRUCTURE.keys())}"],
            "warnings": [],
            "suggestions": ["请验证 1+3 文档结构中的文档"],
            "stats": {"error_count": 1, "warning_count": 0}
        }

    # 检查文件是否存在
    if not path.exists():
        return {
            "success": False,
            "doc_type": "单文档验证",
            "errors": [f"文档文件不存在: {file_path}"],
            "warnings": [],
            "suggestions": [f"创建 {doc_name} 文件"],
            "stats": {"error_count": 1, "warning_count": 0}
        }

    # 验证文档
    config = DOC_STRUCTURE[doc_name]
    errors, warnings = validate_single_document(str(path), doc_name, config)

    # 构建修复建议
    suggestions = []
    if errors:
        suggestions.append(f"请修复 {doc_name} 的错误后重新验证")
        if any("缺少必需章节" in e for e in errors):
            suggestions.append(f"参考 assets/templates/{doc_name}.template 补充缺失章节")
        if any("代码位置" in e for e in errors):
            suggestions.append("参考格式: `logic/user.go:25-60`")

    if warnings and not errors:
        suggestions.append("建议改进警告项后再继续")

    # 返回结果
    return {
        "success": len(errors) == 0,
        "doc_type": f"单文档验证 - {doc_name}",
        "file_path": str(path),
        "doc_description": config["description"],
        "errors": errors,
        "warnings": warnings,
        "suggestions": suggestions,
        "stats": {
            "error_count": len(errors),
            "warning_count": len(warnings),
            "docs_validated": 1
        }
    }


def validate_directory(doc_dir):
    """验证整个文档目录（原逻辑）

    Args:
        doc_dir: doc目录路径
    """
    all_errors = []
    all_warnings = []

    # 1. 验证目录结构和文档存在性
    errors, warnings, found_docs = validate_directory_structure(doc_dir)
    all_errors.extend(errors)
    all_warnings.extend(warnings)

    if not found_docs:
        return {
            "success": False,
            "doc_type": "1+3文档结构",
            "errors": all_errors,
            "warnings": all_warnings,
            "suggestions": [
                "创建缺失的文档文件",
                "参考 references/project_doc_init.md 生成文档"
            ]
        }

    # 2. 验证每个文档
    for doc_name, file_path in found_docs.items():
        config = DOC_STRUCTURE[doc_name]
        errors, warnings = validate_single_document(file_path, doc_name, config)
        all_errors.extend(errors)
        all_warnings.extend(warnings)

    # 3. 构建修复建议
    suggestions = []
    if all_errors:
        suggestions.append("请修复上述错误后重新验证")
        if any("缺少文档" in e for e in all_errors):
            suggestions.append("参考 assets/templates/*.md.template 创建缺失文档")
        if any("缺少必需章节" in e for e in all_errors):
            suggestions.append("参考 references/project_doc_init.md 补充缺失章节")
        if any("代码位置" in e for e in all_errors):
            suggestions.append("参考格式: `logic/user.go:25-60`")

    if all_warnings and not all_errors:
        suggestions.append("建议改进警告项后再提交审批")

    # 4. 返回结果
    return {
        "success": len(all_errors) == 0,
        "doc_type": "1+3文档结构",
        "errors": all_errors,
        "warnings": all_warnings,
        "suggestions": suggestions,
        "stats": {
            "error_count": len(all_errors),
            "warning_count": len(all_warnings),
            "docs_found": len(found_docs),
            "docs_expected": 4
        }
    }


def _parse_arguments():
    """解析命令行参数"""
    parser = argparse.ArgumentParser(
        description='验证 wiki 文档格式规范（1+3文档结构）',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
文档结构说明：
  doc/
  ├── README.md          # 入口索引
  ├── architecture.md    # 架构核心
  ├── interfaces.md      # 接口汇总
  └── implementation.md  # 实现细节

使用示例：
  # 验证整个目录
  python3 validate_wiki.py doc/

  # 验证单个文档
  python3 validate_wiki.py doc/README.md
  python3 validate_wiki.py doc/architecture.md
  python3 validate_wiki.py doc/interfaces.md
  python3 validate_wiki.py doc/implementation.md

增强检查模式（--enhanced）：暂时保留兼容性，未实现
        """
    )
    parser.add_argument(
        'doc_path',
        help='文档目录路径（如 doc/）或单个文档文件路径（如 doc/README.md）'
    )
    parser.add_argument(
        '--json',
        action='store_true',
        help='JSON 格式输出（用于自动化）'
    )
    parser.add_argument(
        '--quiet',
        action='store_true',
        help='静默模式（仅输出 JSON）'
    )
    parser.add_argument(
        '--enhanced',
        action='store_true',
        help='启用增强质量检查（保留兼容性）'
    )

    return parser.parse_args()


def _print_header(doc_path, doc_type):
    """打印验证头部信息"""
    print("\n" + "="*60)
    print(f"📄 验证 wiki 文档：{doc_path}")
    print(f"   验证模式：{doc_type}")
    print("="*60 + "\n")


def _print_errors(errors):
    """打印错误信息"""
    if not errors:
        return

    print("❌ 发现以下错误（必须修复）：\n")
    for i, error in enumerate(errors, 1):
        print(f"  {i}. {error}")
    print()


def _print_warnings(warnings):
    """打印警告信息"""
    if not warnings:
        return

    print("⚠️  发现以下警告（建议改进）：\n")
    for i, warning in enumerate(warnings, 1):
        print(f"  {i}. {warning}")
    print()


def _print_summary(result):
    """打印验证总结"""
    stats = result.get("stats", {})
    errors = result.get("errors", [])
    warnings = result.get("warnings", [])

    print("📊 统计信息：")
    print(f"  - 文档数量：{stats.get('docs_found', 0)}/{stats.get('docs_expected', 4)}")
    print(f"  - 错误数量：{stats.get('error_count', 0)}")
    print(f"  - 警告数量：{stats.get('warning_count', 0)}")
    print()

    if not errors and not warnings:
        print("✅ 所有检查通过！wiki 文档格式规范。\n")
    elif not errors:
        print("⚠️  格式检查通过，但存在警告项，建议改进后再提交审批。\n")
    else:
        print(f"❌ 验证失败：发现 {len(errors)} 个错误，{len(warnings)} 个警告\n")


def _print_suggestions(suggestions):
    """打印修复建议"""
    if not suggestions:
        return

    print("💡 修复建议：\n")
    for i, suggestion in enumerate(suggestions, 1):
        print(f"  {i}. {suggestion}")
    print()


def main():
    """主程序入口"""
    args = _parse_arguments()

    # 执行验证
    result = validate_wiki(args.doc_path)

    # 输出结果
    if args.json or args.quiet:
        print(json.dumps(result, ensure_ascii=False, indent=2))
        sys.exit(0 if result["success"] else 1)
    else:
        _print_header(args.doc_path, result.get("doc_type", "未知"))
        _print_errors(result.get("errors", []))
        _print_warnings(result.get("warnings", []))
        _print_summary(result)
        _print_suggestions(result.get("suggestions", []))
        sys.exit(0 if result["success"] else 1)


if __name__ == "__main__":
    main()
