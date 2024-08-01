#! /bin/bash

if [ -z "$1"]; then
    echo "USAGE: $0 <path-to-tex-file>"
    exit 1
fi

latexmk -pdf -cd $1
latexmk -cd -c $1
rm -f htdocs/resume/*.synctex.gz
