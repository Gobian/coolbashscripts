#!/bin/bash
COL=$(tput cols)
ROW=$(tput lines)
ROWLIM=$((ROW - 20))
COLLIM=$((COL - 30))
EXCMD="tput cnorm && tput cup $ROW $LINES"
trap "$EXCMD" EXIT
tput civis
clear


CHAR='▓'
CHARS=('\033[47;1m \033[0m' '▓' '▒' '░' '\033[46;40m \033[0m' ' ')
STEP=1


function draw() {
  SROW=$1
  SROW=$((SROW + 1))
  SCOL=$2
  tput cup $SROW $SCOL
  #Clear previous characters and print new ones
  tput el 
  echo -ne "\033[31m▓\033[0m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒"
  SROW=$((SROW + 1))
  tput cup $SROW $SCOL
  tput el
  echo -ne "\033[31m▒\033[0m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒"
}

#Clear a line
function clearl() {
  SROW=$1
  SROW=$((SROW + 1))
  SCOL=$2
  tput cup $SROW 0
  tput el
}
  

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
  if [[ DIRECT -eq 0 ]]
  then
    CURCOL=$((CURCOL - STEP))
  elif [[ DIRECT -eq 1 ]]; then
    CURCOL=$((CURCOL + STEP))
  elif [[ DIRECT -eq 2 ]]; then
    CURROW=$((CURROW - STEP))
  else
    CURROW=$((CURROW + STEP))
  fi
  
  if [[ CURROW -lt 0 ]]; then
    CURROW=1
  fi

  if [[ CURCOL -lt 0 ]]; then
    CURCOL=1
  fi

  if [[ CURROW -gt ROWLIM ]]; then
    CURROW=$((CURROW - 1))
  fi

  if [[ CURCOL -gt COLLIM ]]; then
    CURCOL=$((CURCOL - 1))
  fi

  #Replace both chars with . for lighter smoke
  #Draw 2 randomly selected smoke characters
  tput cup $CURROW $CURCOL
  echo -ne "$CHAR"
  #Clear the cigarette's top line so it doesn't
  #smear up
  clearl $ROWLIM $CURCOL
  tput cup $ROWLIM $CURCOL
  echo -ne "$CHAR"
  tput cup $ROW $COL
  #Drift the smoke up
  echo " "
  #Draw the cigarette
  draw $ROWLIM $CURCOL

  sleep 0.05
done






