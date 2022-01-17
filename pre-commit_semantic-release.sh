#!/bin/sh

###############################################################################
# (A) Update `FORMULA` with `${nextRelease.version}`
###############################################################################
sed -i -e "s_^\(version:\).*_\1 ${1}_" FORMULA


###############################################################################
# (B) Use `m2r2` to convert automatically produced `.md` docs to `.rst`
###############################################################################

# Install `m2r2`
pip3 install m2r2

# Copy and then convert the `.md` docs
cp ./*.md docs/
cd docs/ || exit
m2r2 --overwrite ./*.md

# Change excess `H1` headings to `H2` in converted `CHANGELOG.rst`
sed -i -e '/^=.*$/s/=/-/g' CHANGELOG.rst
sed -i -e '1,4s/-/=/g' CHANGELOG.rst

# Use for debugging output, when required
# cat AUTHORS.rst
# cat CHANGELOG.rst

# Return back to the main directory
cd ..


###############################################################################
# (C) Make all adjustments related to the Antora-based documentation
#     This needs to run after the conversion to `.rst` since it uses
#     those files to convert to `.adoc`
###############################################################################

# Update `docs/antora.yml` with `${nextRelease.version}`
sed -i -e "/^\(version: '\).*\('\)$/s//\1${1}\2/" docs/antora.yml

# Convert the files from `.rst` to `.adoc` using `pandoc`
FROM=rst && FN=CHANGELOG && pandoc -t asciidoctor -f ${FROM} -o docs/modules/ROOT/pages/${FN}.adoc docs/${FN}.${FROM}
FROM=rst && FN=AUTHORS && pandoc -t asciidoctor -f ${FROM} -o docs/modules/ROOT/pages/${FN}.adoc docs/${FN}.${FROM}
FROM=rst && FN=README && pandoc -t asciidoctor -f ${FROM} -o docs/modules/ROOT/pages/${FN}.adoc docs/${FN}.${FROM}

# Adjust `CHANGELOG.adoc`
ADOC="docs/modules/ROOT/pages/CHANGELOG.adoc"
# Fix links to avoid issue with `...` in URL
# Also ensure each of these links opens in a new tab
sed -i -e '/^\(=== \)\(https.*\)\(\[.*\)\(]\)/s//\1link:++\2++\3^\4/' "${ADOC}"
# Open other standard links in new tabs
sed -i -e '/^\((https.*\)\(]\)/s//\1^\2/' "${ADOC}"
sed -i -e '/^\(https.*\)\(]\)/s//\1^\2/' "${ADOC}"
# And other non-standard links
# shellcheck disable=SC2016
sed -i -e '\_^\((https.*/commit/\)\(.......\)\()\)$_s__\1\2[\2^]\3_' "${ADOC}"
# Fix headings throughout file
sed -i -e '/^=/s///' "${ADOC}"
# Fix `[skip ci]` on line by itself
sed -i -e '/^\[skip ci]$/s// &/' "${ADOC}"
# Fix what looks like Asciidoctor variables, i.e. in curly braces `{...}`
sed -i -e '/{\w\+}/s//\\&/' "${ADOC}"
# Add `:sectnums!:` directly after the title (the blank line in-between is necessary)
sed -i -e '2 i \\n:sectnums!:' "${ADOC}"

# Adjust `AUTHORS.adoc`
ADOC="docs/modules/ROOT/pages/AUTHORS.adoc"
# Fix the heading
sed -i -e '/^=/s///' "${ADOC}"
# Run three times to get all four lines joined
# (most entries only need two joins but that's dealt with below)
sed -i -e '/^|:raw-html-m2r/N;s/\n/ /' "${ADOC}"
sed -i -e '/^|:raw-html-m2r/N;s/\n/ /' "${ADOC}"
sed -i -e '/^|:raw-html-m2r/N;s/\n/ /' "${ADOC}"
# Add blank line in-between
sed -i -e '/^|:raw-html-m2r/{G;}' "${ADOC}"
# Clear up any double-blank lines introduced
sed -i -e '/^$/N;/\n$/D' "${ADOC}"
# Split the lines again on the table delimeter
sed -i -e '/^|:raw-html-m2r/s/ |/\n|/g' "${ADOC}"
# Fix the `raw-html-m2r` to link to the GitHub avatar images correctly
sed -i -e "/^\(|\):raw-html-m2r.*src='\(.*\)' width='\(.*\)' height='\(.*\)' alt='\(.*\)'.*/s//\1image::\2[\5,\3,\4]/" "${ADOC}"
# Reduce the table boundary markers
sed -i -e '/^|===.*/s//|===/' "${ADOC}"
# Reduce the table boundary markers
sed -i -e '/^|Avatar |Contributor |Contributions/s//^.^|Avatar\n<.^|Contributor\n^.^|Contributions\n/' "${ADOC}"
# Fix the table heading
sed -i -e '/^\[cols=".*/s//.List of contributors\n[format="psv", separator="|", options="header", cols="^.<30a,<.<40a,^.<40d", width="100"]/' "${ADOC}"
# Open links in new tab
sed -i -e '/^\(|https.*\)\(]\)/s//\1^\2/' "${ADOC}"
# Likewise for footer links
sed -i -e '/\(\[forked version\)\(]\)/s//\1^\2/' "${ADOC}"
sed -i -e '/\(\[.*maintainer\)\(]\)/s//\1^\2/' "${ADOC}"

# Adjust `README.adoc`
ADOC="docs/modules/ROOT/pages/README.adoc"
# Fix headings throughout file
sed -i -e '/^=/s///' "${ADOC}"
# Delete the `[[readme]]` line
sed -i -e '/^\[\[readme]]$/d' "${ADOC}"
# Remove the `Table of Contents` line and the blank line after it
sed -i -e '/^\*Table of Contents\*$/,+1d' "${ADOC}"
# Fix the link to `CONTRIBUTING.adoc` (to the Antora-based version)
# shellcheck disable=SC2016
sed -i -e '/^Please see `How to contribute <CONTRIBUTING>` for more details.$/s//Please see\nxref:main::CONTRIBUTING.adoc[How to contribute]\nfor more details./' "${ADOC}"
# Fix the link to `CONTRIBUTING.adoc` (to the Antora-based version) -- based on `.github` repo
sed -i -e '\_https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst_s__xref:main::CONTRIBUTING.adoc_' "${ADOC}"
# Fix the link to `map.jinja.adoc` (to the Antora-based version)
sed -i -e '/^\* link:map.jinja.rst/s//* xref:main::map.jinja.adoc/' "${ADOC}"
# Fix link: `#_special_notes`
sed -i -e '/#special-notes/s//#_special_notes/' "${ADOC}"
# Fix `sourceCode`
sed -i -e '/^\(\[source,\)sourceCode,/s//\1/' "${ADOC}"
# Fix source `jinja2`
sed -i -e '/^\(\[source,jinja\)2/s//\1/' "${ADOC}"
# Fix source `sls`
sed -i -e '/^\(\[source,\)sls/s//\1yaml/' "${ADOC}"
