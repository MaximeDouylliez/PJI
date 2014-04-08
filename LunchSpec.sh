#!/bin/bash
CpuSpecPath=$1
SpecPath=$2
Spec=$3
ProcessName=$4
$PowerAPIScriptName=$5



trap bashtrap INT
clear;

bashtrap()
{
pkill runspec
pkill specinvoke
pkill $ProcessName
kill -2 `pidof -x run.sh`
}


cd $CpuSpecPath
. ./shrc
cd $Specpath
runspec $Spec --no-reportable&

wait `pidof Dummy`

kill -2 `pidof -x $PowerAPIScriptName`
echo 'fin du script runnant la spec' $3
