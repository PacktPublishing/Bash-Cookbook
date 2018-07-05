#!/bin/bash
# Retrieve file system information and remove header
TARBALL="archive.tar.gz"
CURRENT_PART_ALL=$(df --output=size,avail,used /home -B 1M | tail -n1)

# Iterate through and fill array
IFS=' ' read -r -a array <<< $CURRENT_PART_ALL

# Retrieve the size of the contents of the tarball
COMPRESSED_SZ=$(tar tzvf "${TARBALL}" | sed 's/ \+/ /g' | cut -f3 -d' ' | sed '2,$s/^/+ /' | paste -sd' ' | bc)

echo "First inspection - is there enough space?"
if [ ${array[1]} -lt ${COMPRESSED_SZ} ]; then
    echo "There is not enough space to decompress the binary"
    exit 1
else
  echo "Seems we have enough space on first inspection - continuing"
  VAR=$((${array[0]} - ${array[2]}))
  echo "Space left: ${VAR}"
fi

echo "Safety check - do we have at least double the space?"
CHECK=$((${array[1]}*2))
echo "Double - good question? $CHECK"

# Notice the use of the bc command?
RES=$(echo "$(mhelper "${array[1]}" "/" "2")>0" | bc -l)
if [[ "${RES}" == "1" ]]; then
  echo "Sppppppaaaaccee (imagine zombies)"
fi

# We know that this will break! (Bash is driven by integers)
# if [ $(mhelper "${array[2]}" "/" "2") -gt 0 ]; then
  #~ echo "Sppppppaaaaccee (imagine zombies) - syntax error"
# fi
# What if we tried this with Bash and a concept again referring to floats
# e.g., 0.5
# It would break
# if [ $((${array[2]} * 0.5 )) -gt 0 ]; then
  # echo "Sppppppaaaaccee (imagine zombies) - syntax error"
# fi

# Then untar
tar xzvf ${TARBALL}
RES=$?
if [ ${RES} -ne 0 ]; then
  echo "Error decompressing the tarball!"
  exit 1
fi

echo "Decompressing tarball complete!"
exit 0
