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

if [ "$action" == "run" ]; then
    echo -e "${GREEN}[Running $file]${NC}"
else
    echo -e "${GREEN}[Compiling/Building $file]${NC}"
fi

case $filetype in
c)
    if [ "$action" == "run" ]; then
        clang -O2 -std=c23 "$file" -o "$filename" -lm && ./"$filename"
    else
        clang -O2 -std=c23 "$file" -o "$filename"
    fi
    ;;
cpp)
    if [ "$action" == "run" ]; then
        clang++ -O2 -std=c++23 "$file" -o "$filename" && ./"$filename"
    else
        clang++ -O2 -std=c++23 "$file" -o "$filename"
    fi
    ;;
cs)
    if [ "$action" == "run" ]; then
        dotnet run
    else
        dotnet build
    fi
    ;;
go)
    if [ "$action" == "run" ]; then
        go run "$file"
    else
        go build -o "$filename" "$file"
    fi
    ;;
java)
    if [ "$action" == "run" ]; then
        javac "$file" && java "${filename%.*}"
    else
        javac "$file"
    fi
    ;;
js | ts)
    if [ "$action" == "run" ]; then
        bun "$file"
    else
        echo -e "${RED}Action not supported for this filetype${NC}"
    fi
    ;;
lua)
    if [ "$action" == "run" ]; then
        lua "$file"
    else
        echo -e "${RED}Action not supported for this filetype${NC}"
    fi
    ;;
py)
    if [ "$action" == "run" ]; then
        python3 "$file"
    else
        echo -e "${RED}Action not supported for this filetype${NC}"
    fi
    ;;
sh)
    if [ "$action" == "run" ]; then
        bash "$file"
    else
        echo -e "${RED}Action not supported for this filetype${NC}"
    fi
    ;;
*)
    echo -e "${RED}Action not supported for this filetype${NC}"
    exit 1
    ;;
esac
