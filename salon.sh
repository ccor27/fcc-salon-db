#!/bin/bash
PSQL=("psql -X --username=freecodecamp --dbname=salon --tuples-only -c")
echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"

MAIN_MENU(){
if [[ $1 ]]
then
 echo -e "\n$1"
fi
#get services
SERVICES=$($PSQL "select service_id,name from services")
#show services propertly
echo "$SERVICES" | while read SERVICE_ID BAR NAME
do
 echo "$SERVICE_ID) $NAME Service"
done
#get selected service's id
read SERVICE_ID_SELECTED
SERVICE_SELECTED_ID=$($PSQL "select service_id from services where service_id=$SERVICE_ID_SELECTED")
if [[ -z $SERVICE_SELECTED_ID ]]
then
 MAIN_MENU "I could not find that service. What would you like today?"
fi
#validate that the service exist
#get customer's phone
echo -e "\nWhat's your phone number?"
read CUSTOMER_PHONE
#validate if customer exist
CUSTOMER_NAME=$($PSQL "select name from customers where phone='$CUSTOMER_PHONE'")
if [[ -z $CUSTOMER_NAME ]]
then
#if not exist
#get customer's name
echo -e "\nI don't have a record for that phone number, what's your name?"
read CUSTOMER_NAME
#insert customer into database
CUSTOMER_INSERT_RESULT=$($PSQL "insert into customers(name,phone) values('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
fi
CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")
SERVICE_FORMATED_NAME=$($PSQL "select name from services where service_id='$SERVICE_SELECTED_ID'" | sed -r 's/^ *| *$//g')
CUSTOMER_FORMATED_NAME=$(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')
#ask for time
echo -e "\nWhat time would you like your $SERVICE_FORMATED_NAME, $CUSTOMER_FORMATED_NAME?"
#get time
read SERVICE_TIME
TIME_FORMATED=$(echo $SERVICE_TIME | sed -r 's/^ *| *$//g')
#insert into appointment
APPOINTMENT_INSERT_RESULT=$($PSQL "insert into appointments(customer_id,service_id,time) values($CUSTOMER_ID,$SERVICE_SELECTED_ID,'$TIME')")
#show final message
echo -e "\nI have put you down for a $SERVICE_FORMATED_NAME at $TIME_FORMATED, $CUSTOMER_FORMATED_NAME."
#show menu again (list of serices)
MAIN_MENU
}
MAIN_MENU
