#!/bin/bash
COL=$(tput cols)
ROW=$(tput lines)
EXCMD="tput cnorm && tput cup $ROW $LINES"
trap "$EXCMD" EXIT
tput civis
clear
exec 2>/dev/null


CHAR='/'
MIDCOL=$((COL / 2))
MIDROW=$((ROW / 2))
CURROW=$MIDROW
CURCOL=$MIDCOL


drawbranch() {
  MAXLEN=$1
  CURCOL=$2
  CURROW=$3
  CARDLEN=$4
  ORDLEN=$5

  REPLEN=0
  while [[ REPLEN -lt MAXLEN ]]; do
    DIRECT=$((RANDOM % 8))
    echo -n "-"
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
      *)
        CHAR='x'
        ;;
    esac


    if [[ CURROW -lt 0 ]]; then
      echo "x"
      CURROW=1
    fi

    if [[ CURCOL -lt 0 ]]; then
      echo "x"
      CURCOL=1
    fi

    if [[ CURROW -gt ROW ]]; then
      echo "x"
      CURROW=$((CURROW - 1))
    fi

    if [[ CURCOL -gt COL ]]; then
      echo "x"
      CURCOL=$((CURCOL - 1))
    fi
    REPLEN=$((REPLEN + 1))
  done
}

#Length of branch
RUNLEN=${1:-150}
#Length of cardinal-directioned character
CLEN=${2:-1}
#Length of ordinal-directioned character
OLEN=${3:-1}


while true; do
  #          length   col     row  cardlen  ordlen
  drawbranch $RUNLEN $MIDCOL $ROW $CLEN $OLEN
done

