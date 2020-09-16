#!/bin/bash
COL=$(tput cols)
ROW=$(tput lines)
EXCMD="tput cnorm && tput cup $ROW $LINES"
trap "$EXCMD" EXIT
tput civis
clear

CHAR='▓'
CHARS=('\033[47;1m \033[0m' '▓' '▒' '░' '\033[46;40m \033[0m' ' ')
STEP=1

# Place dirt
for x in {0..10000}; do
  RANDCOL=$((RANDOM % COL))
  RANDROW=$((RANDOM % ROW))
  tput cup $RANDROW $RANDCOL
  echo -n "."
done


WEEDLEN=${1:-300}
MAXWEEDS=${2:-20}


for t in $(seq 1 ${MAXWEEDS}); do
  CURCOL=$((RANDOM % COL))
  CURROW=$((RANDOM % ROW))
  tput cup $CURROW $CURCOL

  # Draw a weed
  for y in $(seq 1 ${WEEDLEN}); do
    INC=$((RANDOM % 4))
    CHAR=${CHARS[$INC]}
    DIRECT=$((RANDOM % 4))
    # Left right up down
    if [[ DIRECT -eq 0 ]]; then
      CURCOL=$((CURCOL - STEP))
    elif [[ DIRECT -eq 1 ]]; then
      CURCOL=$((CURCOL + STEP))
    elif [[ DIRECT -eq 2 ]]; then
      CURROW=$((CURROW - STEP))
    else
      CURROW=$((CURROW + STEP))
    fi
    
    #Reset invalid coordinates
    if [[ CURROW -lt 0 ]]; then
      CURROW=1
    fi
    if [[ CURCOL -lt 0 ]]; then
      CURCOL=1
    fi
    if [[ CURROW -gt ROW ]]; then
      CURROW=$((CURROW - 2))
    fi
    if [[ CURCOL -gt COL ]]; then
      CURCOL=$((CURCOL - 2))
    fi

    tput cup $CURROW $CURCOL
    echo -ne "$CHAR"
    sleep .001 #For effect
  done
  sleep 1.2 #For effect
done


