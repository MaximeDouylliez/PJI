#!/bin/bash
#Variables pour LunchSpecSuit.sh
CpuSpecPath='/home/hellion/cpu2006'
SpecPath='/home/hellion/cpu2006/benchspec/CPU2006'
ProcessNameExtension='_base_i386'
$PowerAPIScriptName='run.sh'


#Variables pour ce script
ScriptPath='/home/hellion/Desktop'
SpecList='/home/hellion/Desktop/SpecList.txt'
ExecuteSampling=$1


#Variables pour LunchSampling.sh
SamplingPath='/home/hellion/powerapi-master/tools/tool-sampling'
MessagesPerStep=4
StepsPerSample=10
SamplesPerSampling=4
NbCore=2
CorrelationCoef=0.998
ExecuteSampling=$1

#Variables pour LunchPowerAPI.sh
PowerAPIPath='/home/hellion/powerapi-master'
TDP=50
Time=180


trap bashtrap INT
clear;

#bashtrap()
#{
#echo 'Ok, interruption immediate, pas de soucis engendres !'
#exit 0
#}

#vérifie que le nombre d'argument est correct
if [ "1" -ne "$#" ]
then echo "Usage: arg1=SamplingExecution (1=yes/other=no)"
exit 0
fi

#Effectue le sampling si demandé
if [ "1" -eq "$ExecuteSampling" ]
then ./LunchSampling.sh $SamplingPath $MessagesPerStep $StepsPerSample $SamplesPerSampling $NbCore $CorrelationCoef
fi

#compter le nombre de ligne de spec list
I=`cat $SpecList | wc -l`

for j in `seq 1 $I`; do
   

    #ProcessName=`head -n $j $SpecList | tail -n 1 |cut -d '!' -f 2`
    Spec=`head -n $j $SpecList | tail -n 1 |cut -d '!' -f 1`
    ProcessName=$Spec$ProcesseNameExtension
echo "Monitoring de la spec $Spec" 
     cd $ScriptPath
./LunchPowerAPI.sh $PowerAPIPath $ProcessName $TDP $Time&

echo "Execution de la spec $Spec" 
     cd $ScriptPath
#Lancement du monitoring dans LunchSpec, connaissance du pid nécessaire
    ./LunchSpec.sh $CpuSpecPath $SpecPath $Spec $ProcessName $PowerAPIPath $PowerAPIScriptName
   sleep 5;
done


echo 'Fin du script maitre'

 
