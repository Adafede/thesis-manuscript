# Thesis Manuscript

## Manuscript description

<!-- usage note: edit this section. -->

This repository contains what I used to write my doctoral thesis. It was mainly written in markdown using Manubot (see below).
It contains some undocumented modifications I needed.
Some additional pandoc dependencies and lua filters are needed.

## Manubot

<!-- usage note: do not edit this section -->

Manubot is a system for writing scholarly manuscripts via GitHub. Manubot automates citations and references, versions
manuscripts using git, and enables collaborative writing via GitHub.
An [overview manuscript](https://greenelab.github.io/meta-review/ "Open collaborative writing with Manubot") presents
the benefits of collaborative writing with Manubot and its unique features.
The [rootstock repository](https://git.io/fhQH1) is a general purpose template for creating new Manubot instances, as
detailed in [`SETUP.md`](SETUP.md). See [`USAGE.md`](USAGE.md) for documentation how to write a manuscript.

Please open [an issue](https://git.io/fhQHM) for questions related to Manubot usage, bug reports, or general inquiries.

### Repository directories & files

The directories are as follows:

+ [`content`](content) contains the manuscript source, which includes markdown files as well as inputs for citations and
  references. See [`USAGE.md`](USAGE.md) for more information.
+ [`output`](output) contains the outputs (generated files) from Manubot including the resulting manuscripts. You should
  not edit these files manually, because they will get overwritten.
+ [`webpage`](webpage) is a directory meant to be rendered as a static webpage for viewing the HTML manuscript.
+ [`build`](build) contains commands and tools for building the manuscript.
+ [`ci`](ci) contains files necessary for deployment via continuous integration.

### Main commands

```sh
# Activate the manubot conda environment (assumes conda version >= 4.4)
mamba activate manubot

# Build the manuscript, saving outputs to the output directory
BUILD_DOCX=true SPELLCHECK=true bash build/build.sh

# At this point, the HTML output will have been created. The remaining
# commands are for the PDF manuscript locally.
bash build/build_2.sh

## License

<!--
usage note: edit this section to change the license of your manuscript or source code changes to this repository.
We encourage users to openly license their manuscripts, which is the default as specified below.
-->

[![License: CC BY 4.0](https://img.shields.io/badge/License%20All-CC%20BY%204.0-lightgrey.svg)](http://creativecommons.org/licenses/by/4.0/)
[![License: CC0 1.0](https://img.shields.io/badge/License%20Parts-CC0%201.0-lightgrey.svg)](https://creativecommons.org/publicdomain/zero/1.0/)

Except when noted otherwise, the entirety of this repository is licensed under a CC BY 4.0
License ([`LICENSE.md`](LICENSE.md)), which allows reuse with attribution. Please attribute by linking
to https://github.com/adafede/thesis-manuscript.

Since CC BY is not ideal for code and data, certain repository components are also released under the CC0 1.0 public
domain dedication ([`LICENSE-CC0.md`](LICENSE-CC0.md)). All files matched by the following glob patterns are dual
licensed under CC BY 4.0 and CC0 1.0:

+ `*.sh`
+ `*.py`
+ `*.yml` / `*.yaml`
+ `*.json`
+ `*.bib`
+ `*.tsv`
+ `.gitignore`

All other files are only available under CC BY 4.0, including:

+ `*.md`
+ `*.html`
+ `*.pdf`
+ `*.docx`

Please open [an issue](https://github.com/adafede/thesis-manuscript/issues) for any question related to licensing.
