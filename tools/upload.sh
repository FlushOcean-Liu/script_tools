#!/usr/bin/expect


# yum install tcl
# yum install tk
# yum install expect

set timeout 30
spawn scp ./src/build/bid_recur root@192.168.5.50:/home/liugh/

expect "password:"

send "Tac@yamu.com!@#456\n"

expect eof

