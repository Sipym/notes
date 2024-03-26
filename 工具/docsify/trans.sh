#!/bin/bash

# 生成 _sidebar.md 文件的函数
generate_sidebar() {
  local directory="$1"
  local sidebar_file="${directory}/_sidebar.md"
  local current_dir="${directory##*/}"  # 获取当前目录名
  
  # 检查目录是否存在
  if [ ! -d "$directory" ]; then
    echo "Error: $directory 不是一个有效的目录。"
    return
  fi
  
  # 清空或创建 Markdown 文件
  > "$sidebar_file"

  # 写入当前目录信息
  echo "* ${current_dir}" >> "$sidebar_file"

  # 遍历目录下的文件和文件夹
  for entry in "$directory"/*; do
    # 检查是否为文件
    if [ -f "$entry" ]; then
      filename=$(basename "$entry")
      filename_no_ext="${filename%.*}"  # 去掉文件后缀
      echo "   * [${filename_no_ext}](${filename_no_ext})" >> "$sidebar_file"
    fi
    # 检查是否为文件夹
    if [ -d "$entry" ]; then
      dirname=$(basename "$entry")
      echo "   * [${dirname}](${dirname}/)" >> "$sidebar_file"
      # 递归调用自身处理子文件夹
      generate_sidebar "$entry"
    fi
  done

  echo "已在 $directory 中生成 _sidebar.md 文件。"
}

# 从当前路径开始递归生成 _sidebar.md 文件
generate_sidebar "$(pwd)"
