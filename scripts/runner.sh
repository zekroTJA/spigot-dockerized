#!/bin/bash

JVM_SETT_FILE=$1
JVM_SETT_FILE_DEF=$2
SPIGOT_FILE=$3
CONFIG_LOC=$4
PLUGINS_LOC=$5
WORLDS_LOC=$6
EULA_FILE=$7

if ! [ -f $JVM_SETT_FILE ]; then
    cp $JVM_SETT_FILE_DEF $JVM_SETT_FILE
    printf "\n\nJVM CONFIG FILE CREATED IN $JVM_SETT_FILE.\n"
    printf "FI YOU WANT, YOU CAN STOP AND RECOFIGURE IT NOW.\n\n"
fi

source $JVM_SETT_FILE

c=0
while (( c < 100 )); do 
    [ -f $EULA_FILE ] || _EULA="false"

    java -jar -Xms${MIN_RAM} -Xmx${MAX_RAM} ${OTHER_PARAMS} \
        ${SPIGOT_FILE} \
        --commands-settings ${CONFIG_LOC}/commands.yml \
        --plugins ${PLUGINS_LOC} \
        --spigot-settings ${CONFIG_LOC}/spigot.yml \
        --world-container ${WORLDS_LOC} \
        --bukkit-settings ${CONFIG_LOC}/bukkit.yml

    if [ $_EULA == "false" ]; then
        printf "\n\nPLEASE ACCEPT MOJANGS EULA BY EDITING $EULA_FILE.\n"
        printf "THEN RESTART.\n\n"
        exit
    fi

    c=$(( c + 1 ))
done;