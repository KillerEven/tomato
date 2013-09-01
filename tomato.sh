#!/bin/bash
#这是一个实践番茄工作法的程序

#输出到屏幕并输出到文件的函数
function echof {
	if ! [ $# -eq 2 ]
	then 
		return 1
	fi
	echo $1
	echo $1 >> $2
}

#模拟番茄计时器的函数
function tomatoClock {
	beginTime=`date`
	sleepTime=$2
	echof "事件：\"$1\"" "$3"
	echof "开始：$beginTime" "$3"
	sleep $sleepTime
	endTime=`date`
	nohup ring >/dev/null 2>&1 &
	echof "结束：$endTime" "$3"
	echo >> $3
}

#判断程序参数是否只有一个
if ! [ $# -eq 1 ]
then 
	echo "用法: tomato <事件描述>"
	exit 1
fi

#初始化基础变量
count=0
day=`date +%Y-%m-%d-%A` 
answer=Y
logFile=~/.tomato/log/$day.log

#调用番茄计时器的循环
until [ $answer = "N" ] || [ $answer = "n" ]
do
	if [ $answer = "Y" ] || [ $answer = "y" ]
	then
		count=$[ $count + 1 ]
		echo
		echo ——开启第$count个番茄——
		tomatoClock "$1" 1500 "$logFile"
		echo ——第$count个番茄结束——
		echo
	fi
	echo -e "刚刚结束的是第$count个番茄\n请稍作休息……"
	echo -n "为同一事件开启下一个番茄[Y/N]?"
	read answer
done

#输出总结到文件并退出tomato
echof "事件\"$1\"共用$count个番茄" "$logFile"
echo "————————————————————————————————————————" >> $logFile
exit 0
