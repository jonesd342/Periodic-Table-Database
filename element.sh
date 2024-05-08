PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

ARG=$1

if [[ -z $ARG ]]
then
  # no argument given
  echo "Please provide an element as an argument."
else
  # argument given, determine if it's a name, symbol, or number
  if [[ ! $ARG  =~ ^[0-9]+$ ]]
  then
  # input is a number
    LENGTH=$(echo -n "$ARG" | wc -m)
    if [[ $LENGTH -gt 2 ]]
    then
      # use name to get properties
      ELEM=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$ARG'")
      if [[ -z $ELEM ]]
      then
        echo "I could not find that element in the database."
      else
      # display element data
        echo "$ELEM" | while read BAR BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELT BAR BOIL BAR TYPE
        do
          echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
        done
      fi
    else
      # use symbol to get properties
      ELEM=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$ARG'")
      if [[ -z $ELEM ]]
      then
        echo "I could not find that element in the database."
      else
      # display element data
        echo "$ELEM" | while read BAR BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELT BAR BOIL BAR TYPE
        do
          echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
        done
      fi
    fi

  else
    # use number to get properties
    ELEM=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$ARG")
    if [[ -z $ELEM ]]
      then
        echo "I could not find that element in the database."
      else
      # display element data
        echo "$ELEM" | while read BAR BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELT BAR BOIL BAR TYPE
        do
          echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
        done
      fi

fi
fi