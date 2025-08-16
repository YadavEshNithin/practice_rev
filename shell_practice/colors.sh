#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo -e "\e[31m Hello Colors \e[0m"
echo -e "\e[32m Hello Colors \e[0m"
echo -e "\e[33m Hello Colors \e[0m"
echo -e "\e[0m Hello Colors \e[0m"


echo -e "Hello No Colors"
echo -e "Hello $R Colors $N"
echo -e "Hello $G Colors $N"
echo -e "Hello $Y Colors $N"
echo -e "Hello $N Colors $N"
