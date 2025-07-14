#!/usr/bin/env bash
#
# OUTPUT="songs.json"
#
# # Find all .cho files, build JSON lines
# find "public" -type f -name "*.cho" | \
# while read -r file; do
#   echo $file
#   # # Path relative to public/
#   # # Folder relative to public/songs
#   # folder=$(dirname "${file#public/songs/}")
#   # [ "$folder" = "." ] && folder="" # root folder becomes empty
#   # # Title is filename without extension
#   # fname=$(basename "$file")
#   # title="${fname%.cho}"
#   # # Emit JSON object
#   # printf '{ "title": "%s", "path": "%s", "folder": "%s" }\n' \
#   #   "$title" "$file" "$folder"
# done #| \
# # Combine into a JSON array using jq
# #jq -s '.' > "$OUTPUT"

OUTPUT="songs.json"

find "public" -type f -name "*.cho" | \
while read -r file; do
   fname=$(basename "$file")
   title="${fname%.cho}"
   relpath="${file#public/}"  # remove "public/" prefix
   printf '{ "title": "%s", "path": "%s" }\n' \
     "$title" "$relpath"
done | \
jq -s '.' > "$OUTPUT"
