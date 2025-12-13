#!/usr/bin/env python3
"""
验证设计方案文档（design.md）的完整性

检查项：
- 必需章节是否存在
- mermaid 图语法是否正确
- 歧义清单格式是否规范
- 文档头信息是否完整

返回格式：JSON
退出码：0=成功, 1=验证失败, 2=异常错误
"""

import sys
import re
import json
from pathlib import Path
from typing import Any

# 必需章节列表（基于 design.md.template）
REQUIRED_SECTIONS = [
    "概述",  # 包含「需求说明」「迭代目标」「项目现状分析」
    "歧义与待确认清单",
    "架构设计",
    "改动分析",  # 包含「新增模块」「修改模块」，「删除模块」为可选
    "依赖服务调用",
    "接口与数据",
    "技术难点与对策",
    "风险识别与应对"  # 精简后：删除了"测试策略"、"灰度方案"、"回滚方案"
]

# 必需子章节（提高文档质量要求）
REQUIRED_SUBSECTIONS = {
    "概述": ["需求说明", "迭代目标", "项目现状分析"],
    "歧义与待确认清单": ["需求理解疑问", "技术方案待定项", "边界条件确认"],
    "架构设计": ["整体架构", "改动说明"],
    "改动分析": ["新增模块", "修改模块"]  # 删除模块为可选章节
    # 注意："接口与数据"子章节为可选（根据实际需求可能为空）
    # 注意："依赖服务调用"有互斥子章节，由专门函数验证
    # 精简后：删除了"测试策略"、"灰度方案"、"回滚方案"的必需性检查
    # 原因：测试策略属于执行阶段、灰度/回滚属于运维SOP，不应在设计文档中强制要求
}

# 文档头必需字段（基于 design.md.template）
REQUIRED_HEADERS = [
    "创建时间",
    "需求来源"
]


