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
FETCH_CUSTOMER_ID(){
  echo -e "\nWhat's your phone number?"
  read PHONE_NUMBER
  #fetch customer by phone number
  CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$PHONE_NUMBER'")
  #if customer does not exist in the database
  if [[ -z $CUSTOMER_ID ]]
    then
    #get customer name
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read NAME
    #insert customer in the database
    CUSTOMER_INSERT_RESULT=$($PSQL "insert into customers(name,phone) values('$NAME','$PHONE_NUMBER')" 2>&1)
    #validate if had an error during the insert
    if [[ $? -ne 0]]
      then
      #there was an error, redirect to main menu
       MAIN_MENU "There was an error during the creation of the customer, please try again."
    fi
    #get customer's id 
    CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$PHONE_NUMBER'")
  fi
  #return customer's id
  echo $CUSTOMER_ID
}
CUT(){
   CUSTOMER_ID=$(FETCH_CUSTOMER_ID)
  if [[ -n $CUSTOMER_ID ]]
  then
   #create the service

  fi
}
COLOR(){
  CUSTOMER_ID=$(FETCH_CUSTOMER_ID)
  if [[ -z $CUSTOMER_ID ]]
  then
   #return to main menu
  fi
}
PERM(){
  CUSTOMER_ID=$(FETCH_CUSTOMER_ID)
}
STYLE(){
  CUSTOMER_ID=$(FETCH_CUSTOMER_ID)
}
TRIM(){
  CUSTOMER_ID=$(FETCH_CUSTOMER_ID)
}
