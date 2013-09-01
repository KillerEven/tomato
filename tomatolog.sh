#!/bin/bash
logDir=~/.tomato/log/
cd $logDir
logFileList=`ls`
if [ $# -eq 1 ] 
then
	echo $1
	logFileList=`ls|grep $1`
fi
cat $logFileList
