#!/bin/bash

#This file constains the While and For loop

<< task
$1 is the argument 1 which is folder's name
$2 is the start range
$3 is the end range
task

for (( i=$2; i<=$3 ; i++ ));
do
	echo "folder's name is $1$i"
done
