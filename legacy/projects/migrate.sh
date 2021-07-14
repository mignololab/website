#!/bin/bash

set -e

get_value() {
  sed -e 's/.* value="\(.*\)".*/\1/'
}

convert_date() {
  awk -F'/' '{print $3 "-" $2 "-" $1}'
}

difficulty_label() {
  case "$1" in
    'BASSA')
      echo 'low'
      ;;
    'MEDIA')
      echo 'medium'
      ;;
    'ALTA')
      echo 'high'
      ;;
    *)
      echo >&2 "Sconosciuto: $1"
      exit 1
  esac
}

for i in */; do
  proj_slug="${i%/}"
  echo $proj_slug
  content_file="${proj_slug}/index.shtml"
  metadata_file="${proj_slug}/info.shtml"
  proj_title=$(grep PROJECT_NAME "${metadata_file}" | get_value)
  proj_summary=$(grep PROJECT_OVERVIEW "${metadata_file}" | get_value)
  proj_date=$(grep PROJECT_DATE "${metadata_file}" | get_value | convert_date)
  proj_poster=$(grep PROJECT_IMAGE "${metadata_file}" | get_value)
  proj_difficulty_label=$(grep "difficulty" "${content_file}" | sed -e 's/.*Difficolt&agrave;: \(.*\)<\/span>.*/\1/')
  proj_difficulty=$(difficulty_label "$proj_difficulty_label")
  echo $proj_difficulty

  mkdir -p "../_posts/${proj_slug}"
  cat <<EOF >"../_posts/${proj_slug}/${proj_date}-${proj_slug}.html"
---
layout: project
title: "${proj_title}"
summary: "${proj_summary}"
category: difficulty-${proj_difficulty}
poster: ${proj_poster}
permalink: /projects/:title/
---
EOF

  # append content (removing the page header and the SSI includes)
  tail -n +7 "${content_file}" | head -n -1 >>"../_posts/${proj_slug}/${proj_date}-${proj_slug}.html"

  # copy images
  cp -R "${proj_slug}/images" "../_posts/${proj_slug}"
done
