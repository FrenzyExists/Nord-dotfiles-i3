#!/bin/bash

#########################################################################
# THIS IS A MODIFIED VERSION OF THE ENDEAVOR OS SCRIPT PLZ DON'T SUE ME #
#########################################################################

# HOW IT WORKS:
# Get two lists: one containing the workspaces and the other boolean values refering if workspace is focused or not

SOMEWORKSPACES=$(i3-msg -t get_workspaces | tr ',' '\n' | grep num)
FOCUSEDWORKSPACES=$(i3-msg -t get_workspaces | tr ',' '\n' | grep "focused")

# Create Arrays
arr=()
arr_II=()

# Append string to arrays
for i in ${FOCUSEDWORKSPACES//"\"focused\":"/}
do
	arr+=($i)
#	echo $i
done

for i in ${SOMEWORKSPACES//"\"num\":"/}                          
do             
        arr_II+=($i)                                                    
done

counter=0
# Iterate over and kill the one that is focused
for i in ${arr[@]}
do
	
	if [ "$i" = "true" ];then
		i3-msg '[workspace='${arr_II[$counter]}'] kill'
		echo "bruh"
	fi
	counter=$((counter+1))
done


