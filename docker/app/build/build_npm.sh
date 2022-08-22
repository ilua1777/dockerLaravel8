#!/bin/bash

oldv=$(grep -i 'APP_VERSION=' $PWD/.env | grep -oP "[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}")

read -p "Update app version? Current - $oldv. (y/n) " update
if [[ $update == 'y' || -z $update ]]
then
	read -p 'Please enter the version number: ' newv
	sed -i 's/'$oldv'/'$newv'/g' $PWD/.env
fi