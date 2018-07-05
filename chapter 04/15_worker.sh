#!/bin/bash

FIFO_FILE=/tmp/WORK_QUEUE_FIFO

BUFFER=""
echo "WORKER started: $1"

while :
do

read BUFFER < "${FIFO_FILE}"

if [ "${BUFFER}" != "" ]; then
  echo "Worker received: $BUFFER"
  exit 1
fi

done

exit 0
