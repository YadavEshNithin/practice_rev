#!/bin/bash

USERID=$(id -u)
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

check_root(){
    if [ $USERID -eq 0 ]
    then 
        echo "You are running with root access"
    else
        echo "Please run with the root access"
        exit 1
    fi
}

VALIDATE(){
    if [ $1 -eq 0 ]
    then 
        $2 installed success
    else
        $2 installed failure
    fi
}
USAGE(){
    echo "error: the usage is sh backup.sh <source-dir> <dest-dir> days(optional)"
    exit 1
}

if [ $# -lt 2 ]
then
    USAGE
fi

check_root

if [ ! -d $DEST_DIR ]
then
    echo "the provided destination dir does not exist"
    exit 1
fi

Files=$( find $SOURCE_DIR -name "*.log" -mtime +$DAYS )

if [ -z $Files ]
then
    echo "not found files older than 14 days...skipping"
else
    echo "files are found...now zipping files are: $Files"
    Zipfiles="$DEST_DIR/app-logs.zip"
    $Files | zip -@ "$Zipfiles"

    if [ -f $Zipfiles ]
    then 
        echo "zip created success"

        while IFS= read -r filename
        do
            echo "deleting the files after backup"
            rm -rf $filename
        done <<< $Files
    fi
fi