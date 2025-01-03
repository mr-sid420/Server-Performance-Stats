#!/bin/bash

# Function to get total CPU usage
get_cpu_usage() {
  echo "Total CPU Usage:"
  top -bn1 | grep "Cpu(s)" | \
    awk '{print "  " $2 + $4 "%"}'
}

# Function to get memory usage
get_memory_usage() {
  echo "Memory Usage (Free vs Used):"
  free -h | awk 'NR==2{printf "  Used: %s, Free: %s, Usage: %.2f%%\n", $3, $4, $3/$2*100}'
}

# Function to get disk usage
get_disk_usage() {
  echo "Disk Usage (Free vs Used):"
  df -h --total | awk '$1 == "total"{printf "  Used: %s, Free: %s, Usage: %s\n", $3, $4, $5}'
}

# Function to get top 5 processes by CPU usage
get_top_cpu_processes() {
  echo "Top 5 Processes by CPU Usage:"
  ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
}

# Function to get top 5 processes by memory usage
get_top_memory_processes() {
  echo "Top 5 Processes by Memory Usage:"
  ps -eo pid,comm,%mem --sort=-%mem | head -n 6
}

# Optional: Additional stats
get_additional_stats() {
  echo "Additional Stats:"
  echo "  OS Version: $(lsb_release -d | cut -f2)"
  echo "  Uptime: $(uptime -p)"
  echo "  Load Average: $(uptime | awk -F 'load average: ' '{print $2}')"
  echo "  Logged-in Users: $(who | wc -l)"
  echo "  Failed Login Attempts:"
  lastb 2>/dev/null | wc -l
}

# Main script execution
echo "==============================="
echo " Server Performance Stats"
echo "==============================="
get_cpu_usage
echo
get_memory_usage
echo
get_disk_usage
echo
get_top_cpu_processes
echo
get_top_memory_processes
echo
get_additional_stats
echo "==============================="

