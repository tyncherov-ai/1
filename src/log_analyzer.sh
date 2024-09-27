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

# Общее количество записей (число строк в файле)
total_records=$(wc -l < "$LOG_FILE")

# Количество уникальных файлов
unique_files=$(awk -F' - ' '{print $1}' "$LOG_FILE" | sort | uniq | wc -l)

# Количество изменений, приведших к изменению хэш-суммы
hash_changes=$(awk -F' - ' '{print $1, $5}' "$LOG_FILE" | sort | uniq | wc -l)

# Вывод результатов
echo "$total_records $unique_files $hash_changes"
