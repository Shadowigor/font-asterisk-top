#!/bin/bash

# You need to specify a path to the .ttf files
if [[ $# -lt 1 ]]; then
    echo "Please specify path"
    exit 1
fi

basedir="$1"

for f in "$basedir"/SourceCodePro*.ttf; do
    # Get the name of the file without extension
    file="${f%.*}"

    echo "--- Processing font $(basename ${file}) ---"

    # Remove old .ttx files
    rm -f "${file}.ttx"

    # Extract the character map
    ttx -t cmap "${file}.ttf"

    # Replace asterisk
    sed -i 's/name="asterisk"/name="asterisk.a"/g' "${file}.ttx"

    # Regenerate TTF font
    ttx -o "${file}.ttf" -m "${file}.ttf" "${file}.ttx"

    # Remove old .ttx files
    rm -f "${file}.ttx"

    # Extract the font name
    ttx -t name "${file}.ttf"

    # Rename the font
    sed -i 's/Source Code Pro/Asterisk Top/g' "${file}.ttx"
    sed -i 's/ADOBE/CUSTOM/g' "${file}.ttx"
    sed -i 's/Adobe Systems Incorporated/Asterisk On Top/g' "${file}.ttx"
    sed -i 's-http://www.adobe.com/-https://github.com/Shadowigor-g' "${file}.ttx"
    sed -i 's/Souce/Asterisk Top/g' "${file}.ttx"

    # Regenerate TTF font
    ttx -o "${file}.ttf" -m "${file}.ttf" "${file}.ttx"

    # Remove old .ttx files
    rm -f "${file}.ttx"

    # Rename the new .ttf files
    rename SourceCodePro AsteriskTop "${file}.ttf"

    echo ""
done

exit 0
