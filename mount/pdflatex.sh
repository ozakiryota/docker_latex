#!/bin/bash

set -e

if [ "$#" -ne 1 ] && [ "$#" -ne 2 ]; then
    echo "Error: Usage: ./eng_tex_to_pdf.sh TEX_PATH [BIB_PATH]"
    exit 1
fi

tex_path="$1"
tex_name=$(basename "$tex_path")
tex_name_without_extension="${tex_name%.tex}"
tex_dir=$(dirname "$tex_path")
(
    cd "$tex_dir" || exit 1
    sed -i 's/、/，/g' "$tex_name"
    sed -i 's/。/．/g' "$tex_name"
    pdflatex -interaction=nonstopmode -halt-on-error "$tex_name"
    biber "$tex_name_without_extension"
    pdflatex -interaction=nonstopmode -halt-on-error "$tex_name"
    pdflatex -interaction=nonstopmode -halt-on-error "$tex_name"
)