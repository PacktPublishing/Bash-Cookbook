#!/bin/bash
#set -x
MY_INPUT='/home/mansijoshi/Desktop'
declare -a A_SURNAME
declare -a A_NAME
declare -a A_USERNAME
declare -a A_DEPARTMENT
declare -a A_PASSWORD
while IFS=, read -r COL1 COL2 COL3 COL4 COL5 TRASH; 
do
    A_SURNAME+=("$COL1")
    A_NAME+=("$COL2")
    A_USERNAME+=("$COL3")
    A_DEPARTMENT+=("$COL4")
    A_PASSWORD+=("$COL5")
done <"$MY_INPUT"
for index in "${!A_USERNAME[@]}"; do
    useradd -g "${A_DEPARTMENT[$index]}" -d "/home/${A_USERNAME[$index]}" -s /bin/bash -p "$(echo "${A_PASSWORD[$index]}" | openssl passwd -1 -stdin)" 
"${A_USERNAME[$index]}"
done
