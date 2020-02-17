#!/bin/bash

#RANGE=4
#number=$RANDOM
#let "number %= $RANGE"
#echo "Random number less than $RANGE  ---  $number"

##########################################
# remotely access edge devices nodes and read the current loadavarage

declare -g edge_devices=('130.209.252.49' '130.209.253.224' '130.209.253.225' '18.212.31.138')
declare -g nodes_loadavarages=($cpu_usage1 $cpu_usage2 $cpu_usage3 $cpu_usage4)

echo -e
echo Edge_nodes are: ${edge_devices[*]}
echo Load_averages are: ${nodes_loadavarages[*]}

echo -e

cpu_usage1=$(ssh pi@${edge_devices[0]} cat /proc/loadavg | awk '{print $1}')
echo loadavarage of ${edge_devices[0]} is $cpu_usage1

cpu_usage2=$(ssh pi@${edge_devices[1]} cat /proc/loadavg | awk '{print $1}')
echo loadavarage of ${edge_devices[1]} is $cpu_usage2

cpu_usage3=$(ssh pi@${edge_devices[2]} cat /proc/loadavg | awk '{print $1}')
echo loadavarage of ${edge_devices[2]} is $cpu_usage3

cpu_usage4=$(ssh -i "EC2.pem" ubuntu@18.212.31.138 cat /proc/loadavg | awk '{print $1}')
echo loadavarage of 18.212.31.138 is $cpu_usage4

echo ""

nodes_loadavarages=($cpu_usage1 $cpu_usage2 $cpu_usage3 $cpu_usage4)

echo Edge_nodes are: ${edge_devices[@]}
echo Load_averages are: ${nodes_loadavarages[@]}

echo ""

max=${nodes_loadavarages[0]}
min=${nodes_loadavarages[0]}


#echo max is $max
#echo min is $min

for i in "${nodes_loadavarages[@]}";
do
  (($(echo "$i > $max" |bc -l) )) && max=$i
  (($(echo "$i < $min" |bc -l) )) && min=$i
done

echo max is $max
echo min is $min


echo ""

##########################################
# remotely access edge devices nodes and read the hardware specifications

cpu_info1=$(ssh pi@${edge_devices[0]} cat /proc/cpuinfo | awk -F: '/model name/ {name=$2} END {print name}')
echo cpuinfo of ${edge_devices[0]} is $cpu_info1
echo -e

cpu_info2=$(ssh pi@${edge_devices[1]} cat /proc/cpuinfo | awk -F: '/model name/ {name=$2} END {print name}')
echo cpuinfo of ${edge_devices[1]} is $cpu_info2
echo -e

cpu_info3=$(ssh pi@${edge_devices[2]} cat /proc/cpuinfo | awk -F: '/model name/ {name=$2} END {print name}')
echo cpuinfo of ${edge_devices[2]} is $cpu_info3
echo -e

cpu_info4=$(ssh -i "EC2.pem" ubuntu@18.212.31.138 cat /proc/cpuinfo | awk -F: '/model name/ {name=$2} END {print name}')
echo cpuinfo 18.212.31.138 is $cpu_info4

#########################################

echo -e
