#!/bin/bash
rm socat*.ini
ENV_NAMEING_RULE=FORWARD

echo -e '\n<START : CREATE CONFIG>'
ENVS=(`(printenv | grep $ENV_NAMEING_RULE)`)
for i in "${!ENVS[@]}"
do
    # FORWARD_01=80:80:127.0.0.1
    echo "${ENVS[$i]}";
    number=$(printf "%02d\n" "${i}")
    # echo "number = $number"

    # [FORWARD_01, 80:80:127.0.0.1]
    PARAMS=(${ENVS[$i]//=/ })

    # [80, 80, 127.0.0.1]
    PARAMS=(${PARAMS[1]//:/ })
    # echo "${PARAMS[@]}"
    
    LOCAL_PORT=${PARAMS[0]}
    REMOTE_HOST=${PARAMS[1]}
    REMOTE_PORT=${PARAMS[2]}

    FILENAME=socat$number.ini
    TITLE=[program:socat$number]
    COMMAND=command="socat tcp-listen:$LOCAL_PORT,reuseaddr,fork tcp:$REMOTE_HOST:$REMOTE_PORT"
    echo -e $TITLE > $FILENAME
    echo -e $COMMAND >> $FILENAME
    echo -e "stdout_logfile=/dev/stdout\nstdout_logfile_maxbytes=0\nstderr_logfile=/dev/stderr\nstderr_logfile_maxbytes=0" >> $FILENAME
    echo -e '\n---------------'

done

echo -e '\n<END : CREATE CONFIG>'

mv ./*.ini /etc/supervisor.d/