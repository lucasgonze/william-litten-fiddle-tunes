#!/bin/bash

BASE=`dirname "$0"`/..
DATA="$BASE/tune-metadata/short-names.tsv"
SCANS="$BASE/tune-scans"
EMBEDDED_LIST="$BASE/jekyll-site/_includes/tune-list.md"
PUBLIC_SCANS="$BASE/jekyll-site/tune-scans"

echo "" > "$EMBEDDED_LIST"
mkdir -p "$PUBLIC_SCANS"

IFS="
"
for line in `sed -e "s/\r//g" "$DATA"`
do
    TITLE=`echo "$line" | awk 'BEGIN { FS="\t" } {print $1}'`
    SLUG=`echo "$line" | awk 'BEGIN { FS="\t" } {print $2}'`
    PUBLIC_MARKDOWN="$BASE/jekyll-site/tune/$SLUG.md"

    cp "$SCANS"/$SLUG.jpg "$PUBLIC_SCANS"
    cat << EOF > "$PUBLIC_MARKDOWN"
---
title:  $TITLE
permalink: /tune/$SLUG.html
layout: single
classes: wide
---
{% include tune-markdown.md slug="$SLUG" title="$TITLE" %}
EOF

    # TOC published in the home page
    echo "<a href='/tune/$SLUG.html'>$TITLE</a><br>" >> "$EMBEDDED_LIST"

done
