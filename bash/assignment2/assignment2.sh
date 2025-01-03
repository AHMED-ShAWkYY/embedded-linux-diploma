#!/bin/bash


# Log file to store alert details
LOG_FILE="process_alerts.log"  
source process_monitor.conf
# Function to check processes and send alerts if they exceed the thresholds
check_processes() {
    # Fetch processes sorted by CPU and memory usage
    ps aux --sort=-%cpu,-%mem | while read -r line
    do
        # Skip the header line of the 'ps aux' output
        if [[ "$line" == *"USER"* ]]; then
            continue
        fi

        # Extract CPU and memory usage from ps output
        cpu=$(echo "$line" | awk '{print $3}')
        mem=$(echo "$line" | awk '{print $4}')
        pid=$(echo "$line" | awk '{print $2}')
        user=$(echo "$line" | awk '{print $1}')
        command=$(echo "$line" | awk '{print $11}')

        # Check if the CPU or memory usage exceeds the thresholds
        if (( $(echo "$cpu >= $CPU_ALERT_THRESHOLD" | bc -l) )) || (( $(echo "$mem >= $MEMORY_ALERT_THRESHOLD" | bc -l) )); then
            # Generate an alert message
            alert_message="ALERT: Process $command (PID: $pid) by $user is using $cpu% CPU and $mem% Memory, exceeding the thresholds."
            
            # Display the alert on the screen
            echo "$alert_message"
            
            # Log the alert to a log file with timestamp
            echo "$(date): $alert_message" >> "$LOG_FILE"
        fi
    done
}



echo "update interval = ${UPDATE_INTERVAL}"
search_by_name() {
    echo "Enter process name to search for:"
    read process_name
    ps aux | grep -i "$process_name" | grep -v "grep"
}

# Function to search processes by user
search_by_user() {
    echo "Enter username to search for processes:"
    read username
    ps aux | grep -i "$username" | grep -v "grep"
}

# Function to search processes by resource usage
search_by_usage() {
    echo "Enter the minimum CPU usage percentage (e.g., 10 for 10%):"
    read min_cpu
    echo "Enter the minimum memory usage percentage (e.g., 50 for 50%):"
    read min_mem
    ps aux --sort=-%cpu,-%mem | awk -v cpu="$min_cpu" -v mem="$min_mem" '$3 >= cpu && $4 >= mem {print $0}'
}

echo "Please choose an option:"
select option in "Monitor process ID" "Kill process ID" "monitor all process" "real-time Monitoring" "Search and Filter" "Resource Usage Alerts"
do
  case $option in
    "Monitor process ID")
      echo "You selected Monitor process ID."
      echo "Enter the process ID:"
      read processid
      top -Hp $processid
      break
      ;;
    "Kill process ID")
      echo "You selected Kill process ID."
      echo "Enter the process ID to kill:"
      read processid
      kill $processid
      echo "Process $processid killed."
      break
      ;;
    "monitor all process")
      top 
      break
      ;;
      "real-time Monitoring")
      top -i
      break
      ;;
       "Search and Filter")
      while true; do
    echo "Select search criteria:"
    echo "1. Search by process name"
    echo "2. Search by user"
    echo "3. Search by resource usage (CPU and Memory)"
    echo "4. Exit"
    read -p "Enter your choice (1-4): " choice

    case $choice in
        1)
            search_by_name
            ;;
        2)
            search_by_user
            ;;
        3)
            search_by_usage
            ;;
        4)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
    echo ""
done
      break
      ;;
      "Resource Usage Alerts")
      # Main loop to periodically check for resource usage
while true; do
    # Perform the process check every 5 seconds
     echo "option 6 before."
    check_processes
    echo "option 6 after."
    sleep 5  # Interval for checking (in seconds)
done
      break
      ;;
    *)
      echo "Invalid option, please try again."
      ;;
  esac
done







#!/bin/bash




