#!/bin/bash
COL=$(tput cols)
LIN=$(tput lines)

CHAR='▓'
redraw() {
  RAND=$((RANDOM % 1000))
  #Get window size and choose random location
  WID=$((RANDOM % COL))
  HET=$((RANDOM % LIN))
  tput cup $HET $WID 
  #Print a random color
  COLOR=$((RANDOM % 257))
  echo -ne "\e[38;5;${COLOR}m${CHAR}$RST"
}


EXCMD="tput cnorm && tput cup `tput lines` `tput cols`"
trap "$EXCMD" EXIT
tput civis
#Cycle through drawing fast and slow
while true; do
  STEP=0
  while [[ $STEP -lt 10000 ]]; do
    redraw
    STEP=$((STEP + 1))
  done
  STEP=0
  while [[ $STEP -lt 1000 ]]; do
    redraw
    sleep .01
    STEP=$((STEP + 1))
  done
done
