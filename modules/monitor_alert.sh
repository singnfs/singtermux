#!/bin/bash

# Monitor & Alert Module

MONITOR_DIR="$HOME/.singtermux/monitors"
MONITOR_LOG="$HOME/.singtermux/monitor.log"

# Initialize monitor directory
init_monitor_dir() {
    mkdir -p "$MONITOR_DIR"
    touch "$MONITOR_LOG"
}

monitor_alert_menu() {
    init_monitor_dir
    while true; do
        clear
        print_header
        echo ""
        print_divider
        echo -e "${CYAN}🚨 Monitor & Alert${RESET}"
        print_divider
        echo ""
        echo -e "${GREEN}[1]${RESET} 👁️  System Monitor"
        echo -e "${GREEN}[2]${RESET} 📊 Process Monitor"
        echo -e "${GREEN}[3]${RESET} 💾 Disk Usage Monitor"
        echo -e "${GREEN}[4]${RESET} 🌡️  Temperature Monitor"
        echo -e "${GREEN}[5]${RESET} 📋 View Logs"
        echo -e "${RED}[0]${RESET} Back"
        print_divider
        read -p "Pilih menu: " monitor_choice

        case $monitor_choice in
            1) system_monitor ;;
            2) process_monitor ;;
            3) disk_monitor ;;
            4) temp_monitor ;;
            5) view_logs ;;
            0) return ;;
            *) print_error "Pilihan tidak valid!"; sleep 1 ;;
        esac
    done
}

system_monitor() {
    clear
    print_header
    echo -e "${CYAN}👁️  System Monitor${RESET}"
    print_divider
    echo ""
    
    echo -e "${CYAN}Device Info:${RESET}"
    echo -e "  Hostname: $(hostname)"
    echo -e "  User: $(whoami)"
    echo -e "  Device: $(getprop ro.product.model 2>/dev/null || echo 'N/A')"
    echo ""
    
    echo -e "${CYAN}Memory Usage:${RESET}"
    free -h 2>/dev/null || echo "  N/A"
    echo ""
    
    echo -e "${CYAN}CPU Info:${RESET}"
    nproc 2>/dev/null && echo "  Cores available" || echo "  N/A"
    echo ""
    
    log_entry "System monitor executed"
    read -p "Press Enter to continue..."
}

process_monitor() {
    clear
    print_header
    echo -e "${CYAN}📊 Process Monitor${RESET}"
    print_divider
    echo ""
    
    read -p "Number of processes to show [10]: " num_process
    num_process=${num_process:-10}
    
    echo -e "${CYAN}Top Processes:${RESET}"
    ps aux --sort=-%mem | head -n $((num_process + 1))
    echo ""
    
    log_entry "Process monitor - top $num_process processes"
    read -p "Press Enter to continue..."
}

disk_monitor() {
    clear
    print_header
    echo -e "${CYAN}💾 Disk Usage Monitor${RESET}"
    print_divider
    echo ""
    
    echo -e "${CYAN}Disk Space:${RESET}"
    df -h 2>/dev/null || echo "  N/A"
    echo ""
    
    log_entry "Disk usage monitor executed"
    read -p "Press Enter to continue..."
}

temp_monitor() {
    clear
    print_header
    echo -e "${CYAN}🌡️  Temperature Monitor${RESET}"
    print_divider
    echo ""
    
    if [ -d "/sys/class/thermal" ]; then
        echo -e "${CYAN}System Temperature:${RESET}"
        for zone in /sys/class/thermal/thermal_zone*; do
            if [ -f "$zone/temp" ]; then
                temp_name=$(basename $zone)
                temp=$(cat $zone/temp)
                temp_c=$((temp / 1000))
                echo "  $temp_name: ${temp_c}°C"
            fi
        done
    else
        echo -e "${YELLOW}Temperature info not available${RESET}"
    fi
    echo ""
    
    log_entry "Temperature monitor executed"
    read -p "Press Enter to continue..."
}

view_logs() {
    clear
    print_header
    echo -e "${CYAN}📋 Monitor Logs${RESET}"
    print_divider
    echo ""
    
    if [ -s "$MONITOR_LOG" ]; then
        tail -20 "$MONITOR_LOG"
    else
        print_warning "No logs found!"
    fi
    echo ""
    
    read -p "Press Enter to continue..."
}

log_entry() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$MONITOR_LOG"
}
