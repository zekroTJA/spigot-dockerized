#!/bin/bash

JVM_SETT_FILE=$1
SPIGOT_FILE=$2
CONFIG_LOC=$3
PLUGINS_LOC=$4
WORLDS_LOC=$5

if ! [ -f $JVM_SETT_FILE ]; then
    printf "#### JVM START SETTINGS ###\n\nMAX_RAM=\"2G\"\nMIN_RAM=\"1G\"\n" \
        | tee $JVM_SETT_FILE
    echo "JVM CONFIG FILE CREATED IN $JVM_SETT_FILE."
    echo "FI YOU WANT, YOU CAN STOP AND RECOFIGURE IT NOW."
fi

source $JVM_SETT_FILE

echo -Xms${MIN_RAM} -Xmx${MAX_RAM}

c=0
while (( c < 100 )); do 
    java -jar -Xms${MIN_RAM} -Xmx${MAX_RAM} ${SPIGOT_FILE} \
        --commands-settings ${CONFIG_LOC}/commands.yml \
        --plugins ${PLUGINS_LOC} \
        --spigot-settings ${CONFIG_LOC}/spigot.yml \
        --world-container ${WORLDS_LOC} \
        --bukkit-settings ${CONFIG_LOC}/bukkit.yml

    c=$(( c + 1 ))
done;