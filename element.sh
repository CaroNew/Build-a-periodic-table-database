#!/bin/bash

if [[ $1 ]] 
then 
    echo -e "\nThe element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($SYMBOL). It's a $TYPE_NAME, with a mass of $ATOMIC_MASS amu. Hydrogen has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius.\n"
else
    echo "Please provide an element as an argument."
fi