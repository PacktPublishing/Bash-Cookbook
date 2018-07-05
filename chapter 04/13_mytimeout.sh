#!/bin/bash

SUBPID=0

function func_timer() {
  trap "clean_up" SIGALRM
  sleep $1& wait
  kill -s SIGALRM $$
}

function clean_up() {
  trap - ALRM
  kill -s SIGALRM $SUBPID
  kill $! 2>/dev/null
}

# Call function for timer & notice we record the job's PID
func_timer $1& SUBPID=$!

# Shift the parameters to ignore $0 and $1
shift 

# Setup the trap for signals SIGALRM and SIGINT
trap "clean_up" ALRM INT

# Execute the command passed and then wait for a signal
"$@" & wait $!

# kill the running subpid and wait before exit
kill -ALRM $SUBPID 
wait $SUBPID 
exit 0
