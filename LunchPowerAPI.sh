#!/bin/bash
#Variables pour modifier le tdp indiqué dans le fichier de conf
PowerApiPath=$1
TDP=$2

#Variables pour lancer PowerApi en ligne de commande
ProcessName=$3
Time=$4


trap bashtrap INT
clear;

bashtrap()
{
echo 'Ok, interruption immediate du monitoring !'
exit 0
}







if [ "4" -ne "$#" ]
then echo "Usage: arg1=PowerApiPath arg2=TDP arg3=AppName arg2=TDP arg4=Time"
exit 0
fi

cd $PowerApiPath/tools/Tool-PowerApi/src/main/resources
echo "`sed '3  c\		tdp = '$4 hardware.conf`" >hardware.conf

cd $PowerApiPath
./run.sh -output file  -app $ProcessName  -aggregator process -time $Time&
