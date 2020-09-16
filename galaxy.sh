#!/bin/bash

# Colors
RED=$'\e[1;31m'
YEL=$'\e[1;33m'
CYN=$'\e[1;34m'
GRN=$'\e[1;32m'
MGN=$'\e[1;95m'
RST=$'\e[0m'



CCHAR=('.' )
UCHAR=( 'စ' '☀ ' 'Օ ' 'օ' 'ܘ' 'x' 'o' '.')
RCHAR=('⌀'  '⊙ ' 'ʘ ')
ECHAR=('✨' '⚙ ' '✸ ' '❈ '  '★ ' '✰ ' '✶ ' '*')
LCHAR=('❁ ' '✵ ' '፨' 'ထ ' '   ҉' '   ҈'  '☄')

CMODU=${#CCHAR[@]}
UMODU=${#UCHAR[@]}
RMODU=${#RCHAR[@]}
EMODU=${#ECHAR[@]}
LMODU=${#LCHAR[@]}

#' ဲ ' ' ံ ' 'ᘓ '' ঁ  ''☆ '
#CCHAR=('x' 'o' '.' '*' ','  '✶ ')
#UCHAR=( 'စ' '☀ ' 'Օ ' 'օ' 'ܘ')


redraw() {
  RAND=$((RANDOM % 1000))
  #if [[ RAND -lt 3 ]]; then
  #  clear
  #fi
  #===Get window size and choose random location
  COL=$(tput cols)
  LIN=$(tput lines)
  WID=$((RANDOM % COL))
  HET=$((RANDOM % LIN))
  tput cup $HET $WID 
  #=============================================
  #===Choose a character rarity
  RAND=$((RANDOM % 1000))
  if [[ RAND -le 700 ]]; then
    IND=$((RANDOM % CMODU))
    #echo -ne "${CCHAR[$IND]}"
    echo -ne "${YEL}${CCHAR[$IND]}${RST}"
  elif [[ RAND -le 800 ]]; then
    IND=$((RANDOM % UMODU))
    echo -ne "${UCHAR[$IND]}"
  elif [[ RAND -le 960 ]]; then
    IND=$((RANDOM % RMODU))
    echo -ne "${RCHAR[$IND]}"
  elif [[ RAND -le 990 ]]; then
    IND=$((RANDOM % EMODU))
    echo -ne "${YEL}${ECHAR[$IND]}${RST}"
  else
    IND=$((RANDOM % LMODU))
    if [[ IND -le 2 ]]; then
      echo -ne "${CYN}${LCHAR[$IND]}${RST}"
    elif [[ IND -eq 3 ]]; then
      echo -ne "${GRN}${LCHAR[$IND]}${RST}"
    elif [[ IND -le 5 ]]; then
      echo -ne "${RED}${LCHAR[$IND]}${RST}"
    else
      echo -ne "${LCHAR[$IND]}"
    fi
  fi

}


EXCMD="tput cnorm && tput cup `tput lines` `tput cols`"
trap "$EXCMD" EXIT
tput civis
clear
while true; do
  redraw
  sleep .1
done



