#!/bin/bash
time=$(zenity --entry --title="Timer" --text="Enter a duration for the timer.\n\n Use 10s for 10 seconds, 20m for 20 minutes, or 3h for 3 hours.")
sleep $time
zenity --info --title="Timer Complete" --text="The timer is over.\n\n It has been $time."
