#!/bin/bash

tunt() {
    local now="$(command date +%s)"

    if [ -z "$1" ]; then
        local then="$(command date -d "tomorrow 0" +%s)"
    else
        local then="$(command date -d "$1" +%s)"
    fi

    local time_between="$(($then - $now))"
    local past=""


    if [ "$time_between" -lt 0 ]; then
        past="-"
        time_between=$((-$time_between))
    fi

    if [ "$time_between" -le "60" ]; then
        echo "$past$(($time_between % 60))s"
    elif [ "$time_between" -le "3600" ]; then
        echo "$past$(($time_between / 60))m $(($time_between % 60))s"
    else
        echo "$past$(($time_between / 3600))h $(($time_between % 3600 / 60))m $(($time_between % 60))s"
    fi
}
