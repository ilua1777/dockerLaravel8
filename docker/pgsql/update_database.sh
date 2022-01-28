#!/bin/bash

read -p 'Run the script to create a database dump? (y/n) ' RUN_SCRIPT
if [[ $RUN_SCRIPT == 'y' || -z $RUN_SCRIPT ]]
then
    read -p 'Create a new dump? (y/n) ' CREATE_DUMP
    if [[ $CREATE_DUMP == 'y' || -z $CREATE_DUMP ]]
    then
        read -p 'Please enter username: ' DB_USERNAME
        read -p 'Please enter database: ' DB_DATABASE
        read -p 'Please enter password: ' DB_PASSWORD
        
        read -p 'Use the default host? (y/n) ' DB_HOST_AGR
        if [[ $DB_HOST_AGR == 'y' || -z $DB_HOST_AGR ]]
        then
            host="pg2.sweb.ru"
        else
            read -p 'Please enter host: ' DB_HOST
            host=$DB_HOST
        fi
        
        read -p 'Use the default port? (y/n) ' DB_PORT_AGR
        if [[ $DB_PORT_AGR == 'y' || -z $DB_PORT_AGR ]]
        then
            port="5432"
        else
            read -p 'Please enter port: ' DB_PORT
            host=$DB_PORT
        fi
        
        DateCurrent=`date +"%m.%d.%Y".sql`
        i=1
        while [ -f "/var/database/$DateCurrent" ]
        do
            DateCurrent=`date +"%m.%d.%Y($i)".sql`
            i=$(( $i + 1 ))
        done
        
        pg_dump --dbname=postgresql://$DB_USERNAME:$DB_PASSWORD@$host:5432/$DB_DATABASE > /var/database/$DateCurrent
        
        echo "The creation of the database dump was successful. Name dump: $DateCurrent"
    fi
    echo "Enter the database data to import."
    
    read -p 'Please enter username: ' DBI_USERNAME
    read -p 'Please enter database: ' DBI_DATABASE
    read -p 'Please enter password: ' DBI_PASSWORD
    # read -p 'Please enter host: ' DBI_HOST
    # read -p 'Please enter port: ' DBI_PORT
    
    if psql -U $DBI_USERNAME -lqt | cut -d \| -f 1 | grep -qw $DBI_DATABASE;
    then
        psql -U $DBI_USERNAME -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$DBI_DATABASE';"
        psql -U $DBI_USERNAME -c "DROP DATABASE \"$DBI_DATABASE\";"
        psql -U $DBI_USERNAME -c "CREATE DATABASE \"$DBI_DATABASE\";"
    else
        psql -U $DBI_USERNAME -c "CREATE DATABASE \"$DBI_DATABASE\";"
    fi
    
    read -p 'Please enter name file dump: ' DBI_DUMP
    
    if [ ! -f "/var/database/$DBI_DUMP.sql" ]
    then
        echo "The file does not exist."
        exit
    fi
    
    psql -U $DBI_USERNAME -d $DBI_DATABASE -f "/var/database/$DBI_DUMP.sql"
    
    echo "The data has been successfully uploaded!"
fi