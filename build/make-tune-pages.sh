#!/bin/bash

BASE=`dirname "$0"`/..
DATA="$BASE/tune-metadata/short-names.tsv"
SCANS="$BASE/tune-scans"
EMBEDDED_LIST="$BASE/jekyll-site/_includes/tune-list.md"

echo "" > "$EMBEDDED_LIST"

IFS="
"
for line in `sed -e "s/\r//g" "$DATA"`
do
    TITLE=`echo "$line" | awk 'BEGIN { FS="\t" } {print $1}'`
    SLUG=`echo "$line" | awk 'BEGIN { FS="\t" } {print $2}'`
    PUBLIC_MARKDOWN="$BASE/jekyll-site/tune/$SLUG.md"
    PUBLIC_SCANS="$BASE/jekyll-site/tune-scans"

    cp "$SCANS"/$SLUG.jpg "$PUBLIC_SCANS"
    cat << EOF > "$PUBLIC_MARKDOWN"
---
title:  $TITLE
permalink: /tune/$SLUG
layout: single
classes: wide
---

<img src="/tune/scan/$SLUG.jpg" alt="scanned sheet music for $TITLE">

EOF

    echo "<a href='tune/$SLUG'>$TITLE</a><br>" >> "$EMBEDDED_LIST"

done
