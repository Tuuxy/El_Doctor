collect_logs() {

    # Create a dir to store logs if it does not exit
    log_dir="/tmp/todays_logs"
    mkdir -p "$log_dir"

    # Copy today's logs to the log dir
    cp /var/log/auth.log* /var/log/syslog* /var/log/kern.log* /var/log/ufw.log* /var/log/mail.log* /var/log/apache2/access.log* /var/log/apache2/error.log* "$log_dir"

    # Archiving the logs
    tar -czf /tmp/todays_logs.tar.gz -C /tmp todays_logs
}
