#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo " please run with root access"
    exit 1
else
    echo " you are running with root access"
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo "$2 installed correctly"
    else    
        echo "$2 did not installed correctly"
        exit 1
    fi
}

dnf list installed mysql

if [ $? -eq 0 ]
then
    echo "mysql installed already success" 
else
    echo "mysql not installed...now installing"

    dnf install mysql -y
    
    VALIDATE $? mysql
    
fi