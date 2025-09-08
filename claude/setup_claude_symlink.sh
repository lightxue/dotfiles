#!/bin/bash

# 设置Claude配置目录的软链接
CLAUDE_DIR="$HOME/.claude"
DOTFILES_DIR="$(dirname "$0")"

# 确保 ~/.claude 目录存在
mkdir -p "$CLAUDE_DIR"

# 获取当前目录下所有文件和目录（不包括隐藏文件和本脚本）
items=$(find "$DOTFILES_DIR" -maxdepth 1 \( -type f -o -type d \) -name "*" ! -name ".*" ! -name "setup_claude_symlink.sh")

# 处理每个项目
for item in $items; do
    itemname=$(basename "$item")
    target_item="$CLAUDE_DIR/$itemname"

    echo "处理项目: $itemname"

    # 删除目标目录下的同名文件或目录（如果不是软链接）
    if [ -e "$target_item" ] && [ ! -L "$target_item" ]; then
        echo "  - 删除现有项目: $target_item"
        rm -rf "$target_item"
    fi

    # 创建新的软链接（绝对路径确保可靠性）
    echo "  - 创建软链接: $target_item -> $item"
    ln -sf "$(realpath "$item")" "$target_item"
done

echo "软链接设置完成！"
