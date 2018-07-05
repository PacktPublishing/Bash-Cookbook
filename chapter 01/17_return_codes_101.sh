#!/bin/bash
GLOBAL_RET=255

function my_function_global() {
    ls /home/${USER}/.bashrc
    GLOBAL_RET=$?
}
function my_function_return() {
    ls /home/${USER}/.bashrc
    return $?
}
function my_function_str() {
    local UNAME=$1
    local OUTPUT=""
    if [ -e /home/${UNAME}/.bashrc ]; then
        OUTPUT='FOUND IT'
    else
        OUTPUT='NOT FOUND'
    fi
    echo ${OUTPUT}
}

echo "Current ret: ${GLOBAL_RET}"
my_function_global "${USER}"
echo "Current ret after: ${GLOBAL_RET}"
GLOBAL_RET=255
echo "Current ret: ${GLOBAL_RET}"
my_function_return "${USER}"
GLOBAL_RET=$?
echo "Current ret after: ${GLOBAL_RET}"

# And for giggles, we can pass back output too!
GLOBAL_RET=""
echo "Current ret: ${GLOBAL_RET}"
GLOBAL_RET=$(my_function_str ${USER})
# You could also use GLOBAL_RET=`my_function_str ${USER}`
# Notice the back ticks "`"
echo "Current ret after: $GLOBAL_RET"
exit 0
