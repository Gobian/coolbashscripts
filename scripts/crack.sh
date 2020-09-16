#!/bin/bash
COL=$(tput cols)
ROW=$(tput lines)
EXCMD="tput cnorm && tput cup $ROW $LINES"
trap "$EXCMD" EXIT
tput civis
clear

CHAR='/'


MIDCOL=$((COL / 2))
MIDROW=$((ROW / 2))
CURROW=$MIDROW
CURCOL=$MIDCOL
tput cup $MIDROW $MIDCOL

for y in {0..500000}; do
  DIRECT=$((RANDOM % 8))
  # Up  Up-Right  Right  Down-Right  Down  Down-Left  Left  Up-Left
  case $DIRECT in
    0)
      CHAR='|'
      CURROW=$((CURROW - 1))
      tput cup $CURROW $CURCOL 2>/dev/null
      echo -ne "$CHAR"
      CURROW=$((CURROW - 1))
      ;;
    1)
      CHAR='/'
      CURROW=$((CURROW - 1))
      CURCOL=$((CURCOL + 1))
      ;;
    2)
      CHAR='_'
      CURCOL=$((CURCOL + 1))
      tput cup $CURROW $CURCOL 2>/dev/null
      echo -ne "$CHAR"
      CURCOL=$((CURCOL + 1))
      ;;
    3)
      CHAR='\'
      CURROW=$((CURROW + 1))
      CURCOL=$((CURCOL + 1))
      ;;
    4)
      CHAR='|'
      CURROW=$((CURROW + 1))
      tput cup $CURROW $CURCOL 2>/dev/null
      echo -ne "$CHAR"
      CURROW=$((CURROW + 1))
      ;;
    5)
      CHAR='/'
      CURROW=$((CURROW + 1))
      CURCOL=$((CURCOL - 1))
      ;;
    6)
      CHAR='_'
      CURCOL=$((CURCOL - 1))
      tput cup $CURROW $CURCOL 2>/dev/null
      echo -ne "$CHAR"
      CURCOL=$((CURCOL - 1))
      ;;
    7)
      CHAR='\'
      CURROW=$((CURROW - 1))
      CURCOL=$((CURCOL - 1))
      ;;
    *)
      CHAR='x'
      ;;
  esac

  #Correct position if out of bounds
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
  sleep .01
done



