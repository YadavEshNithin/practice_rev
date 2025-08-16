#!/bin/bash

# USERID=$(id -u)
# R="\e[31m"
# G="\e[32m"
# Y="\e[33m"
# N="\e[0m"

# LOGS_FILE="/var/log/shell_scripting_logs"
# SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
# LOGS_FOLDER="$LOGS_FILE/$SCRIPT_NAME.log"
# PACKAGES=("mysql" "nginx" "python")

# mkdir -p $LOGS_FILE
# echo "we have successfully logs folder created" | tee -a $LOGS_FOLDER

# if [ $USERID -eq 0 ]
# then
#     echo "You are running with root access" | tee -a $LOGS_FOLDER
# else
#     echo "Please run with root access" | tee -a $LOGS_FOLDER
#     exit 1
# fi

# VALIDATE(){
#     if [ $1 -eq 0 ]
#     then
#         echo "$2 install success" | tee -a $LOGS_FOLDER
#     else
#         echo "$2 install failure" | tee -a $LOGS_FOLDER
#         exit 1
#     fi
# }

# # dnf list installed mysql 

# # if [ $? -eq 0 ]
# # then
# #     echo "mysql already installed...nothing to do" | tee -a $LOGS_FOLDER
# # else
# #     echo "mysql is not installed...installing now" | tee -a $LOGS_FOLDER
# #     dnf install mysql -y
# #     VALIDATE $? "mysql"
# # fi

# for i in ${PACKAGES[@]}
# do
#     dnf list installed $i 

#     if [ $? -eq 0 ]
#     then
#         echo "$i  already installed...nothing to do" | tee -a $LOGS_FOLDER
#     else
#         echo "$i  is not installed...installing now" | tee -a $LOGS_FOLDER
#         dnf install $i  -y
#         VALIDATE $? "$i"
#     fi
# done



USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
PACKAGES=("mysql" "python" "nginx" "httpd")

mkdir -p $LOGS_FOLDER
echo "Script started executing at: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR:: Please run this script with root access $N" | tee -a $LOG_FILE
    exit 1 #give other than 0 upto 127
else
    echo "You are running with root access" | tee -a $LOG_FILE
fi

# validate functions takes input as exit status, what command they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "Installing $2 is ... $G SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "Installing $2 is ... $R FAILURE $N" | tee -a $LOG_FILE
        exit 1
    fi
}

#for package in ${PACKAGES[@]}
for package in $@
do
    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ]
    then
        echo "$package is not installed... going to install it" | tee -a $LOG_FILE
        dnf install $package -y &>>$LOG_FILE
        VALIDATE $? "$package"
    else
        echo -e "Nothing to do $package... $Y already installed $N" | tee -a $LOG_FILE
    fi
done