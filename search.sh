#!/bin/bash

if [ -z "$1" ]; then
    echo "Ошибка"
    exit 1
fi
oldWord="$1"
newWord="$2"
output="output.txt"
expansion=".txt"

find . -name "*${expansion}" -type f -print0 | while IFS= read -r -d '' file; do
    if grep -q "${oldWord}" $file; then
	sed -i "s/$oldWord/$newWord/g" "$file"
	echo "$file" >> "${output}"
    fi
done
echo "done"
