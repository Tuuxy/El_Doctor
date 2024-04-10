#!/bin/bash
source simple_curses.sh

system_performance_monitoring() {
    selection="System Performance"
    title1="CPU Usage"
    title2="Memory Usage"
    title3="Disk I/O"
    title4="Network Traffic"
    command1="mpstat"
    command2="free -h"
    command3="iostat"
    command4="iftop"
}

security_monitoring() {
    selection="Security"
    title1=""
    title2=""
    title3=""
    title4=""
    command1=""
    command2=""
    command3=""
    command4=""
}

availability_monitoring() {
    selection="Availability"
    title1=""
    title2=""
    title3=""
    title4=""
    command1=""
    command2=""
    command3=""
    command4=""
}

resource_usage_monitoring() {
    selection="Ressource Usage"
    title1=""
    title2=""
    title3=""
    title4=""
    command1=""
    command2=""
    command3=""
    command4=""
}

logs_events_monitoring() {
    selection="Logs And Events"
    title1=""
    title2=""
    title3=""
    title4=""
    command1=""
    command2=""
    command3=""
    command4=""
}

software_patch_management() {
    selection="Software And Patch Management"
    title1=""
    title2=""
    title3=""
    title4=""
    command1=""
    command2=""
    command3=""
    command4=""
}

performance_trends_analysis() {
    selection="Performance Trends"
    title1=""
    title2=""
    title3=""
    title4=""
    command1=""
    command2=""
    command3=""
    command4=""
}


main(){

    system_performance_monitoring;

    window "Menu" "blue" "100%"
        append "Current Selection: ${selection}"
        addsep
        append "1. System Performance 2. Security 3. Availability 4. Resource Usage 5. Logs And Events 6. User Activity 7. Software And Patch Management 8. Performance Trends Q. Exit"
    endwin

    window "$title1" "yellow" "100%"
        append_command "$command1"
    endwin

    window "$title2" "yellow" "100%"
        append_command "$command2"
    endwin

    window "$title3" "yellow" "100%"
        append_command "$command3"
    endwin

    window "$title4" "yellow" "100%"
        append_command "$command4"
    endwin
}

main_loop