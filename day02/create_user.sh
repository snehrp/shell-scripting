#!/bin/bash

read -p "Enter the username : " username

echo "Your username is $username"

sudo useradd -m $username

echo "User with the username $username has been sucessfully added"
