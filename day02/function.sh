#!/bin/bash

<< comment
This is just the comment
comment

function isloyal() {
read -p "Enter the bandi's name : " bandi
read -p "Enter the amount of love by Jethalal : " love

if [[ $bandi == 'daya' ]];
then
        echo "Jethalal is loyal"
elif [[ $love -ge 100 ]];
then
        echo "Jethalal is still loyal"
else
        echo "Jethalal is not loyal"
fi
}

isloyal
