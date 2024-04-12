command_list() {
    whoami

    hostname

    date


    lsb_release -a | grep Description | awk -F: '{print $2}' | sed 's/^\s*//'

    uname -r

    uname -m

    uptime

    sar -P ALL 1 3 | grep -E '^Average' | awk '{print $1,$2,$3,$4,$5}'

    top -b -n 1 | awk 'NR==1 {print $1,$2,$9,$12} NR>7 {print $1,$2,$9,$12}' | sort -k3 -nr | head -n 5

    free -h

    iostat -d

    df -h | head -n 2

    ping -c 1 google.com &> /dev/null && echo "  Status: Connected" || echo "  Status: Disconnected"

    ss -s

    systemctl is-active sshd

    systemctl is-active named

    systemctl is-active isc-dhcp-server

    systemctl is-active apache2

    systemctl is-active mariadb

    last | grep "$(date '+%a %b %e')"

    sudo tail -n 20 /root/.bash_history

    sudo tail -n 20 /home/karys/.bash_history
}

collect_logs() {

    # Create a dir to store logs if it does not exit
    log_dir="/tmp/todays_logs"
    mkdir -p "$log_dir"

    # Copy today's logs to the log dir
    cp /var/log/auth.log* /var/log/syslog* /var/log/kern.log* /var/log/ufw.log* /var/log/mail.log* /var/log/apache2/access.log* /var/log/apache2/error.log* "$log_dir"

    # Making a report file

    command_list > /tmp/todays_logs/report.txt

    # Archiving the logs
    tar -czf /tmp/todays_logs.tar.gz -C /tmp todays_logs
}

