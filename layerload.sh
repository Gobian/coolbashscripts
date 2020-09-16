#!/bin/bash
COL=$(tput cols)
ROW=$(tput lines)
EXCMD="echo -n ' ' && tput cnorm && tput cup $ROW 0"
trap "$EXCMD" EXIT
tput civis

FCHAN=${1:-50}
SCHAN=${2:-60}
TCHAN=${3:-80}
SHADES=("▓"  "▒"  "░")               #Loading colors
CHANCE=("$FCHAN" "$SCHAN" "$TCHAN")  #% chance to advance
INDS=("0" "0" "0")                   #Current location of layers


while [[ ${INDS[0]} -le $COL ]]; do
  for i in {0..2}; do
			#Randomly advance all shades
			RCHANCE=$((RANDOM % 100))
			if [[ $RCHANCE -lt ${CHANCE[$i]} ]]; then
          if [[ ${INDS[$i]} -le $COL ]]; then
              INDS[$i]=$((INDS[$i] + 1))
          fi
			fi
	done
					
  CURCOL=0
  for i in {0..2}; do
      CHAR=${SHADES[$i]}
      while [[ $CURCOL -le ${INDS[$i]} ]]; do
          tput cup $ROW $CURCOL
          echo -n "$CHAR"
          CURCOL=$((CURCOL + 1))
      done
  done
done



