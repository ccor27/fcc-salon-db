#!/bin/bash
PSQL=("psql -X --username=freecodecamp --dbname=salon -c")
echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "\nWelcome to My Salon, how can I help you?\n"

echo "Welcome to My Salon, how can I help you?"
MAIN_MENU(){
 if [[ $1 ]]
 then
  echo -e "\n$1"
 fi
  echo -e "\n1) cut\n2) color\n3) perm\n4) style\n5) trim"
  read MAIN_SELECTION
  case $MAIN_SELECTION in
  1) CUT ;;
  2) COLOR ;;
  3) PERM ;;
  4) STYLE ;;
  5) TRIM ;;
  *) MAIN_MENU "I could not find that service. What would you like today?" ;;
  esac
}
CUT(){
}
COLOR(){}
PERM(){}
STYLE(){}
TRIM(){}
