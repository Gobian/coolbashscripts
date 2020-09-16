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


MIDCOL=$((COL / 2))
MIDROW=$((ROW / 2))
CURROW=$MIDCOL
CURCOL=$MIDCOL


tput cup $MIDROW $MIDCOL
for y in {0..100000}; do
  INC=$((RANDOM % 4))
  CHAR=${CHARS[$INC]}
  DIRECT=$RANDOM
  DIRECT=$((DIRECT % 4))

  # Left right up down
  if [[ DIRECT -eq 0 ]];  then
    CURCOL=$((CURCOL - STEP))
  elif [[ DIRECT -eq 1 ]]; then
    CURCOL=$((CURCOL + STEP))
  elif [[ DIRECT -eq 2 ]]; then
    CURROW=$((CURROW - STEP))
  else
    CURROW=$((CURROW + STEP))
  fi
  
  #Reset invalid positions
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

  # Replace both chars with . for lighter smoke
  tput cup $CURROW $CURCOL
  echo -ne "$CHAR"
  tput cup $ROW $CURCOL
  echo -e "$CHAR"
  sleep 0.01
done


