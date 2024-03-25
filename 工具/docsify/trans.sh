#!/bin/bash
# 用于快速根据当前目录生成侧边栏文件  

# Markdown 文件名
markdown_file="file_list.md"

# 清空或创建 Markdown 文件
> "$markdown_file"

# 遍历当前目录下的文件和文件夹
for entry in *; do
    # 检查是否为文件
    if [ -f "$entry" ]; then
        echo "* [$entry]($entry)" >> "$markdown_file"
    fi
    # 检查是否为文件夹
    if [ -d "$entry" ]; then
        echo "* [$entry/]($entry/)" >> "$markdown_file"
    fi
done

echo "Markdown 文件已生成: $markdown_file"

