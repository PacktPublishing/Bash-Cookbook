#!/bin/bash

function recursive_func() {

    echo -n "Press anything to continue loop "
    read input
    recursive_func
}

recursive_func
exit 0
