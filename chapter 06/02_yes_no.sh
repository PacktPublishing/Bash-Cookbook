dialog --yesno "Do you wish to continue?" 0 0
a=$?
if [ "${a}" == "0" ]; then
    echo Yes
else
    echo No
fi
