#!/bin/bash

#a script that automatically parses a yaml file to create a corresponding parameter.json file
if [[ $# -eq 0 ]]; then
    echo "No arguments supplied... exiting"
    exit 1
elif [[ ! -f $1 ]]; then
    echo "File doesn't exist... exiting"
    exit 1
fi
parameters=($(sed '/Parameters:/,/^[A-Z]/!{/Parameters:/!{/^[A-Z] /!d}}' $1 | sed '1d; $d' | sed '/\ \ \ \ /d' | sed 's/://' | sed 's/\ \ //')) || (echo "error occured while parsing... exiting" ; exit 1)
function parameter(){
    echo "\t{\n\t\t\"ParameterKey\": \"$1\",\n\t\t\"ParameterValue\": \"$2\"\n\t},\n"
}
index=0
if [[ $# -gt 1 && $(($# - 1)) -eq ${#parameters[@]} ]]; then
    for i in "$@"; do
        if [[ $i != $1 ]];then
            objects+=$(parameter ${parameters[$index]} $i)
            ((index=index+1))
        fi
    done
else
    for i in "${parameters[@]}"; do
        echo -n "$i: "
        read ParameterValue
        objects+=$(parameter $i $ParameterValue)
    done
fi
echo success
echo -e "[\n${objects:0:-3}\n]" > "${1:0:-4}_parameters.json"
exit 0