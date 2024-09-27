#!/bin/bash

# Проверка на количество аргументов
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <log-file-path>"
  exit 1
fi

LOG_FILE=$1

# Проверка на существование файла
if [ ! -f "$LOG_FILE" ]; then
  echo "Log file not found!"
  exit 1
fi

# Общее количество записей в файле лога
total_records=$(wc -l < "$LOG_FILE")

# Количество уникальных файлов
unique_files=$(awk '{ print $1 }' "$LOG_FILE" | sort | uniq | wc -l)

# Количество изменений, приведших к изменению hash файла
changed_hashes=$(awk -F' - ' '{ print $4 }' "$LOG_FILE" | sort | uniq | wc -l)

# Вывод трех чисел
echo "$total_records $unique_files $changed_hashes"
