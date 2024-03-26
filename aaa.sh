#!/bin/bash
generate_sidebar() {
    local cur_directory="$1"
    local files_and_dirs=$(find "$cur_directory" -mindepth 1 -maxdepth 1  !  -path "*/img/*" !  -path "*/.git/*" ! -name "_*" ! -name "README.md" )
    #echo "$files_and_dirs"
    local sidebar_file="${cur_directory}/_sidebar.md"
    local sidebar_file_ab
    # 得到sidebar所在的文件夹
    sidebar_file_ab=$(dirname  "${sidebar_file}")

    if [ ! -d "$cur_directory" ]; then
        echo "Error: $cur_directory 不是一个有效的目录。"
        return
    fi
  
    # 清空或创建 Markdown 文件
    > "$sidebar_file"
    # 写入当前目录信息
    echo "* ${cur_directory##*/}" >> "$sidebar_file"

 
    for entry in $files_and_dirs; do
        # 取绝对路径，寻找相同的加到sidebar中
        entry_absolute_path=$(dirname  "${entry}")

        #echo "$entry_absolute_path"
        #echo "$sidebar_file_ab"
        #echo "$entry"
        #echo "---"

        # 如果是文件夹
        if [ -d "$entry" ] ; then
            # 判断当前文件夹是不是sidebar所在文件夹
            if [ "$entry_absolute_path" = "$sidebar_file_ab" ]; then
                dirname=$(basename "$entry")
                dirname_no_slash="${dirname%/}"  # 去掉文件夹名中的斜杠字符
                echo "   * [${dirname_no_slash}](${dirname_no_slash}/)" >> "$sidebar_file"
            fi
            generate_sidebar "$entry"
        fi
        # 如果是文件
        if [ -f "$entry" ] ; then
            if [ "$entry_absolute_path" = "$sidebar_file_ab" ]; then
                filename=$(basename "$entry")
                filename_no_ext="${filename%.*}"  # 去掉文件后缀
                echo "   * [${filename_no_ext}](${filename})" >> "$sidebar_file"
            fi
        fi
    done
}

generate_sidebar "/home/awjl/notes"
