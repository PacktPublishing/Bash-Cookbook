#!/bin/bash
typeset -A config
config=(
    [username]="student"
    [password]=""
    [hostname]="ubuntu"
)
while read line
do
    if echo $line | grep -F = &>/dev/null
    then
        varname=$(echo "$line" | cut -d '=' -f 1)
        config[$varname]=$(echo "$line" | cut -d '=' -f 2-)
    fi
done < sampleconfig.conf
echo ${config[username]}
echo ${config[password]}
echo ${config[hostname]}
echo ${config[PROMPT_COMMAND]}
