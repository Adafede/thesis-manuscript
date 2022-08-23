#!/usr/bin/env bash

## build.sh: compile manuscript outputs from content using Manubot and Pandoc

set -o errexit \
    -o nounset \
    -o pipefail

# Set timezone used by Python for setting the manuscript's date
export TZ=Etc/UTC
# Default Python to read/write text files using UTF-8 encoding
export LC_ALL=en_US.UTF-8

# Pandoc's configuration is specified via files of option defaults
# located in the $PANDOC_DATA_DIR/defaults directory.
PANDOC_DATA_DIR="${PANDOC_DATA_DIR:-build/pandoc}"

# Create new pdf output
if [ -d output/images ]; then rm -rf output/images; fi  # if images is a directory, remove it
cp -R -L content/images ./
pandoc \
output/manuscript.md \
--output=output/thesis.pdf \
--template=build/assets/template.tex \
--include-in-header=build/assets/preamble.tex \
--bibliography=output/references.json \
--csl=build/assets/style.csl \
--filter=pandoc-xnos \
--filter=pandoc-fignos \
--filter=pandoc-eqnos \
--filter=pandoc-tablenos \
--filter=pandoc-secnos \
--filter=pandoc-manubot-cite \
--citeproc \
--lua-filter=build/pandoc/filters/short-captions.lua \
--lua-filter=build/pandoc/filters/inline-citation-backlinks.lua \
--pdf-engine=xelatex \
--metadata link-citations=true \
--number-sections \
--variable mainfont="Palatino" \
--variable sansfont="Helvetica" \
--variable monofont="Menlo" \
--variable version=2.0 \
--variable=fontsize:12pt \
--variable=papersize:a4paper \
--variable=documentclass:report \
--verbose \
2>output/pandoc.pdf.log
rm -rf ./images

echo >&2 "Build complete"

