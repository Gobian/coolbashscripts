#!/bin/bash
COL=$(tput cols)
ROW=$(tput lines)
EXCMD="tput cnorm && tput cup $ROW $COL"
trap "$EXCMD" EXIT
tput civis
clear
exec 2>/dev/null

#╦╦
#╠╣
#╩╩

CHAR='/'
CHARS=('/' '\' '_' '|')
MIDCOL=$((COL / 2))
MIDROW=$((ROW / 2))
CHARR1=('║' '╗' '╔')
CHARR2=('═' '╝' '╗')
CHARR3=('║' '╚' '╝')
CHARR4=('═' '╚' '╔')
SLINE=0


drawpipe() {
  MAXLEN=$1
  CURCOL=$2
  CURROW=$3
  CARDLEN=$4

  # Use last direction to choose valid character
  REPLEN=0
  while [[ $REPLEN -lt $MAXLEN ]]; do
    DIRECT=0
    if [[ $LASTDIR == "left" ]]; then
      NEXTDIR=4
    elif [[ $LASTDIR == "right" ]]; then
      NEXTDIR=2
    elif [[ $LASTDIR == "up" ]]; then
      NEXTDIR=1
    else
      NEXTDIR=3
    fi
    
    # If last char was not a straight pipe,
    # place a straight pipe, else place
    # random valid pipe
    case $NEXTDIR in
      1)
        if [[ $SLINE -eq 0 ]]; then
          MODI=$((RANDOM % 3))
          CHAR=${CHARR1[$MODI]}
        else
          CHAR="║"   
        fi
        ;;
      2)
        if [[ $SLINE -eq 0 ]]; then
          MODI=$((RANDOM % 3))
          CHAR=${CHARR2[$MODI]}
        else 
          CHAR="═"
        fi
        ;;
      3)
        if [[ $SLINE -eq 0 ]]; then
          MODI=$((RANDOM % 3))
          CHAR=${CHARR3[$MODI]}
        else
          CHAR="║"   
        fi
        ;;
      4)
        if [[ $SLINE -eq 0 ]]; then
          MODI=$((RANDOM % 3))
          CHAR=${CHARR4[$MODI]}
        else
          CHAR="═"
        fi
        ;;
    esac
  
    # Place 1 or more straight pipes
    if [[ $CHAR == "═" ]]; then
      CURORD=0
      while [[ $CURORD -lt $CARDLEN ]]; do
        if [[ $NEXTDIR -eq 4 ]]; then
          CURCOL=$((CURCOL - 1))
          tput cup $CURROW $CURCOL
          echo -ne "$CHAR"
        else
          CURCOL=$((CURCOL + 1))
          tput cup $CURROW $CURCOL
          echo -ne "$CHAR"
        fi
        CURORD=$((CURORD + 1))
      done
      SLINE=0
    elif [[ $CHAR == "║" ]]; then
      CURORD=0
      while [[ $CURORD -lt $CARDLEN ]]; do
        if [[ $NEXTDIR -eq 3 ]]; then
          CURROW=$((CURROW + 1))
          tput cup $CURROW $CURCOL
          echo -ne "$CHAR"
        else
          CURROW=$((CURROW - 1))
          tput cup $CURROW $CURCOL
          echo -ne "$CHAR"
        fi
        CURORD=$((CURORD + 1))
      done
      SLINE=0
    # Place 1 non-straight pipe
    else
      case $LASTDIR in
        "left")
          CURCOL=$((CURCOL - 1))
          ;;
        "right")
          CURCOL=$((CURCOL + 1))
          ;;
        "up")
          CURROW=$((CURROW - 1))
          ;;
        "down")
          CURROW=$((CURROW + 1))
          ;;
      esac
      SLINE=1
    fi
    
    # Reset invalid coordinates
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

    # Place character
    tput cup $CURROW $CURCOL
    echo -ne "$CHAR"
   
    # Set LASTDIR for next character
    case $NEXTDIR in 
      1)
        case $CHAR in 
          "║") 
            LASTDIR="up"
            ;;
          "╗")
            LASTDIR="left"
            ;;
          "╔")
            LASTDIR="right"
            ;;
        esac
        ;;
      2)
        case $CHAR in
          "═")
            LASTDIR="right"
            ;;
          "╝") 
            LASTDIR="up"
            ;;
          "╗")
            LASTDIR="down"
            ;;
        esac
        ;;
      3)
        case $CHAR in
          "║")
            LASTDIR="down"
            ;;
          "╚") 
            LASTDIR="right"
            ;;
          "╝")
            LASTDIR="left"
            ;;
        esac
        ;;
      4)
        case $CHAR in
          "═")
            LASTDIR="left"
            ;;
          "╚") 
            LASTDIR="up"
            ;;
          "╔")
            LASTDIR="down"
            ;;
        esac
        ;;
    esac
    REPLEN=$((REPLEN + 1))
    sleep .08
  done
}


MIDROW=$((ROW / 2))
MIDCOL=$((COL / 2))
RUNLEN=${1:-2000}
OLEN=${2:-2}
SPAWN=${3:-1}


while true; do
  REP=0
  LASTDIR="right"
  while [[ REP -lt SPAWN ]]; do
    CURROW=$MIDROW
    CURCOL=$MIDCOL
    drawpipe $RUNLEN $CURCOL $CURROW $OLEN
    REP=$((REP + 1))
  done
  sleep 2
  clear
done



