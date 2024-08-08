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
        echo -e "I could not find that element in the database."
    else
        #show message
        echo "$SELECT_RESULT" | while IFS="|" read TYPE_ID ATOMIC_NUMBER ATOMIC_MASS MELTING_POINT BOILING_POINT SYMBOL ELEMENT_NAME TYPE_NAME
        do
            echo "The element with atomic number $(echo $ATOMIC_NUMBER | sed -r 's/^ *| *$//g') is $(echo $ELEMENT_NAME | sed -r 's/^ *| *$//g') ($(echo $SYMBOL | sed -r 's/^ *| *$//g')). It's a $(echo $TYPE_NAME | sed -r 's/^ *| *$//g'), with a mass of $(echo $ATOMIC_MASS | sed -r 's/^ *| *$//g') amu. $(echo $ELEMENT_NAME | sed -r 's/^ *| *$//g') has a melting point of $(echo $MELTING_POINT | sed -r 's/^ *| *$//g') celsius and a boiling point of $(echo $BOILING_POINT | sed -r 's/^ *| *$//g') celsius."
        done
    fi
else
    echo "Please provide an element as an argument."
fi