#!/bin/bash
COL=$(tput cols)
ROW=$(tput lines)
EXCMD="echo -n ' ' && tput cnorm && tput cup $ROW 0"
trap "$EXCMD" EXIT
tput civis

FCHAN=${1:-20}
SCHAN=${2:-35}
TCHAN=${3:-70}
SHADES=("\e[97m▓\e[0m"  "\e[94m▓\e[0m"  "\e[34m▒\e[0m")  #Loading colors
CHANCE=("$FCHAN" "$SCHAN" "$TCHAN")                      #% chance to advance
INDS=("0" "0" "0")                                       #Current location of layers


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
          echo -ne "$CHAR"
          CURCOL=$((CURCOL + 1))
      done
  done
done



