#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <action>"
    exit 1
fi
action=$1

full_file_dir="$ZED_DIRNAME"
file="$ZED_FILENAME"

# Extract filename and extension
filename="${file%.*}"
filetype="${file##*.}"

cd "$full_file_dir" || exit

echo -e "${GREEN}[running $file]${NC}"

case $filetype in
c)
    if [ "$action" == "run" ]; then
        clang -O2 -std=c23 "$file" -o "$filename" -lm && ./"$filename"
    elif [ "$action" == "compile" ]; then
        clang -O2 -std=c23 "$file" -o "$filename"
    fi
    ;;
cpp)
    if [ "$action" == "run" ]; then
        clang++ -O2 -std=c++23 "$file" -o "$filename" && ./"$filename"
    elif [ "$action" == "compile" ]; then
        clang++ -O2 -std=c++23 "$file" -o "$filename"
    fi
    ;;
cs)
    if [ "$action" == "run" ]; then
        dotnet run
    elif [ "$action" == "compile" ]; then
        dotnet build
    fi
    ;;
go)
    if [ "$action" == "run" ]; then
        go run "$file"
    elif [ "$action" == "compile" ]; then
        go build -o "$filename" "$file"
    fi
    ;;
java)
    if [ "$action" == "run" ]; then
        javac "$file" && java "${filename%.*}"
    elif [ "$action" == "compile" ]; then
        javac "$file"
    fi
    ;;
js | ts)
    if [ "$action" == "run" ]; then
        node "$file"
    fi
    ;;
lua)
    if [ "$action" == "run" ]; then
        lua "$file"
    fi
    ;;
py)
    if [ "$action" == "run" ]; then
        python3 "$file"
    fi
    ;;
sh)
    if [ "$action" == "run" ]; then
        "bash $file"
    fi
    ;;
*)
    echo -e "${RED}Action not supported for this filetype${NC}"
    exit 1
    ;;
esac
