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
MINECHAR='▒'
MINERCHAR='▓'
tput cup $MIDROW $MIDCOL


function draw() {
  RO=$1
  CO=$2

  LEFT=$((CO - 1))
  RIGHT=$((CO + 1))
  UP=$((RO - 1))
  DOWN=$((RO + 1))
  
  #Only place character if in bounds
  if [[ DOWN -le ROW ]]; then
    tput cup $DOWN $CO
    echo -ne "$MINECHAR"
  fi
  if [[ UP -ge 0 ]]; then
    tput cup $UP $CO
    echo -ne "$MINECHAR"
  fi
  if [[ RIGHT -le COL ]]; then
    tput cup $RO $RIGHT
    echo -ne "$MINECHAR"
  fi
  if [[ LEFT -ge 0 ]]; then
    tput cup $RO $LEFT
    echo -ne "$MINECHAR"
  fi
}


for y in {0..50000}; do
  INC=$((y % 5))
  DIRECT=$RANDOM
  DIRECT=$((DIRECT % 4))
  # Left right up down
  if [[ DIRECT -eq 0 ]]; then
    CURCOL=$((CURCOL - 1))
  elif [[ DIRECT -eq 1 ]]; then
    CURCOL=$((CURCOL + 1))
  elif [[ DIRECT -eq 2 ]]; then
    CURROW=$((CURROW - 1))
  else
    CURROW=$((CURROW + 1))
  fi
  
  #Reset invalid coordinates
  if [[ CURROW -eq 0 ]]; then
    CURROW=1
  fi
  if [[ CURCOL -le 1 ]]; then
    CURCOL=2
  fi
  BROW=$((ROW - 1))
  BCOL=$((COL - 1))
  if [[ CURROW -eq BROW ]]; then
    CURROW=$((CURROW - 1))
  fi
  if [[ CURCOL -eq BCOL ]]; then
    CURCOL=$((CURCOL - 1))
  fi

  tput cup $CURROW $CURCOL
  echo -ne "$MINERCHAR"
  draw $CURROW $CURCOL
  sleep .08
done


