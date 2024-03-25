#!/bin/bash
# 在当前路径及其所有字文件中生成_sidebar.md文件
# 生成 _sidebar.md 文件的函数
generate_sidebar() {
  local directory="$1"
  local sidebar_file="${directory}/_sidebar.md"
  
  # 检查目录是否存在
  if [ ! -d "$directory" ]; then
    echo "Error: $directory 不是一个有效的目录。"
    return
  fi
  
  # 清空或创建 Markdown 文件
  > "$sidebar_file"

  # 遍历目录下的文件和文件夹
  for entry in "$directory"/*; do
    # 检查是否为文件
    if [ -f "$entry" ]; then
      echo "   * [${entry##*/}](${entry##*/})" >> "$sidebar_file"
    fi
    # 检查是否为文件夹
    if [ -d "$entry" ]; then
      echo "   * [${entry##*/}/](${entry##*/}/)" >> "$sidebar_file"
      # 递归调用自身处理子文件夹
      generate_sidebar "$entry"
    fi
  done

  echo "已在 $directory 中生成 _sidebar.md 文件。"
}

# 从当前路径开始递归生成 _sidebar.md 文件
generate_sidebar "$(pwd)"
