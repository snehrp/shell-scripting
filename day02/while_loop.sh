#!/bin/bash

<< comment
This file contains the while loop
comment

num=0
while [[ $num -le 10 ]];
do
	echo "Number is $num"
	num=$((num + 2))
done
