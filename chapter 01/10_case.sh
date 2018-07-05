#!/bin/bash
VAR=10 # Edit to 1 or 2 and re-run, after running the script as is.
case $VAR in
  1)
    echo "1"
    ;;
  2)
    echo "2"
    ;;
  *)
    echo "What is this var?"
    exit 1
esac
