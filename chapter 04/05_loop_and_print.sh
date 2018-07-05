#!/bin/bash
EXIT_PLEASE=0
INC=0

until [ ${EXIT_PLEASE} != 0 ] # EXIT_PLEASE is set to 0, until will never be satisfied
do
   echo "Boo $INC" > /dev/null
   INC=$((INC + 1))
   sleep 1
done
exit 0
