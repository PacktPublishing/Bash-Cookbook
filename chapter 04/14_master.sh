#!/bin/bash

FIFO_FILE=/tmp/WORK_QUEUE_FIFO
mkfifo "${FIFO_FILE}"

NUM_WORKERS=5
I=0
while [ $I -lt $NUM_WORKERS ]; do

  bash worker.sh "$I" &
  I=$((I+1))

done 

I=0
while [ $I -lt $NUM_WORKERS ]; do

  echo "$I" > "${FIFO_FILE}"
  I=$((I+1))

done 

sleep 5 
rm -rf "${FIFO_FILE}"
exit 0