def validate_file_exists(file_path: str) -> bool:
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
    - 文件名必须为 design.md
    - 建议在 .specs/ 目录下
    - 目录命名格式：{feature_name}-{requirement_id}
    - requirement_id 格式：TAPD为19位数字，文字描述为YYYYMMDDXXX
    """
    errors: list[str] = []
    warnings: list[str] = []

    path = Path(file_path)

    # 1. 检查文件名
    if path.name != 'design.md':
        errors.append(f"文件名错误：期望 'design.md'，实际 '{path.name}'")

    # 2. 检查是否在 .specs/ 目录下
    path_str = str(path.resolve())
    if '.specs' not in path_str:
        warnings.append((
            f"建议将文件放在 .specs/ 目录下\n"
            f"  当前路径：{path_str}\n"
            f"  推荐路径：.specs/{{feature_name}}-{{requirement_id}}/design.md"
        ))
    else:
        # 3. 检查目录命名格式
        parent_name = path.parent.name

        if '-' not in parent_name:
            warnings.append((
                f"目录命名不符合规范：'{parent_name}'\n"
                f"  期望格式：{{feature_name}}-{{requirement_id}}\n"
                f"  示例：h5-subscribe-optimize-1020426960128093915"
            ))
        else:
            # 分离 feature_name 和 requirement_id（简化版本）
            parts = parent_name.rsplit('-', 1)
            if len(parts) == 2:
                feature_name, _ = parts

                # 验证 feature_name（基本检查）
                if not feature_name:
                    warnings.append("feature_name 不能为空")
                elif not re.match(r'^[a-z0-9-]+$', feature_name):
                    warnings.append((
                        f"feature_name 建议使用小写字母、数字和连字符：'{feature_name}'\n"
                        f"  推荐格式：user-login, h5-subscribe-optimize"
                    ))

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


def validate_sections(content: str) -> tuple[list[str], list[str]]:
    """验证必需章节和子章节（基于 design.md.template）

    支持的章节层级和格式：
    - ## 章节名（二级标题）
    - ### 章节名（三级标题）
    - #### 章节名（四级标题）
    - ## 1. 章节名（带序号）
    """
    errors: list[str] = []
    warnings: list[str] = []

    # 1. 验证必需主章节
    for section in REQUIRED_SECTIONS:
        # 支持带序号和不带序号两种格式
        pattern1 = r'^##\s+' + re.escape(section) + r'(?:\s|$)'
        pattern2 = r'^##\s+\d+\.\s*' + re.escape(section) + r'(?:\s|$)'

        if not (re.search(pattern1, content, re.MULTILINE) or re.search(pattern2, content, re.MULTILINE)):
            errors.append(f"缺少必需章节：## {section}")

    # 2. 验证必需子章节（更严格的质量要求）
    for main_section, subsections in REQUIRED_SUBSECTIONS.items():
        # 先找到主章节内容
        # 修复：使用 ^##\s+(?!#) 确保只匹配两个 # 的标题
        # 不匹配 ### 或更多
        section_pattern = (
            r'^##\s+(?!#)(?:\d+\.\s*)?' +
            re.escape(main_section) +
            r'\s*(.*?)(?=^##\s+(?!#)|\Z)'
        )
        section_match = re.search(section_pattern, content, re.DOTALL | re.MULTILINE)

        if section_match:
            section_content = section_match.group(1)

            # 检查每个必需子章节
            for subsection in subsections:
                # 匹配三级或四级标题
                sub_pattern1 = r'^###\s+(?:\d+\.\d+\.?\s*)?' + re.escape(subsection)
                sub_pattern2 = r'^####\s+(?:\d+\.\d+\.\d+\.?\s*)?' + re.escape(subsection)

                if not (re.search(sub_pattern1, section_content, re.MULTILINE) or
                        re.search(sub_pattern2, section_content, re.MULTILINE)):
                    warnings.append(
                        f"建议在「{main_section}」章节添加子章节：### {subsection}"
                    )

    return errors, warnings


def validate_mermaid(content: str) -> tuple[list[str], list[str]]:
    """验证 mermaid 图语法"""
    errors: list[str] = []
    warnings: list[str] = []

    # 查找所有 mermaid 代码块
    mermaid_blocks = re.findall(r'```mermaid\n(.*?)\n```', content, re.DOTALL)

    if not mermaid_blocks:
        warnings.append("未找到 mermaid 流程图，建议添加架构图")

    for i, block in enumerate(mermaid_blocks, 1):
        # 基本语法检查
        if not block.strip():
            errors.append(f"第 {i} 个 mermaid 图为空")
            continue

        # 检查是否有图类型声明
        graph_types = ['graph', 'sequenceDiagram', 'classDiagram', 'stateDiagram', 'erDiagram']
        has_type = any(gtype in block for gtype in graph_types)
        if not has_type:
            errors.append(f"第 {i} 个 mermaid 图缺少图类型声明")

    return errors, warnings


def validate_ambiguity_list(content: str) -> tuple[list[str], list[str]]:
    """验证歧义与待确认清单格式（强制检查未勾选项）"""
    errors: list[str] = []
    warnings: list[str] = []

    # 查找歧义与待确认清单章节（支持 ## 或 # 标题）
    ambiguity_pattern = r'#{1,2}\s+歧义与待确认清单(.*?)(?=\n#{1,2}\s+|\Z)'
    match = re.search(ambiguity_pattern, content, re.DOTALL)

    if not match:
        errors.append("缺少「歧义与待确认清单」章节")
        return errors, warnings

    ambiguity_section = match.group(1)

    # 检查是否明确标注「无」
    if '无' in ambiguity_section or '「无」' in ambiguity_section:
        return errors, warnings  # 明确标注无歧义，通过检查

    # 查找所有未勾选的待确认项（- [ ] 或 - []）
    unchecked_items = re.findall(r'-\s*\[\s*\]\s*(.+)', ambiguity_section)

    # 查找所有已勾选的待确认项（- [x] 或 - [X]）
    checked_items = re.findall(r'-\s*\[[xX]\]\s*(.+)', ambiguity_section)

    # 关键检查：如果有未勾选项，作为 ERROR 而非 warning
    if unchecked_items:
        errors.append(
            f"❌ 存在 {len(unchecked_items)} 个未解决的待确认问题，必须全部澄清后才能审批通过！"
        )
        # 列出前3个未解决的问题
        for i, item in enumerate(unchecked_items[:3], 1):
            errors.append(f"   {i}. [ ] {item.strip()}")
        if len(unchecked_items) > 3:
            errors.append(f"   ... 还有 {len(unchecked_items) - 3} 个未解决问题")
        errors.append("")
        errors.append("💡 解决方法：")
        errors.append("   1. 逐一澄清每个待确认问题")
        errors.append("   2. 将已澄清的问题改为 - [x]（勾选）")
        errors.append("   3. 或明确标注「无」如果确实没有待确认问题")

    # 如果既没有待确认项，也没有标注「无」
    if not unchecked_items and not checked_items:
        warnings.append("歧义与待确认清单为空，如无歧义请明确标注「无」")

    return errors, warnings


def validate_dependency_services(content: str) -> tuple[list[str], list[str]]:
    """验证依赖服务调用章节（与模板保持一致）

    模板定义了3个互斥的子章节：
    - ### 医保服务依赖（如不涉及请删除此小节）
    - ### 通用组件依赖（如不涉及请删除此小节）
    - ### 无依赖服务调用（如涉及依赖服务请删除此小节）

    验证规则：必须至少包含其中1个子章节
    """
    errors: list[str] = []
    warnings: list[str] = []

    # 查找依赖服务调用章节（修复：使用 (?!#) 确保只匹配二级标题）
    dependency_pattern = r'##\s+(?!#)依赖服务调用(.*?)(?=^##\s+(?!#)|\Z)'
    match = re.search(dependency_pattern, content, re.DOTALL | re.MULTILINE)

    if not match:
        errors.append("缺少「依赖服务调用」章节")
        return errors, warnings

    section_content = match.group(1).strip()

    # 检查3个互斥子章节是否至少存在1个
    has_medical_service = bool(re.search(r'###\s+医保服务依赖', section_content))
    has_common_component = bool(re.search(r'###\s+通用组件依赖', section_content))
    has_no_dependency = bool(re.search(r'###\s+无依赖服务调用', section_content))

    # 统计有多少个子章节
    subsection_count = sum([has_medical_service, has_common_component, has_no_dependency])

    if subsection_count == 0:
        errors.append(
            "「依赖服务调用」章节必须包含以下子章节之一：\n"
            "  - ### 医保服务依赖（如不涉及请删除此小节）\n"
            "  - ### 通用组件依赖（如不涉及请删除此小节）\n"
            "  - ### 无依赖服务调用（如涉及依赖服务请删除此小节）"
        )
    elif subsection_count > 1:
        # 如果同时存在多个子章节，给出警告（通常应该删除不相关的）
        present_subsections = []
        if has_medical_service:
            present_subsections.append("医保服务依赖")
        if has_common_component:
            present_subsections.append("通用组件依赖")
        if has_no_dependency:
            present_subsections.append("无依赖服务调用")

        warnings.append(
            f"「依赖服务调用」章节包含多个子章节：{', '.join(present_subsections)}\n"
            "  建议：如果有依赖服务，删除「无依赖服务调用」；如果无依赖，删除其他子章节"
        )

    return errors, warnings


def validate_interfaces_and_data(content: str) -> tuple[list[str], list[str]]:
    """验证接口与数据章节（允许子章节为空）

    模板定义了3个子章节：
    - ### 新增接口（可能为空）
    - ### 修改接口（可能为空）
    - ### 数据模型（可能为空）

    验证规则：至少需要说明是否有接口改动
    """
    errors: list[str] = []
    warnings: list[str] = []

    # 查找接口与数据章节
    interface_pattern = r'##\s+(?!#)接口与数据(.*?)(?=^##\s+(?!#)|\Z)'
    match = re.search(interface_pattern, content, re.DOTALL | re.MULTILINE)

    if not match:
        errors.append("缺少「接口与数据」章节")
        return errors, warnings

    section_content = match.group(1).strip()

    # 检查是否有基本的子章节说明
    has_new_interface = bool(re.search(r'###\s+新增接口', section_content))
    has_modified_interface = bool(re.search(r'###\s+修改接口', section_content))
    has_data_model = bool(re.search(r'###\s+数据模型', section_content))

    # 如果3个子章节都没有，给出警告
    if not (has_new_interface or has_modified_interface or has_data_model):
        warnings.append(
            "「接口与数据」章节建议包含以下子章节之一：\n"
            "  - ### 新增接口（如无新增接口可标注「无」）\n"
            "  - ### 修改接口（如无修改接口可标注「无」）\n"
            "  - ### 数据模型（如无数据模型可标注「无」）"
        )

    return errors, warnings


def validate_design(file_path: str) -> dict[str, Any]:
    """主验证函数 - 返回结构化数据"""
    all_errors: list[str] = []
    all_warnings: list[str] = []

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
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except (IOError, OSError) as e:
        return {
            "success": False,
            "errors": [f"读取文件失败: {str(e)}"],
            "warnings": [],
            "suggestions": ["检查文件编码是否为 UTF-8", "确认文件权限"]
        }

    # 4. 验证文档头信息
    errors = validate_headers(content)
    all_errors.extend(errors)

    # 5. 验证必需章节和子章节
    errors, warnings = validate_sections(content)
    all_errors.extend(errors)
    all_warnings.extend(warnings)

    # 6. 验证 mermaid 图
    errors, warnings = validate_mermaid(content)
    all_errors.extend(errors)
    all_warnings.extend(warnings)

    # 7. 验证歧义清单
    errors, warnings = validate_ambiguity_list(content)
    all_errors.extend(errors)
    all_warnings.extend(warnings)

    # 8. 验证依赖服务
    errors, warnings = validate_dependency_services(content)
    all_errors.extend(errors)
    all_warnings.extend(warnings)

    # 9. 验证接口与数据
    errors, warnings = validate_interfaces_and_data(content)
    all_errors.extend(errors)
    all_warnings.extend(warnings)

    # 构建修复建议
    suggestions = []
    if all_errors:
        suggestions.append("请修复上述错误后重新验证")
        if "缺少必需章节" in str(all_errors):
            suggestions.append("参考 assets/templates/design.md.template 模板补充缺失章节")
        if "缺少文档头字段" in str(all_errors):
            suggestions.append("参考 assets/templates/design.md.template 模板补充文档头")

    if all_warnings and not all_errors:
        suggestions.append("建议改进警告项后再提交审批")

    # 返回结构化结果
    return {
        "success": len(all_errors) == 0,
        "errors": all_errors,
        "warnings": all_warnings,
        "suggestions": suggestions,
        "stats": {
            "error_count": len(all_errors),
            "warning_count": len(all_warnings)
        }
    }


def main() -> None:
    """主程序入口 - 支持 JSON 输出模式"""
    import argparse  # pylint: disable=import-outside-toplevel

    parser = argparse.ArgumentParser(
        description='验证设计方案文档格式规范',
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    _ = parser.add_argument('file_path', help='设计方案文档路径（如 .specs/xxx/design.md）')
    _ = parser.add_argument('--json', action='store_true', help='JSON 格式输出（用于自动化）')
    _ = parser.add_argument('--quiet', action='store_true', help='静默模式（仅输出 JSON）')

    args = parser.parse_args()

    # 执行验证
    result = validate_design(args.file_path)

    # JSON 输出模式
    if args.json or args.quiet:
        print(json.dumps(result, ensure_ascii=False, indent=2))
        sys.exit(0 if result["success"] else 1)

    # 人类可读输出模式（原有格式）
    print(f"\n{'='*60}")
    print(f"📄 验证设计方案文档：{args.file_path}")
    print(f"{'='*60}\n")

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
        print("✅ 所有检查通过！设计方案文档格式规范。\n")
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
