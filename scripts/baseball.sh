#!/bin/bash
SPACER='             '


#                     |                     |                     |                     |   \            /    |
#                     |                     |                     |                     |  __\     |_ __/     |
#                     |                     |                     |        ◜   ◝        |     \__/\/ |  /__/  |
#                     |                     |                     |      ◜ \   / ◝      |      /    \/\/      |
#          .          |          o          |         օ           |     (    ╳    )     | __\_/        \___   |
#                     |                     |                     |      ◟ /   \ ◞      | /   \_       /   \  |
#                     |                     |                     |        ◟   ◞        |     / \_/|__/\      |
#                     |                     |                     |                     |     /   / \_        |
#                     |                     |                     |                     |        /    \       |


LEV1=('                     ' '                     ' '                     ' '                     ' '   \            /    ')
LEV2=('                     ' '                     ' '                     ' '                     ' '  __\     |_ __/     ')
LEV3=('                     ' '                     ' '                     ' '        ◜   ◝        ' '     \__/\/ |  /__/  ')
LEV4=('                     ' '                     ' '                     ' '      ◜ \   / ◝      ' '      /    \/\/      ')
LEV5=('          .          ' '          o          ' '          օ          ' '     (    ╳    )     ' ' __\_/        \___   ')
LEV6=('                     ' '                     ' '                     ' '      ◟ /   \ ◞      ' ' /   \_       /   \  ')
LEV7=('                     ' '                     ' '                     ' '        ◟   ◞        ' '     / \_/|__/\      ')
LEV8=('                     ' '                     ' '                     ' '                     ' '     /   / \_        ')
LEV9=('                     ' '                     ' '                     ' '                     ' '        /    \       ')


echo " "
echo " "
echo " "
echo " "
echo " "
trap "tput cnorm && tput cud1 && tput cud1 && tput cud1 && tput cud1 && tput cud1 && tput cud1 && tput cud1" EXIT

tput cuu1
tput cuu1
tput cuu1
tput civis

for i in {1..200}
do
  for ((j = 0; j < 5; j++))
  do
    echo -e "${SPACER}${LEV1[$j]}"
    echo -e "${SPACER}${LEV2[$j]}"
    echo -e "${SPACER}${LEV3[$j]}"
    echo -e "${SPACER}${LEV4[$j]}"
    echo -e "${SPACER}${LEV5[$j]}"
    echo -e "${SPACER}${LEV6[$j]}"
    echo -e "${SPACER}${LEV7[$j]}"
    echo -e "${SPACER}${LEV8[$j]}"
    echo -e "${SPACER}${LEV9[$j]}"

    for b in {1..9}; do
      tput cuu1
    done

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
        sleep 2
        ;;
      *)
        sleep .05
        ;;
    esac
      

  done
done

exit 0


