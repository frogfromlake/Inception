#!/bin/bash

# This script will continuously try to connect to the other services and log the resuts

interval=120;

ftp_file="ftp_log";
mariadb_file="mariadb_log";
nginx_file="nginx_log";
redis_file="redis_log";
static_file="static_log";
wordpress_file="wordpress_log";
adminer_file="adminer_log";

# Log funnction
# $1 log file
# $2 reachability as 0/1
log()
{
    local log_file=$1;
    local reachable=$2;
    local time_=$(date);

    if [ $reachable -eq 0 ] ; then
        echo "REACHABLE     " $time_ >> $log_file;
    else
        echo "NOT REACHABLE " $time_ >> $log_file;
    fi
}

# Checks wether a service is reachable
# $1 service name
check_reachability()
{
    ping -c 1 $1 &> /dev/null;
    echo $?
}

log $adminer_file $(check_reachability "adminer")
log $ftp_file $(check_reachability "ftp")
log $mariadb_file $(check_reachability "mariadb")
log $nginx_file $(check_reachability "nginx")
log $redis_file $(check_reachability "redis")
log $static_file $(check_reachability "static")
log $wordpress_file $(check_reachability "wordpress")

sleep $interval;