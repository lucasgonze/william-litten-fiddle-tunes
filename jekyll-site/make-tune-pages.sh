#!/bin/bash

DATA="/Users/lucasgonze/src/william-litten-fiddle-tunes/tune-metadata/short-names.tsv"
SCANS=`dirname "$DATA"`/../tune-scans

IFS="
"
for line in `sed -e "s/\r//g" "$DATA"`
do
    TITLE=`echo "$line" | awk 'BEGIN { FS="\t" } {print $1}'`
    SLUG=`echo "$line" | awk 'BEGIN { FS="\t" } {print $2}'`

    cp "$SCANS"/$SLUG.jpg tune-scans
    IMG=""
    cat << EOF > tune/$SLUG.md
---
title:  $TITLE
permalink: /tune/$SLUG
layout: single
classes: wide
---

<img src="/tune/scan/$SLUG.jpg" alt="scanned sheet music for $TITLE">

EOF

    echo "<a href='tune/$SLUG'>$TITLE</a><br>" >> index.markdown

done
