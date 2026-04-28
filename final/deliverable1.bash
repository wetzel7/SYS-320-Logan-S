#!/bin/bash

# curl web page
curl -s http://10.0.17.6/IOC.html > IOC.html

# get text from html

grep -oP '(?<=<td>).*?(?=</td>)' IOC.html | awk 'NR % 2 == 1' > IOC.txt

rm IOC.html
