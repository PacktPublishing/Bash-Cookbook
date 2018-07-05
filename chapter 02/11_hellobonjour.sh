#!/bin/bash
. gettext.sh
function i_have() {
  local COUNT=$1
  ###i18n: Please leave $COUNT as is
  echo -e "\n\t" $(eval_ngettext "I have \$COUNT electronic device" "I have \$COUNT electronic devices" $COUNT)

}

echo $(gettext "Hello")
echo

echo $(gettext "What is your name?")
echo

###i18n: Please leave $USER as is
echo -e "\t" $(eval_gettext "My name is \$USER" )
echo

echo $(gettext "Do you have electronics?")

i_have 0
i_have 1
i_have 2
