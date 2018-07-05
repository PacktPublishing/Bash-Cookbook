#!/bin/bash
STR1='123 is a number, ABC is alphabetic & aBC123 is alphanumeric.'

echo "-------------------------------------------------"
# Want to find all of the files beginning with an uppercase character and end with .pdf?
ls * | grep [[:upper:]]*.pdf

echo "-------------------------------------------------"
# Just all of the directories in your current directory?
ls -l [[:upper:]]*

echo "-------------------------------------------------"
# How about all of the files we created with an expansion using the { } brackets?
ls [:lower:].test .

echo "-------------------------------------------------"
# Files with a specific extension OR two?
echo ${STR1} > test.txt
ls *.{test,txt} 

echo "-------------------------------------------------"
# How about looking for specific punctuation and output on the same line
echo "${STR1}" | grep -o [[:punct:]] | xargs echo

echo "-------------------------------------------------"
# How about using groups and single character wildcards (only 5 results)
ls | grep -E "([[:upper:]])([[:digit:]])?.test?" | tail -n 5

exit 0
