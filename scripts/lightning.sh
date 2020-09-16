#!/bin/bash
COL=$(tput cols)
ROW=$(tput lines)
EXCMD="tput cnorm && tput cup $ROW $COL"
trap "$EXCMD" EXIT
tput civis
clear
exec 2>/dev/null

CHAR='/'
CHARS=('/' '\' '_' '|')
MIDCOL=$((COL / 2))
MIDROW=$((ROW / 2))

#Draws cloud from the left of the screen
#to the right, space permitting
drawcloud() {
  CCOL=0
  ECOL=$((COL - 13))
  while [[ CCOL -lt ECOL ]]; do
    tput cup 3 $CCOL
    echo -n "\\"
    CCOL=$((CCOL + 1))
    tput cup 4 $CCOL
    echo -n "\\"

    STRT=$CCOL
    ND=$((10 + CCOL))
    while [[ STRT -lt ND ]]; do
      tput 7 $STRT
      echo -n "_"
      STRT=$((STRT + 1))
    done
    CCOL=$STRT
    CCOL=$((CCOL + 2))
    tput cup 4 $CCOL
    echo -n "/"
  done
}


drawbolt() {
  MAXLEN=$1
  CURCOL=$2
  CURROW=$3
  CARDLEN=$4
  ORDLEN=$5
  REPLEN=$6
  NUMSPLIT=$7

  while [[ REPLEN -lt MAXLEN ]]; do
    DIRECT=$((RANDOM % 8))
    #Down-Right  Down  Down-Left
    case $DIRECT in
      3)
        CHAR='\'
        CURLEN=0
        while [[ CURLEN -lt ORDLEN ]]; do
          CURROW=$((CURROW + 1))
          CURCOL=$((CURCOL + 1))
          tput cup $CURROW $CURCOL && echo -ne "$CHAR"
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
        MODT=$((REPLEN + 1))
        MODMO=$((MODT % 10)) #%chance of bolt splitting
        if [[ MODMO -eq 0 ]]; then
          NUMSPLIT=$((NUMSPLIT + 1))
          #Limit how many times a bolt can split (lesson learned)
          if [[ NUMSPLIT -lt 3 ]]; then
            NEXMAX=$((MAXLEN + 15))
            drawbolt $NEXMAX $CURCOL $CURROW $CARDLEN $ORDLEN $REPLEN $NUMSPLIT &
          fi
        fi
        ;;
      5)
        CHAR='/'
        CURLEN=0
        while [[ CURLEN -lt ORDLEN ]]; do
          CURROW=$((CURROW + 1))
          CURCOL=$((CURCOL - 1))
          tput cup $CURROW $CURCOL && echo -ne "$CHAR"
          CURLEN=$((CURLEN + 1 ))
        done
        ;;
      *)
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
    sleep .0001
  done
}


RUNLEN=${1:-100} #Length of lightning
CLEN=${2:-1}     #Cardinal direction length
OLEN=${3:-1}     #Ordinal direction length
SPAWN=${4:-2}    #Number of bolts to spawn


while true; do
  drawcloud
  REP=0
  while [[ REP -lt SPAWN ]]; do
    #CURROW=$((RANDOM % ROW))
    CURROW=4
    CURCOL=$((RANDOM % COL))
    #         length  col     row     cardlen  ordlen  replen  numsplit
    drawbolt $RUNLEN $CURCOL $CURROW $CLEN    $OLEN    0       0
    REP=$((REP + 1))
  done
  sleep 1
  clear
done


