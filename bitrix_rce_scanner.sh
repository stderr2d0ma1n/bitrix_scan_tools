#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <file_with_urls> [-o]"
    exit 1
fi

file_path=$1
output_all=false

# Проверяем, есть ли опция -o
if [ "$2" == "-o" ]; then
    output_all=true
fi

while IFS= read -r url; do
    # Отправляем запрос POST на bitrix/tools/vote/uf.php
    response_code=$(curl -s -o /dev/null -w "%{http_code}" -X POST "${url}/bitrix/tools/vote/uf.php")
    if [ "$output_all" == true ] || [ "$response_code" == "200" ]; then
        echo "URL: ${url}, Path: /bitrix/tools/vote/uf.php, Response Code: ${response_code}"
    fi

    # Отправляем запрос POST на bitrix/tools/html_editor_action.php
    response_code=$(curl -s -o /dev/null -w "%{http_code}" -X POST "${url}/bitrix/tools/html_editor_action.php")
    if [ "$output_all" == true ] || [ "$response_code" == "200" ]; then
        echo "URL: ${url}, Path: /bitrix/tools/html_editor_action.php, Response Code: ${response_code}"
    fi

    # Отправляем запрос GET на restore.php
    response_code=$(curl -s -o /dev/null -w "%{http_code}" "${url}/bitrix/modules/main/admin/restore.php")
    if [ "$output_all" == true ] || [ "$response_code" == "200" ]; then
        echo "URL: ${url}, Path: /restore.php, Response Code: ${response_code}"
    fi
done < "$file_path"

