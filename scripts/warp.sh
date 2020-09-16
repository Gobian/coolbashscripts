#!/bin/bash
COL=$(tput cols)
ROW=$(tput lines)
EXCMD="tput cnorm && tput cup $ROW $LINES"
trap "$EXCMD" EXIT
tput civis

CHAR='▓'
CURROW=0
CURCOL=0
OFFSET=0
CHARS=('\033[47;1m \033[0m' '▓' '▒' '░' ' ')
# Function for # squares required to fill screen
REP=$((((ROW + 1) / 2) + 1 ))

for y in {0..1000}; do
  # Fill screen with 4 different colors
  for i in {0..4}; do
    # Choose color and fill in screen with it
    CHAR=${CHARS[$i]}
    for x in $(seq 0 ${REP}); do
      ENDCOL=$((COL - OFFSET))
      while [[ CURCOL -le ENDCOL ]]; do
        tput cup $CURROW $CURCOL
        echo -ne "$CHAR"
        CURCOL=$((CURCOL + 1))
      done

      ENDROW=$((ROW - OFFSET))
      while [[ CURROW -le ENDROW ]]; do
        tput cup $CURROW $CURCOL
        echo -ne "$CHAR"
        CURROW=$((CURROW + 1))
      done

      while [[ CURCOL -ge OFFSET ]]; do
        tput cup $CURROW $CURCOL
        echo -ne "$CHAR"
        CURCOL=$((CURCOL - 1))
      done

      CURCOL=$((CURCOL + 1))
      OFFSET=$((OFFSET + 1))
      while [[ CURROW -ge OFFSET ]]; do
        tput cup $CURROW $CURCOL
        echo -ne "$CHAR"
        CURROW=$((CURROW - 1))
      done

      CURROW=$((CURROW + 1))
      ((x++))
    done #Screen has been filled with a color
    CURROW=0
    CURCOL=0
    OFFSET=0
  done #Screen has been filled successively with 4 colors
done


