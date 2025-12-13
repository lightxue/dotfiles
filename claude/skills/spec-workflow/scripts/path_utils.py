#!/usr/bin/env python3
"""
路径工具模块 - 提供跨场景兼容的路径解析

遵循 Claude 官方 skills 最佳实践：
1. 基于 __file__ 的相对路径
2. 只关心 skill 内部结构，不依赖安装位置
3. 从当前工作目录查找项目文件

适用场景：
- ✅ 项目 skills：/项目/.codebuddy/skills/spec-workflow/
- ✅ 用户 skills：~/.codebuddy/skills/spec-workflow/
- ✅ 任意自定义位置
"""

from __future__ import annotations
from pathlib import Path


def get_skill_root() -> Path:
    """获取 skill 根目录

    返回：spec-workflow/ 目录的绝对路径
    """
    # 从任意 scripts/ 下的脚本调用，向上2级到 skill 根目录
    # scripts/path_utils.py -> scripts/ -> spec-workflow/
    return Path(__file__).parent.parent


def get_project_root() -> Path:
    """获取项目根目录

    返回：当前工作目录（假定脚本从项目根目录执行）
    """
    return Path.cwd()


def find_wiki_file() -> Path | None:
    """从项目根目录查找 wiki 文件

    返回：
        找到的 wiki 文件路径，或 None
    """
    project_root = get_project_root()
    for path in [project_root / "doc" / "iwiki.md", project_root / "docs" / "iwiki.md"]:
        if path.exists():
            return path
    return None


def find_wiki_docs_dir() -> Path | None:
    """从项目根目录查找 1+3 文档目录

    返回：
        找到的文档目录路径，或 None（仅查找 doc/）
    """
    project_root = get_project_root()
    path = project_root / "doc"
    if path.exists() and path.is_dir():
        return path
    return None


def find_design_files() -> list[Path]:
    """从项目根目录查找所有设计文档

    返回：
        设计文档路径列表
    """
    project_root = get_project_root()
    specs_dir = project_root / ".specs"

    if not specs_dir.exists():
        return []

    design_files: list[Path] = []
    for spec_dir in specs_dir.glob("*/"):
        design_file = spec_dir / "design.md"
        if design_file.exists():
            design_files.append(design_file)

    return design_files


def find_preparation_files() -> list[Path]:
    """从项目根目录查找所有前置准备文档

    返回：
        前置准备文档路径列表
    """
    project_root = get_project_root()
    specs_dir = project_root / ".specs"

    if not specs_dir.exists():
        return []

    preparation_files: list[Path] = []
    for spec_dir in specs_dir.glob("*/"):
        preparation_file = spec_dir / "preparation.md"
        if preparation_file.exists():
            preparation_files.append(preparation_file)

    return preparation_files


def find_tasks_files() -> list[Path]:
    """从项目根目录查找所有任务计划文档

    返回：
        任务计划文档路径列表
    """
    project_root = get_project_root()
    specs_dir = project_root / ".specs"

    if not specs_dir.exists():
        return []

    tasks_files: list[Path] = []
    for spec_dir in specs_dir.glob("*/"):
        tasks_file = spec_dir / "tasks.md"
        if tasks_file.exists():
            tasks_files.append(tasks_file)

    return tasks_files


# Skill 内部资源路径
SKILL_ROOT = get_skill_root()

# 验证脚本路径（相对于 skill 根目录）
VALIDATE_WIKI_SCRIPT = SKILL_ROOT / "scripts" / "validate_wiki.py"
VALIDATE_DESIGN_SCRIPT = SKILL_ROOT / "scripts" / "validate_design.py"
VALIDATE_TASKS_SCRIPT = SKILL_ROOT / "scripts" / "validate_tasks.py"
