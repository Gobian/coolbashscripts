#!/bin/bash
# Colors
RED=$'\e[1;31m'
YEL=$'\e[1;33m'
CYN=$'\e[1;34m'
GRN=$'\e[1;32m'
MGN=$'\e[1;95m'
RST=$'\e[0m'


EXCMD="tput cnorm && tput cup `tput lines` `tput cols`"
trap "$EXCMD" EXIT
tput civis
clear
for i in {1..40}; do
  echo "                Use  WASD  and  0|1|2|3|4|5|6|7|8|9|e|r|t|y|u|i|o|p|f|g|h|j"
  sleep .05
done
sleep 1.5
clear
ROW=$(( `tput lines` / 2))
COL=$(( `tput cols` / 2))
PROMPT="▓"
tput cup $ROW $COL
while true; do
  read -s -n 1
  if [[ $REPLY == "w" ]]; then
    ROW=$((ROW - 1 ))
    tput cup $ROW $COL
    echo -en "$PROMPT"
  elif [[ $REPLY == "s" ]]; then
    ROW=$((ROW + 1 ))
    tput cup $ROW $COL
    echo -en "$PROMPT"
  elif [[ $REPLY == "a" ]]; then
    COL=$((COL - 1 ))
    tput cup $ROW $COL
    echo -en "$PROMPT"
  elif [[ $REPLY == "d" ]]; then
    COL=$((COL + 1 ))
    tput cup $ROW $COL
    echo -en "$PROMPT"
  else
    if [[ $REPLY == "1" ]]; then
      PROMPT="▓"
    elif [[ $REPLY == "2" ]]; then
      PROMPT="▒"
    elif [[ $REPLY == "3" ]]; then
      PROMPT="░"
    elif [[ $REPLY == "4" ]]; then
      PROMPT="\033[41;1m \033[0m"
    elif [[ $REPLY == "5" ]]; then
      PROMPT="\033[42;1m \033[0m"
    elif [[ $REPLY == "6" ]]; then
      PROMPT="\033[43;1m \033[0m"
    elif [[ $REPLY == "7" ]]; then
      PROMPT="\033[44;1m \033[0m"
    elif [[ $REPLY == "8" ]]; then
      PROMPT="\033[45;1m \033[0m"
    elif [[ $REPLY == "9" ]]; then
      PROMPT="\033[46;1m \033[0m"
    elif [[ $REPLY == "e" ]]; then
      PROMPT="\033[47;1m \033[0m"
    elif [[ $REPLY == "r" ]]; then
      PROMPT="\033[101;1m \033[0m"
    elif [[ $REPLY == "t" ]]; then
      PROMPT="\033[102;1m \033[0m"
    elif [[ $REPLY == "y" ]]; then
      PROMPT="\033[103;1m \033[0m"
    elif [[ $REPLY == "u" ]]; then
      PROMPT="\033[104;1m \033[0m"
    elif [[ $REPLY == "i" ]]; then
      PROMPT="\033[105;1m \033[0m"
    elif [[ $REPLY == "o" ]]; then
      PROMPT="\033[106;1m \033[0m"
    elif [[ $REPLY == "p" ]]; then
      PROMPT="\033[107;1m \033[0m"
    elif [[ $REPLY == "f" ]]; then
      PROMPT="\033[9;1m \033[0m"
    elif [[ $REPLY == "g" ]]; then
      PROMPT="_"
    elif [[ $REPLY == "h" ]]; then
      PROMPT="\033[39;5m▓\033[0m"
    elif [[ $REPLY == "j" ]]; then
      PROMPT="."
    elif [[ $REPLY == "0" ]]; then
      PROMPT=" "
    fi
    tput cup $ROW $COL
  fi
done
exit 0


