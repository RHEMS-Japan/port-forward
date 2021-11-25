#!/bin/bash

printf "READY\n";

while read line; do
    echo "Processing Events: $line" >&2;
    kill -SIGQUIT $PPID
done < /dev/stdin
