#!/bin/bash

create_directory() {
	mkdir demo
}

if ! create_directory; then
	echo "This will not work as the folder already exist"
	exit 1
fi

echo "this should not work because the code has been interupted"
