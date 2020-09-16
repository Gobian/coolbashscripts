#!/bin/bash
COL=$(tput cols)
ROW=$(tput lines)
EXCMD="tput cnorm && tput cup $ROW $LINES"
trap "$EXCMD" EXIT
tput civis
clear
exec 2>/dev/null


CHAR='/'
CHARS=('/' '\' '_' '|')
MIDCOL=$((COL / 2))
MIDROW=$((ROW / 2))
CURROW=$MIDROW
CURCOL=$MIDCOL


drawrune() {
  MAXLEN=$1
  CURCOL=$2
  CURROW=$3
  CARDLEN=$4
  ORDLEN=$5

  REPLEN=0
  while [[ REPLEN -lt MAXLEN ]]; do
    DIRECT=$((RANDOM % 8))
    # Up  Up-Right  Right  Down-Right  Down  Down-Left  Left  Up-Left
    case $DIRECT in
      0)
        CHAR='|'
        CURLEN=0
        while [[ CURLEN -lt CARDLEN ]]; do
          CURROW=$((CURROW - 1))
          tput cup $CURROW $CURCOL
          echo -ne "$CHAR"
          CURLEN=$((CURLEN + 1 ))
        done
        ;;
      1)
        CHAR='/'
        CURLEN=0
        while [[ CURLEN -lt ORDLEN ]]; do
          CURROW=$((CURROW - 1))
          CURCOL=$((CURCOL + 1))
          tput cup $CURROW $CURCOL
          echo -ne "$CHAR"
          CURLEN=$((CURLEN + 1 ))
        done
        ;;
      2)
        CHAR='_'
        CURLEN=0
        while [[ CURLEN -lt CARDLEN ]]; do
          CURCOL=$((CURCOL + 1))
          tput cup $CURROW $CURCOL
          echo -ne "$CHAR"
          CURLEN=$((CURLEN + 1 ))
        done
        ;;
      3)
        CHAR='\'
        CURLEN=0
        while [[ CURLEN -lt ORDLEN ]]; do
          CURROW=$((CURROW + 1))
          CURCOL=$((CURCOL + 1))
          tput cup $CURROW $CURCOL
          echo -ne "$CHAR"
          CURLEN=$((CURLEN + 1 ))
        done
        ;;
      4)
        CHAR='|'
        CURLEN=0
        while [[ CURLEN -lt CARDLEN ]]; do
          CURROW=$((CURROW + 1))
          tput cup $CURROW $CURCOL
          echo -ne "$CHAR"
          CURLEN=$((CURLEN + 1 ))
        done
        ;;
      5)
        CHAR='/'
        CURLEN=0
        while [[ CURLEN -lt ORDLEN ]]; do
          CURROW=$((CURROW + 1))
          CURCOL=$((CURCOL - 1))
          tput cup $CURROW $CURCOL
          echo -ne "$CHAR"
          CURLEN=$((CURLEN + 1 ))
        done
        ;;
      6)
        CHAR='_'
        CURLEN=0
        while [[ CURLEN -lt CARDLEN ]]; do
          CURCOL=$((CURCOL - 1))
          tput cup $CURROW $CURCOL
          echo -ne "$CHAR"
          CURLEN=$((CURLEN + 1 ))
        done
        ;;
      7)
        CHAR='\'
        CURLEN=0
        while [[ CURLEN -lt ORDLEN ]]; do
          CURROW=$((CURROW - 1))
          CURCOL=$((CURCOL - 1))
          tput cup $CURROW $CURCOL
          echo -ne "$CHAR"
          CURLEN=$((CURLEN + 1 ))
        done
        ;;
      *)
        CHAR='x'
        ;;
    esac

    #Reset invalid coordinates
    if [[ CURROW -lt 0 ]]; then
      CURROW=1
    fi
    if [[ CURCOL -lt 0 ]]; then
      CURCOL=1
    fi
    if [[ CURROW -gt ROW ]]; then
      CURROW=$((CURROW - 1))
    fi
    if [[ CURCOL -gt COL ]]; then
      CURCOL=$((CURCOL - 1))
    fi

    REPLEN=$((REPLEN + 1))
    sleep .01
  done
}


RUNLEN=${1:-10} #Length of rune
CLEN=${2:-2}    #Length of cardinal direction
OLEN=${3:-2}    #Length of ordinal direction

while true; do
  #        length   col    row      cardlen  ordlen
  drawrune $RUNLEN $MIDCOL $MIDROW $CLEN $OLEN
  sleep 2
  clear
done


