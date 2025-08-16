#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FILE="/var/log/shell_scripting_logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGS_FOLDER="$LOGS_FILE/$SCRIPT_NAME.log"
PACKAGES=("mysql" "nginx")

mkdir -p $LOGS_FILE
echo "we have successfully logs folder created" | tee -a $LOGS_FOLDER

if [ $USERID -eq 0 ]
then
    echo "You are running with root access" | tee -a $LOGS_FOLDER
else
    echo "Please run with root access" | tee -a $LOGS_FOLDER
    exit 1
fi

VALIDATE(){
    if [$1 -eq 0]
    then
        echo "$2 install success" | tee -a $LOGS_FOLDER
    else
        echo "$2 install failure" | tee -a $LOGS_FOLDER
        exit 1
    fi
}

dnf list installed mysql 

if [ $? -eq 0 ]
then
    echo "mysql already installed...nothing to do" | tee -a $LOGS_FOLDER
else
    echo "mysql is not installed...installing now" | tee -a $LOGS_FOLDER
    dnf install mysql -y
    VALIDATE $? "mysql"
fi

for i in ${PACKAGES[@]}
do
    echo "$i"
done