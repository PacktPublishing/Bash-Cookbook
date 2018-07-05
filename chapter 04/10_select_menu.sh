#!/bin/bash
TITLE="Select file menu"
PROMPT="Pick a task:"
OPTIONS=("list" "delete" "modify" "create")

function list_files() {
  PS3="Choose a file from the list or type \"back\" to go back to the main: "
  select OPT in *; do 
    if [[ $REPLY -le ${#OPT[@]} ]]; then
      if [[ "$REPLY" == "back" ]]; then 
        return
      fi
      echo "$OPT was selected"
    else
      list_files
    fi
  done
}

function main_menu() {
  echo "${TITLE}"
  PS3="${PROMPT} "
  select OPT in "${OPTIONS[@]}" "quit"; do 
    case "$REPLY" in
      1 ) 
        # List
        list_files
        main_menu # Recursive call to regenerate the menu
      ;;
      2 ) 
        echo "not used"
      ;;
      3 ) 
        echo "not used"
      ;;
      4 )
        echo "not used"
      ;;
      $(( ${#OPTIONS[@]}+1 )) ) echo "Exiting!"; break;;
      *) echo "Invalid option. Try another one.";continue;;
    esac
  done
}

main_menu # Enter recursive loop
