#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FILE="/var/log/shell_scripting_logs??"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGS_FOLDER="$LOGS_FILE/$SCRIPT_NAME.log"
PACKAGES=("mysql" "nginx" "python")

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
    if [ $1 -eq 0 ]
    then
        echo -e "$G...$2 install success $N..." | tee -a $LOGS_FOLDER
    else
        echo -e "$R...$2 install failure $N..." | tee -a $LOGS_FOLDER
        exit 1
    fi
}

# dnf list installed mysql 

# if [ $? -eq 0 ]
# then
#     echo "mysql already installed...nothing to do" | tee -a $LOGS_FOLDER
# else
#     echo "mysql is not installed...installing now" | tee -a $LOGS_FOLDER
#     dnf install mysql -y
#     VALIDATE $? "mysql"
# fi

for i in ${PACKAGES[@]}
do
    dnf list installed $i 

    if [ $? -eq 0 ]
    then
        echo -e "$Y...$i already installed...nothing to do $N..." | tee -a $LOGS_FOLDER
    else
        echo "$i  is not installed...installing now" | tee -a $LOGS_FOLDER
        dnf install $i  -y
        VALIDATE $? "$i"
    fi
done