#!/bin/bash

# 设置Claude和CodeBuddy配置目录的软链接
CLAUDE_DIR="$HOME/.claude"
CODEBUDDY_DIR="$HOME/.codebuddy"
DOTFILES_DIR="$(dirname "$0")"

# 确保目录存在
mkdir -p "$CLAUDE_DIR"
mkdir -p "$CODEBUDDY_DIR"

# 获取当前目录下所有文件和目录（不包括隐藏文件和本脚本）
items=$(find "$DOTFILES_DIR" -maxdepth 1 \( -type f -o -type d \) -name "*" ! -name ".*" ! -name "setup_claude_symlink.sh")

# 处理每个项目
for item in $items; do
    itemname=$(basename "$item")
    
    echo "处理项目: $itemname"

    # 处理 ~/.claude 目录
    target_item="$CLAUDE_DIR/$itemname"
    if [ -e "$target_item" ] && [ ! -L "$target_item" ]; then
        echo "  - 删除现有项目: $target_item"
        rm -rf "$target_item"
    fi
    echo "  - 创建软链接: $target_item -> $item"
    ln -sfn "$(realpath "$item")" "$target_item"

    # 处理 ~/.codebuddy 目录
    # 如果是 CLAUDE.md，则重命名为 CODEBUDDY.md
    if [ "$itemname" = "CLAUDE.md" ]; then
        codebuddy_itemname="CODEBUDDY.md"
    else
        codebuddy_itemname="$itemname"
    fi
    
    target_item="$CODEBUDDY_DIR/$codebuddy_itemname"
    if [ -e "$target_item" ] && [ ! -L "$target_item" ]; then
        echo "  - 删除现有项目: $target_item"
        rm -rf "$target_item"
    fi
    echo "  - 创建软链接: $target_item -> $item"
    ln -sfn "$(realpath "$item")" "$target_item"
done

echo "软链接设置完成！"

