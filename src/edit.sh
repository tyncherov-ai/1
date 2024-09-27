#!/bin/bash

# Проверка на количество аргументов
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <file-path> <search-string> <replacement-string>"
  exit 1
fi

file=$1
replacement_string=$2
replacement=$3
file_log_path="src/files.log"

# strint replacement

# Проверка на существование файла
if [ ! -f "$file" ]; then
  echo "File not found!"
  exit 1
fi

sed -i "s/$replacement_string/$replacement/g" "$file"

# get information about file
file_size=$(stat --format="%s" "$file")
# modified_date=$(stat --format="%y" "$file")
modified_date=$(date -r "$file" "+%Y-%m-%d %H:%M:%S")
sha256_sum=$(sha256sum "$file" | awk '{ print $1 }')

# Проверка на существование файла журнала
if [ ! -f "$file_log_path" ]; then
  echo "Log file not found, creating new one."
  touch "$file_log_path"
fi

# writing to log file
res="$file - $file_size - $modified_date - $sha256_sum - sha256" 

echo "$res" >> "$file_log_path"
