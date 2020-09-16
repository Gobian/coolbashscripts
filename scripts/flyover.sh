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

laydirt() {
  tput cup $ROW $LINES
  echo " "
  for p in $(seq 1 ${COL}); do
    if [[ $((RANDOM % 4)) -eq 0 ]]; then
      echo -n "."
    else
      echo -n " "
    fi
  done
}


growplant() {
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
    
    # Reset invalid coordinates
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
}


# Place dirt
for x in {0..10000}; do
  RANDCOL=$((RANDOM % COL))
  RANDROW=$((RANDOM % ROW))
  tput cup $RANDROW $RANDCOL
  echo -n "."
done


WEEDLEN=${1:-50}
MAXWEEDS=${2:-100000}

# Flyover speed inversely proportional to 
# length of weed
for t in $(seq 1 ${MAXWEEDS}); do
  growplant
  laydirt
done


