#!/bin/bash

# Importing the bash simple curses library
source simple_curses.sh
# Importing logs collector
source logs.sh

main(){
    
    window "Karys System Monitoring Script" "green" "100%"
        append_tabbed " User: $(whoami) = Hostname: $(hostname) = Date: $(date)" 3 "="
        addsep
        append_tabbed "OS Informations - $(lsb_release -a | grep Description | awk -F: '{print $2}' | sed 's/^\s*//') = Kernel: $(uname -r) =  Architecture: $(uname -m)" 3 "="
        append ""
    endwin

    window "CPU Usage" "yellow" "100%"
        append "Uptime : $(uptime)"
        addsep 
        append "CPU Average Utilization: \n $(sar -P ALL 1 3 | grep -E '^Average' | awk '{print $1,$2,$3,$4,$5}')" 
        addsep
        append "Top 5 Processes: \n$(top -b -n 1 | awk 'NR==1 {print $1,$2,$9,$12} NR>7 {print $1,$2,$9,$12}' | sort -k3 -nr | head -n 5)"
    endwin

    window "Memory Usage" "yellow" "100%"
        append "$(free -h)"
    endwin

    window "Disk I/O" "yellow" "100%"
        append "$(iostat -d)"
        addsep
        append "Disk Usage: \n$(df -h | head -n 2)"
    endwin

    window "Network" "yellow" "100%"
        append "$(ping -c 1 google.com &> /dev/null && echo "  Status: Connected" || echo "  Status: Disconnected")"
        addsep
        append "Socket Connections: $(ss -s)"
    endwin

    window "Service Availability" "yellow" "100%"
        append_tabbed "SSH:$(systemctl is-active sshd)=DNS Bind Server:$(systemctl is-active named)=DHCP Server:$(systemctl is-active isc-dhcp-server)=Apache:$(systemctl is-active apache2)=MariaDB:$(systemctl is-active mariadb)" 5 "="
    endwin

    window "User Activity" "yellow" "100%"
        append "Today's Users:\n$(last | grep "$(date '+%a %b %e')")"
        addsep
        append "Root last commands: \n\n$(sudo tail -n 20 /root/.bash_history)"
        addsep
        append "Main User last commands: \n\n$(sudo tail -n 20 /home/karys/.bash_history)"
    endwin

    window "Press Ctrl + C to exit the script" "green" "100%"
        append "A report will be sent at ${mail_address} !"
    endwin

 }

collect_logs
main_loop -t 5 
