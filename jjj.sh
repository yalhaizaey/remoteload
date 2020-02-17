#!/bin/bash

cpu_usage1=10
cpu_usage2=5
cpu_usage3=300
cpu_usage4=500


declare -g nodes_loadavarages=($cpu_usage1 $cpu_usage2 $cpu_usage3 $cpu_usage4)
echo ${nodes_loadavarages[*]}


max=${nodes_loadavarages[0]}
min=${nodes_loadavarages[0]}

echo max is $max
echo min is $min

for i in "${nodes_loadavarages[@]}";
do
  (( i > max )) && max=$i
  (( i < min )) && min=$i
done

echo $xx
echo max is $max
echo min is $min
