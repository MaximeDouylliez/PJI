#!/bin/bash
PowerApiSamplingPath=$1
MessagesPerStep=$2
StepsPerSample=$3
SamplesPerSampling=$4
NbCore=$5
CorrelationCoef=$6

if [ "6" -ne "$#" ]
then echo "Usage: arg1=PowerApiSamplingPath arg2=MessagesPerStep arg3=StepsPerSample arg4=SamplesPerSampling arg5=NbCore arg6=CorrelationCoef"
exit 0
fi
cd $PowerApiSamplingPath/src/main/resources

echo "`sed '3  c\		core = '$NbCore hardware.conf`" >hardware.conf
echo "`sed '5  c\                count = '$MessagesPerStep tool-sampling.conf`" >tool-sampling.conf 
echo "`sed '8  c\            activity-step = '$StepsPerSample tool-sampling.conf`" >tool-sampling.conf 
echo "`sed '12  c\        count = '$SamplesPerSampling tool-sampling.conf`" >tool-sampling.conf 
echo "`sed '13  c\        corr_coeff = '$CorrelationCoef tool-sampling.conf`" >tool-sampling.conf 




cd $PowerApiSamplingPath

mvn scala:run
