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
    entry_absolute_path=$(realpath "$entry")
    # 检查是否为文件夹，并且排除名为 img 和 _sidebar.md 的文件夹
    if [ -d "$entry" ] && [ "${entry##*/}" != "img" ] && [ "${entry##*/}" != "_sidebar.md" ] && [ "$entry_absolute_path" == "${directory}"/* ]; then
      dirname=$(basename "$entry")
      dirname_no_slash="${dirname%/}"  # 去掉文件夹名中的斜杠字符
      echo "   * [${dirname_no_slash}](${dirname_no_slash}/)" >> "$sidebar_file"
      # 递归调用自身处理子文件夹
      generate_sidebar "$entry"
    fi
    # 检查是否为文件，并排除下划线开头、README.md 和 index.html 文件
    if [ -f "$entry" ] && [ "${entry##*/}" != "_sidebar.md" ] && [ "${entry##*/}" != "README.md" ] && [ "${entry##*/}" != "index.html" ] && [[ "${entry##*/}" != _* ]] && [ "$entry_absolute_path" == "${directory}"/* ]; then
      filename=$(basename "$entry")
      filename_no_ext="${filename%.*}"  # 去掉文件后缀
      echo "   * [${filename_no_ext}](${filename})" >> "$sidebar_file"
    fi
  done

  echo "已在 $directory 中生成 _sidebar.md 文件。"
}

# 从当前路径开始递归生成 _sidebar.md 文件
generate_sidebar "$(pwd)"
