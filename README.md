# El Doctor

El Doctor is a system monitoring script designed for Ubuntu/Debian-based systems, but adaptable to other Linux distributions with minimal adjustments. The script provides real-time insights into various system metrics and services, facilitating system administrators in monitoring system health and performance.

#### Features : 

- **System Information:** Displays essential system details such as user, hostname, date, OS information, kernel version, and architecture.
    
- **Resource Utilization:** Monitors CPU usage, memory usage, and disk I/O statistics to track system resource utilization effectively.
    
- **Network Status:** Checks network connectivity and provides socket connection details.
    
- **Service Availability:** Verifies the status of essential services like SSH, DNS, DHCP, Apache, and MariaDB.
    
- **User Activity Monitoring:** Tracks user login activities and displays recent commands executed by the main user.
    
- **Automated Reporting:** Automatically generates a daily system report, including logs, and sends it to a specified email address.
## How to install ?

```
# Installing using git:
git clone https://github.com/Tuuxy/El_doctor.git

# Navigate to the folder and make the script executable: 
cd El_doctor
chmod +x eldoctor.sh

# Run the file:
./eldoctor.sh
```

Those are the packages to install to run the script: 

```
sudo apt update && sudo apt install lsb-release sysstat htop atop iotop nmon apache2 mariadb-server openssh-server bind9 isc-dhcp-server
```

To configure the script to work with your user and to send a report to your mail address, change those on eldoctor.sh:

```
# Change the mail address to receive the report here
mail_address="example@gmail.com"

# Change the main user you want to track
user="user_example"
```
### Bash Simple Curses

The script uses the simplebashcurses library: https://github.com/metal3d/bashsimplecurses/ 

There is no further installation procedure for this since the simple_curses.sh is already downloaded with this repository but I felt that it was important to mention. 

### How to configure the Gmail SMTP ?

#### Get your app password on google 

Go to : https://myaccount.google.com/ and on the security tab, activate the 2-FA authentication.
Then go to : https://myaccount.google.com/apppasswords and generate a password, copy it and never share it with anyone.

#### Now let's configure your system to send e-mails on the terminal by using postfix and the google smtp

```
# Open SMTP 587 ports :
sudo iptables -A INPUT -p tcp --dport 587 -j ACCEPT sudo iptables -A OUTPUT -p tcp --dport 587 -j ACCEPT

# Update and install packages :
sudo apt-get update && sudo apt-get upgrade sudo apt-get install postfix mailutils libsasl2-2 ca-certificates libsasl2-modules

# Postfix Activation : 
sudo systemctl enable postfix

# Create the SSL Certificate
sudo mkdir /etc/postfix/main.cf
cd /etc/postfix/ssl/ 
sudo openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout cacert-smtp-gmail.key -out cacert-smtp-gmail.pem

# Postfix config
sudo nano /etc/postfix/main.cf 
relayhost = [smtp.gmail.com]:587 <= change this

# And add theses 
smtp_sasl_auth_enable = yes 
smtp_sasl_password_maps = hash:/etc/postfix/smtp_sasl_password_map smtp_sasl_security_options = noanonymous 
smtp_tls_CAfile = /etc/postfix/ssl/cacert-smtp-gmail.pem 
smtp_use_tls = yes

# Create the smtp_sasl_password_map : 
sudo nano /etc/postfix/smtp_sasl_password_map
# Add this line
[smtp.gmail.com]:587 USERNAME@gmail.com:MDP_Application => Change USERNAME@gmail.com by your gmail address and MDP_Application by the app password without the spaces

# Then protect the file since your password is inside
sudo chmod 400 /etc/postfix/smtp_sasl_password_map
sudo postmap /etc/postfix/smtp_sasl_password_map

# And finaly restart the service : 
sudo systemctl restart postfix
sudo systemctl status postfix

```

Now the script should be able to send a report to the specified e-mail ( in eldoctor.sh ) by using your gmail address on your terminal.