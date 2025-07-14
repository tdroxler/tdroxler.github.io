#!/usr/bin/env bash

SONGS_DIR="songs"
OUTPUT="songs.json"

# Find all .cho files, build JSON lines
find "$SONGS_DIR" -type f -name "*.cho" | \
while read -r file; do
  # Path relative to public/
  relpath="${file#public/}"
  # Folder relative to public/songs
  folder=$(dirname "${file#public/songs/}")
  [ "$folder" = "." ] && folder="" # root folder becomes empty
  # Title is filename without extension
  fname=$(basename "$file")
  title="${fname%.cho}"
  # Emit JSON object
  printf '{ "title": "%s", "path": "%s", "folder": "%s" }\n' \
    "$title" "$relpath" "$folder"
done | \
# Combine into a JSON array using jq
jq -s '.' > "$OUTPUT"
