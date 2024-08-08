#!/bin/bash

# element description program

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

if [[ $1 ]] 
then 
  SELECT_RESULT=$($PSQL "SELECT * FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$1")
  echo "$SELECT_RESULT" | while IFS="|" read TYPE_ID ATOMIC_NUMBER ATOMIC_MASS MELTING_POINT BOILING_POINT SYMBOL ELEMENT_NAME TYPE_NAME
  do
    echo -e "\nThe element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($SYMBOL). It's a $TYPE_NAME, with a mass of $ATOMIC_MASS amu. Hydrogen has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius.\n"
  done
else
    echo "Please provide an element as an argument."
fi