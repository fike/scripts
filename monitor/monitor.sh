#!/bin/bash

IPT=$(which iptables)
BROWSER=$(which lynx)
. /etc/monitor/monitor.conf
NC=$(which nc)

VALIDADOR=$($BROWSER -dump $MONITOR 2> /dev/null)


fwlimpa()
{

$IPT -F
$IPT -F -t nat
$IPT -F -t mangle
$IPT -P INPUT ACCEPT
$IPT -P OUTPUT ACCEPT
$IPT -P FORWARD ACCEPT
}


master()
{
	fwlimpa
	$IPT -t nat -A PREROUTING -d $DESTINO -j DNAT --to $IPMASTER
	$IPT -t nat -A POSTROUTING -d $IPMASTER  -j SNAT --to $DESTINO 
}

slave(){
	fwlimpa
	$IPT -t nat -A PREROUTING -d $DESTINO -j DNAT --to $IPSLAVE
	$IPT -t nat -A POSTROUTING -d $IPSLAVE -j SNAT --to $DESTINO
}

manual()
{
if [ $VALIDADOR = stop ]
	then
	echo "$VALIDADOR do stop"
	master
elif [ $VALIDADOR = start ] 
then
	echo  "$VALIDADOR do start" 
	slave
elif [ $VALIDADOR = nothing ]
then
	echo "nothing"
fi
	
}

auto()
{

if [ `$NC -v -z $URL  ${PORTAS[@]} 2>&1 | wc -l` -eq $REPEAT ] 
then
	echo "Sucesso no teste de monitoramento de serviços"
else
	COUNTER=1
	while [ $COUNTER -lt $REPEAT  ] 
	do
		sleep $TEMPO
		if [ `$NC -v -z $URL  ${PORTAS[@]} 2>&1 | wc -l` -eq $REPEAT ]
		then
			echo "Após $COUNTER tentativas, os serviços voltaram"
			break
		else
			echo "$COUNTER tentativa de conexão nos serviços"
			let COUNTER=COUNTER+1
		fi
		if [ $COUNTER -eq $REPEAT ]
		then
			echo "Aplicando mudando de roteamento"
			slave
		fi
	done
fi
}

active()
{
master
}


case "$1" in
   manual)
   	manual
	;;
   auto)
	auto
	;;
   active)
   	active
	;;
   *)
   	echo "Usage: $0 {manual|auto|active}"
	exit 1
	;;
esac
exit 0
