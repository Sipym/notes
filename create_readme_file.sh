#!/bin/bash
#!/bin/bash

# 查找所有文件夹并在每个文件夹中创建 README.md
find . -type d ! -path "*/img" ! -path "*/.git/*" ! -path "*/static/*" ! -path "*/jyyslide-md" -exec sh -c '
    for dir; do
        # 检查是否存在 README.md
        if [ ! -f "$dir/README.md" ]; then
            # 创建 README.md 文件并写入内容
            echo "Creating README.md in $dir"
            echo "None" > "$dir/README.md"
        else
            echo "README.md already exists in $dir"
        fi
    done
' sh {} +

