#!/bin/bash
COL=$(tput cols)
ROW=$(tput lines)
EXCMD="tput cnorm && tput cup $ROW $COL"
trap "$EXCMD" EXIT
tput civis
clear
exec 2>/dev/null


#Uncompressed for reference
#LEV1=('                     ' '                     ' '                     ' '                     ' '   \            /    ')
#LEV2=('                     ' '                     ' '                     ' '                     ' '  __\     |_ __/     ')
#LEV3=('                     ' '                     ' '                     ' '        ◜   ◝        ' '     \__/\/ |  /__/  ')
#LEV4=('                     ' '                     ' '                     ' '      ◜ \   / ◝      ' '      /    \/\/      ')
#LEV5=('          .          ' '          o          ' '          օ          ' '     (    ╳    )     ' ' __\_/        \___   ')
#LEV6=('                     ' '                     ' '                     ' '      ◟ /   \ ◞      ' ' /   \_       /   \  ')
#LEV7=('                     ' '                     ' '                     ' '        ◟   ◞        ' '     / \_/|__/\      ')
#LEV8=('                     ' '                     ' '                     ' '                     ' '     /   / \_        ')
#LEV9=('                     ' '                     ' '                     ' '                     ' '        /    \       ')

#Compressed for use
LEV1=('' '' '' '' '   \            /')
LEV2=('' '' '' '' '  __\     |_ __/')
LEV3=('' '' '' '        ◜   ◝' '     \__/\/ |  /__/')
LEV4=('' '' '' '      ◜ \   / ◝' '      /    \/\/')
LEV5=('          .' '          o' '          օ' '     (    ╳    )' ' __\_/        \___')
LEV6=('' '' '' '      ◟ /   \ ◞' ' /   \_       /   \')
LEV7=('' '' '' '        ◟   ◞' '     / \_/|__/\')
LEV8=('' '' '' '' '     /   / \_')
LEV9=('' '' '' '                     ' '        /    \')

drawball() {
  for ((j = 0; j < 5; j++)); do
    #Draw a frame of the animation
    tput cup $CURROW $CURCOL
    echo -en "${LEV1[$j]}"
    CURROW=$((CURROW + 1))
    tput cup $CURROW $CURCOL
    echo -en "${LEV2[$j]}"
    CURROW=$((CURROW + 1))
    tput cup $CURROW $CURCOL
    echo -en "${LEV3[$j]}"
    CURROW=$((CURROW + 1))
    tput cup $CURROW $CURCOL
    echo -en "${LEV4[$j]}"
    CURROW=$((CURROW + 1))
    tput cup $CURROW $CURCOL
    echo -en "${LEV5[$j]}"
    CURROW=$((CURROW + 1))
    tput cup $CURROW $CURCOL
    echo -en "${LEV6[$j]}"
    CURROW=$((CURROW + 1))
    tput cup $CURROW $CURCOL
    echo -en "${LEV7[$j]}"
    CURROW=$((CURROW + 1))
    tput cup $CURROW $CURCOL
    echo -en "${LEV8[$j]}"
    CURROW=$((CURROW + 1))
    tput cup $CURROW $CURCOL
    echo -en "${LEV9[$j]}"
    CURROW=$((CURROW - 8))
    
    #Different frame timings for effect
    case "$j" in
      0)
        sleep .6
        ;;
      1)
        sleep .6
        ;;
      2)
        sleep .8
        ;;
      3)
        sleep .6
        ;;
      4)
        sleep .1
        ;;
      *)
        sleep .05
        ;;
    esac
  done
}

SPAWN=${1:-20} #Number of balls to throw

while true; do
  REP=0
  while [[ REP -lt SPAWN ]]; do
    CURROW=$((RANDOM % ROW))
    CURCOL=$((RANDOM % COL))

    #Keep balls within bounds
    if [[ $CURROW -gt $((ROW - 9)) ]]; then
        CURROW=$((CURROW - 9))
    fi
    if [[ $CURCOL -gt $((COL - 18)) ]]; then
        CURCOL=$((CURCOL - 18))
    fi

    drawball &
    sleep .4
    REP=$((REP + 1))
  done
  #Wait for background programs to finish
  while [[ $(jobs | wc -l) > 0 ]]; do
    sleep 1
    jobs > /dev/null #jobs wont 'flush' "Done" jobs if called in subshell
  done

  sleep 5
  clear
done



