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
SERVICES=$($PSQL "select service_id, name from services")
#show services propertly
echo "$SERVICES" | while read SERVICE_ID BAR NAME
do
  echo "$SERVICE_ID) $NAME"
done
#get selected service's id
read SERVICE_ID_SELECTED
IS_SERVICE_AVAILABLE=$($PSQL "select service_id,name from services where service_id=$SERVICE_ID_SELECTED")
if [[ -z $IS_SERVICE_AVAILABLE ]]
then
  MAIN_MENU "I could not find that service. What would you like today?"
else
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  EXIST_CUST=$($PSQL "select * from customers where phone='$CUSTOMER_PHONE'")
  if [[ -z $EXIST_CUST ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    CUST_INSERTED=$($PSQL "insert into customers(name,phone) values('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
    CREATE_APPOINTMENT
  else
    CREATE_APPOINTMENT
  fi
fi
}
CREATE_APPOINTMENT(){
CUST_NAME=$($PSQL "select name from customers where phone='$CUSTOMER_PHONE'") 
 CUST_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'") 
 CUST_NAME_FORMATED=$(echo $CUST_NAME | sed -r 's/^ *| *$//g')
 SERV_NAME=$($PSQL "select name from services where service_id=$SERVICE_ID_SELECTED")
 SERV_NAME_FORMATED=$(echo $SERV_NAME | sed -r 's/^ *| *$//g')
 echo -e "\nWhat time would you like your $SERV_NAME_FORMATED, $CUST_NAME_FORMATED?"
 read SERVICE_TIME
 APPOINTMENT=$($PSQL "insert into appointments(customer_id,service_id,time) values($CUST_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
 echo -e "\nI have put you down for a $SERV_NAME_FORMATED at $SERVICE_TIME, $CUST_NAME_FORMATED."
}
MAIN_MENU
