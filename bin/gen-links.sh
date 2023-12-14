#!/usr/bin/env bash

trap 'echo "Error on line $LINENO. Exit code: $?" >&2' ERR

set -o errexit
set -o pipefail
set -o errtrace

# Add recipe links to main index file
for f in $(find recipes -type f -name '*.html'); do
    title="$(grep -oP '(?<=<title>)(.*)(?=</title>)' $f)"
    link="<li><a href=\"./$f\">$title</a></li>"
    sed -i "/<!-- End Recipe List -->/ i $link" index.html
done
