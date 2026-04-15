#! /bin/bash

# This is the link we will scrape
link="10.0.17.6/Assignment.html"

# get it with curl and tell curl not to give errors
fullPage=$(curl -sL "$link")

# Utilizing xmlstarlet tool to extract table from the page
toolOutput=$(echo "$fullPage" | \
xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select --template --value-of \
"//table/tr/td" -n 2>/dev/null)

# using sed to strip &#13;, trim any blanks, drop blank lines
clean=$(echo "$toolOutput" | sed 's/&#13;//g; s/^[ \t]*//; /^$/d')

# definte tempature pairs and pressure pairs
temps=$(echo "$clean" | sed -n '1,10p' | paste - -)
press=$(echo "$clean" | sed -n '11,20p' | paste - -)

#clean output
paste <(echo "$press" | cut -f1) <(echo "$temps")
