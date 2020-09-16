#!/bin/bash
COL=$(tput cols)
ROW=$(tput lines)

EXCMD="tput cnorm && tput cup $ROW $LINES"
trap "$EXCMD" EXIT
tput civis
clear


MIDCOL=$((COL / 2))
MIDROW=$((ROW / 2))
CURROW=$MIDCOL
CURCOL=$MIDCOL

tput cup $MIDROW $MIDCOL

for y in {0..50000}; do
  INC=$((RANDOM % 1))
  CHAR="."
  DIRECT=$RANDOM
  DIRECT=$((DIRECT % 4))
  # Left right up down
  if [[ DIRECT -eq 0 ]]
  then
    CURCOL=$((CURCOL - 1))
  elif [[ DIRECT -eq 1 ]]
  then
    CURCOL=$((CURCOL + 1))
  elif [[ DIRECT -eq 2 ]]
  then
    CURROW=$((CURROW - 1))
  else
    CURROW=$((CURROW + 1))
  fi
  
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
done



