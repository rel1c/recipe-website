#!/usr/bin/env bash

trap 'echo "Error on line $LINENO. Exit code: $?" >&2' ERR

set -o errexit errtrace pipefail

template="/usr/local/apache2/htdocs/template.html"

for f in $(find recipes -type f -name '*.md'); do
    # skip the recipe skeleton file
    if [[ "$f" =~ skel.md ]]; then
        continue
    fi

    # build markdown header for pandoc
    title="$(grep --max-count 1 '^# .*$' "$f")"
    date="$(date '+%B %e, %Y' -d "$(stat -c '%y' "$f")")"
    echo -e "---\ntitle: ${title:2}\ndate: $date\n---" > tmp
    cat "$f" >> tmp

    # if image for recipe exists, add it to markdown as html block
    img="$(basename --suffix=.md "$f").jpg"
    if [ -f "images/$img" ]; then
        block="<img src=\"../images/$img\" alt="\"${title:2}\"" width=\"300\" height=\"300\">\n"
        sed -i "/^## Ingredients$/i$block" tmp
    fi

    # convert markdown to html
    target="$(basename --suffix=.md "$f").html"
    content="$(pandoc \
            --from markdown \
            --to html \
            --standalone \
            --template $template tmp)"
    echo "$content" >> recipes/"$target"

    # clean up for next loop iteration
    rm tmp
done
