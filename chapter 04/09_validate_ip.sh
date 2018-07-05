#!/bin/bash

IP_ADDR=$1
IFS=.
if echo "$IP_ADDR" | { read octet1 octet2 octet3 octet4 extra;
  [[ "$octet1" == *[[:digit:]]* ]] && 
  test "$octet1" -ge 0 && test "$octet1" -le 255 &&
  [[ "$octet2" == *[[:digit:]]* ]] && 
  test "$octet2" -ge 0 && test "$octet2" -le 255 &&
  [[ "$octet3" == *[[:digit:]]* ]] && 
  test "$octet3" -ge 0 && test "$octet3" -le 255 &&
  [[ "$octet4" == *[[:digit:]]* ]] && 
  test "$octet4" -ge 0 && test "$octet4" -le 255 &&
  test -z "$extra" 2> /dev/null; }; then
  echo "${IP_ADDR} is valid"
else
    echo "${IP_ADDR} is NOT valid"
fi
