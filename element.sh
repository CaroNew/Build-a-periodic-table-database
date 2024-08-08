#!/bin/bash

# element description program

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

if [[ $1 ]] 
then 
    #if is a number
    if [[ $1 =~ ^[0-9]+$ ]]
    then
        # searching atomic number
        SELECT_RESULT=$($PSQL "SELECT * FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$1")
    else
        # searching element symbol/name
        SELECT_RESULT=$($PSQL "SELECT * FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$1' or name='$1'")
    fi
  

    if [[ -z $SELECT_RESULT ]]
    then
        echo -e "\nI could not find that element in the database\n"
    else
        #show message
        echo "$SELECT_RESULT" | while IFS="|" read TYPE_ID ATOMIC_NUMBER ATOMIC_MASS MELTING_POINT BOILING_POINT SYMBOL ELEMENT_NAME TYPE_NAME
        do
            echo -e "\nThe element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($SYMBOL). It's a $TYPE_NAME, with a mass of $ATOMIC_MASS amu. Hydrogen has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius.\n"
        done
    fi
else
    echo -e "\nPlease provide an element as an argument.\n"
fi