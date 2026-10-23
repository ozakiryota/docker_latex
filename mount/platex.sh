#!/bin/bash

set -e

if [ $# -ne 1 ] && [ $# -ne 2 ]; then
    echo "Error: Usage: ./tex_to_pdf.sh TEX_PATH (BIB_PATH)"
    exit 1
fi

tex_path="$1"
tex_name=$(basename $1)
tex_name_without_extension=$(basename $1 .tex)
tex_dir=$(dirname "$tex_path")
(
    cd "$tex_dir" || exit 1
    sed -i 's/、/，/g' $tex_name
    sed -i 's/。/．/g' $tex_name
    platex $tex_name_without_extension
    if [ $# -eq 2 ]; then
        pbibtex $tex_name_without_extension
        platex $tex_name_without_extension
    fi
    platex $tex_name_without_extension
    dvipdfmx $tex_name_without_extension
    # evince $tex_name_without_extension'.pdf'
)