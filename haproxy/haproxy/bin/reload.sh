#!/bin/sh
echo "reload" | socat STDIO /var/run/haproxy-master.sock
