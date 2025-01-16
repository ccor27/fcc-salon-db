#!/bin/bash
PSQL=("psql -X --username=freecodecamp --dbname=salon -c")
echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "\nWelcome to My Salon, how can I help you?\n"


FETCH_CUSTOMER_ID() {
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  #fetch customer by phone number
  CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_ID ]]; then
    #get customer name
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read NAME
    #insert customer in the database
    CUSTOMER_INSERT_RESULT=$($PSQL "insert into customers(name,phone) values('$NAME','$CUSTOMER_PHONE')" 2>&1)
    if [[ $? -ne 0 ]]; then
      #there was an error, redirect to main menu
      echo -e "\nThere was an error during the creation of the customer, please try again."
      return
    fi
    #get customer's id 
    CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")
  fi
  echo $CUSTOMER_ID
}
CUT() {
  CUSTOMER_ID=$(FETCH_CUSTOMER_ID)
  if [[ -n $CUSTOMER_ID ]]
  then
   #get the customer's name
   CUSTOMER_NAME=$($PSQL "select name from customers where customer_id=$CUSTOMER_ID")
   #get service id
   SERVICE_ID_SELECTED=$($PSQL "select service_id from services where name='cut'")
   #get time
   echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME"
   read SERVICE_TIME
   #create the appointment
   APPOINTMENT_INSERT_RESULT=$($PSQL "insert into appointments(customer_id,service_id,time) values($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
   #show the final message
   echo -e "\nI have put you down for a color at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}
COLOR() {
  CUSTOMER_ID=$(FETCH_CUSTOMER_ID)
  if [[ -n $CUSTOMER_ID ]]
  then
   #get the customer's name
   CUSTOMER_NAME=$($PSQL "select name from customers where customer_id=$CUSTOMER_ID")
   #get service id
   SERVICE_ID_SELECTED=$($PSQL "select service_id from services where name='color'")
   #get time
   echo -e "\nWhat time would you like your color, $CUSTOMER_NAME"
   read SERVICE_TIME
   #create the appointment
   APPOINTMENT_INSERT_RESULT=$($PSQL "insert into appointments(customer_id,service_id,time) values($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
   #show the final message
   echo -e "\nI have put you down for a color at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}
PERM() {
   CUSTOMER_ID=$(FETCH_CUSTOMER_ID)
  if [[ -n $CUSTOMER_ID ]]
  then
   #get the customer's name
   CUSTOMER_NAME=$($PSQL "select name from customers where customer_id=$CUSTOMER_ID")
   #get service id
   SERVICE_ID_SELECTED=$($PSQL "select service_id from services where name='perm'")
   #get time
   echo -e "\nWhat time would you like your perm, $CUSTOMER_NAME"
   read SERVICE_TIME
   #create the appointment
   APPOINTMENT_INSERT_RESULT=$($PSQL "insert into appointments(customer_id,service_id,time) values($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
   #show the final message
   echo -e "\nI have put you down for a color at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}
STYLE() {
  CUSTOMER_ID=$(FETCH_CUSTOMER_ID)
  if [[ -n $CUSTOMER_ID ]]
  then
   #get the customer's name
   CUSTOMER_NAME=$($PSQL "select name from customers where customer_id=$CUSTOMER_ID")
   #get service id
   SERVICE_ID_SELECTED=$($PSQL "select service_id from services where name='style'")
   #get time
   echo -e "\nWhat time would you like your style, $CUSTOMER_NAME"
   read SERVICE_TIME
   #create the appointment
   APPOINTMENT_INSERT_RESULT=$($PSQL "insert into appointments(customer_id,service_id,time) values($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
   #show the final message
   echo -e "\nI have put you down for a color at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}
TRIM() {
   CUSTOMER_ID=$(FETCH_CUSTOMER_ID)
  if [[ -n $CUSTOMER_ID ]]
  then
   #get the customer's name
   CUSTOMER_NAME=$($PSQL "select name from customers where customer_id=$CUSTOMER_ID")
   #get service id
   SERVICE_ID_SELECTED=$($PSQL "select service_id from services where name='trim'")
   #get time
   echo -e "\nWhat time would you like your trim, $CUSTOMER_NAME"
   read SERVICE_TIME
   #create the appointment
   APPOINTMENT_INSERT_RESULT=$($PSQL "insert into appointments(customer_id,service_id,time) values($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
   #show the final message
   echo -e "\nI have put you down for a color at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}
MAIN_MENU() {
  while true; do
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
  done
}
MAIN_MENU
