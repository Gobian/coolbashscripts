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
CHARS=('\033[47;1m \033[0m' '▓' '▒' '░' '\033[46;40m \033[0m' ' ')
# Formula calculating # squares required to fill screen
REP=$(( ((ROW + 1) / 2) + 1 ))


for y in {0..1000}; do
  # Number of pattern repetitions
  for i in {0..2}; do
    CHAR=${CHARS[$i]}
    x=0
    CURCOL=-1
    while [[ x -le REP ]]; do
      MODUX=$(( x % 4 )) #Controls color palette
      CHAR=${CHARS[$MODUX + $i]}
      CURCOL=$((CURCOL + 1))
      ENDCOL=$((COL - OFFSET))

      # Draw a complete rectangle
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
      x=$((x + 1))
      sleep 0.4
    done
    CURROW=0
    CURCOL=0
    OFFSET=0
  done
done


