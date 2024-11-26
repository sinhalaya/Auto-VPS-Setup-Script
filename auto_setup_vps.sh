#!/bin/bash

set -e

# Function to check for root privileges
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo "Please run as root."
        exit 1
    fi
}

# Function to detect OS and install required tools
install_tools() {
    if [ -f /etc/debian_version ]; then
        apt update && apt upgrade -y
        apt install -y dnsutils curl
        os="Debian-based"
    elif [ -f /etc/redhat-release ]; then
        yum update -y
        yum install -y bind-utils curl
        os="RHEL-based"
    else
        echo "Unsupported operating system."
        exit 1
    fi
    echo "System updated and required tools installed."
}

# Function to validate hostname's A record
validate_hostname() {
    while true; do
        read -rp "Enter the hostname for this server: " hostname
        if host "$hostname" > /dev/null 2>&1; then
            echo "Hostname validated with A record."
            hostnamectl set-hostname "$hostname"
            break
        else
            echo "Invalid hostname or A record not found. Try again."
        fi
    done
}

# Function to set the server timezone
set_timezone() {
    read -rp "Enter your timezone (e.g., 'America/New_York'): " timezone
    if timedatectl set-timezone "$timezone"; then
        echo "Timezone set to $timezone."
    else
        echo "Invalid timezone. Please try again."
    fi
}

# Function to change SSH port
change_ssh_port() {
    read -rp "Do you want to change the SSH port? (y/n): " change_port
    if [[ "$change_port" =~ ^[Yy]$ ]]; then
        read -rp "Enter the new SSH port: " ssh_port
        sed -i "s/^#Port 22/Port $ssh_port/" /etc/ssh/sshd_config
        sed -i "s/^Port 22/Port $ssh_port/" /etc/ssh/sshd_config
        systemctl reload sshd
        echo "SSH port changed to $ssh_port."
    fi
}

# Function to prompt for server restart
restart_server() {
    read -rp "Do you want to restart the server now? (y/n): " restart
    if [[ "$restart" =~ ^[Yy]$ ]]; then
        reboot
    else
        echo "Setup complete. Please restart the server manually later."
    fi
}

# Main script execution
check_root
install_tools
validate_hostname
set_timezone
change_ssh_port
restart_server
