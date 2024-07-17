#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

# echo $($PSQL "TRUNCATE appointments, customers, services")


echo -e "\n~~~~~ Salon Appointment Scheduler ~~~~~\n"

MAIN_MENU() {
if [[ $1 ]]
then echo -e "\n$1"
fi
echo How may I help you?
echo -e "\n1. Hair Cut"
echo 2. Hair Perm
echo 3. Hair Clinic
echo 4. Exit
read MAIN_MENU_SELECTION
}

CUT_MENU() {
# get service id
echo What is your service id?
read SERVICE_ID_SELECTED

# if not available
if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
then 
  # send to main menu
  MAIN_MENU "That is not a valid service ID number."
else
  # get customer info
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get new customer name
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME

    # insert new customer
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES ('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
  
  else
    # get customer_id
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

    # get service_time
    echo -e "\nWhen is your service time?"
    read SERVICE_TIME

    # insert appointnemts
    INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(service_id, customer_id, time) VALUES('$SERVICE_ID_SELECTED', '$CUSTOMER_ID', '$SERVICE_TIME')")

    # get appointments info
    APPO_INFO_1=$($PSQL "SELECT time FROM appointments WHERE service_id=$SERVICE_ID_SELECTED")
    APPO_INFO_FORMATTED=$(echo $APPO_INFO_1 | sed 's/ |//g')
    # send to main menu
    MAIN_MENU "I have put you down for a cut at $APPO_INFO_FORMATTED, $CUSTOMER_NAME."

  fi
fi
}

PERM_MENU() {
# get service id
echo What is your service id?
read SERVICE_ID_SELECTED

# if not available
if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
then 
  # send to main menu
  MAIN_MENU "That is not a valid service ID number."
else
  # get customer info
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get new customer name
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME

    # insert new customer
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES ('$CUSTOMER_NAME','$CUSTOMER_PHONE')")

  else
    # get customer_id
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

    # get service_time
    echo -e "\nWhen is your service time?"
    read SERVICE_TIME

    # insert appointnemts
    INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(service_id, customer_id, time) VALUES('$SERVICE_ID_SELECTED', '$CUSTOMER_ID', '$SERVICE_TIME')")

    # get appointments info
    APPO_INFO_1=$($PSQL "SELECT time FROM appointments WHERE service_id=$SERVICE_ID_SELECTED")
    APPO_INFO_FORMATTED=$(echo $APPO_INFO_1 | sed 's/ |//g')
    # send to main menu
    MAIN_MENU "I have put you down for a perm at $APPO_INFO_FORMATTED, $CUSTOMER_NAME."

  fi
fi
}

CLINIC_MENU() {
# get service id
echo What is your service id?
read SERVICE_ID_SELECTED

# if not available
if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
then 
  # send to main menu
  MAIN_MENU "That is not a valid service ID number."
else
  # get customer info
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get new customer name
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME

    # insert new customer
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES ('$CUSTOMER_NAME','$CUSTOMER_PHONE')")

  else
    # get customer_id
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

    # get service_time
    echo -e "\nWhen is your service time?"
    read SERVICE_TIME

    # insert appointnemts
    INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(service_id, customer_id, time) VALUES('$SERVICE_ID_SELECTED', '$CUSTOMER_ID', '$SERVICE_TIME')")

    # get appointments info
    APPO_INFO_1=$($PSQL "SELECT time FROM appointments WHERE service_id=$SERVICE_ID_SELECTED")
    APPO_INFO_FORMATTED=$(echo $APPO_INFO_1 | sed 's/ |//g')
    # send to main menu
    MAIN_MENU "I have put you down for a clinic at $APPO_INFO_FORMATTED, $CUSTOMER_NAME."

  fi
fi
}



EXIT() {
echo -e "\nThank you for stopping in.\n"
}


MAIN_MENU

case $MAIN_MENU_SELECTION in
  1) CUT_MENU  ;;
  2) PERM_MENU ;;
  3) CLINIC_MENU ;;
  4) EXIT ;;
  *) MAIN_MENU "Please enter a valid option." ;;
esac