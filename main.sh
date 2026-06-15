#!/bin/bash

# SingTermux - Automation Suite untuk Termux
# Author: singnfs
# Version: 1.0

# Import modules
source "$(dirname "$0")/modules/colors.sh"
source "$(dirname "$0")/modules/menu.sh"
source "$(dirname "$0")/modules/task_scheduler.sh"
source "$(dirname "$0")/modules/workflow_builder.sh"
source "$(dirname "$0")/modules/script_repo.sh"
source "$(dirname "$0")/modules/backup_auto.sh"
source "$(dirname "$0")/modules/monitor_alert.sh"

# Main menu function
main_menu() {
    while true; do
        clear
        print_header
        echo ""
        echo -e "${BLUE}═══════════════════════════════════════════════════════${RESET}"
        echo -e "${CYAN}  🤖 SingTermux - Automation Suite${RESET}"
        echo -e "${BLUE}═══════════════════════════════════════════════════════${RESET}"
        echo ""
        echo -e "${GREEN}[1]${RESET} ⏰ Task Scheduler"
        echo -e "${GREEN}[2]${RESET} 🔄 Workflow Builder"
        echo -e "${GREEN}[3]${RESET} 📚 Script Repository"
        echo -e "${GREEN}[4]${RESET} 💾 Backup Automation"
        echo -e "${GREEN}[5]${RESET} 🚨 Monitor & Alert"
        echo -e "${GREEN}[6]${RESET} ⚙️  Settings"
        echo -e "${RED}[0]${RESET} Exit"
        echo ""
        echo -e "${BLUE}═══════════════════════════════════════════════════════${RESET}"
        read -p "Pilih menu [0-6]: " choice

        case $choice in
            1) task_scheduler_menu ;;
            2) workflow_builder_menu ;;
            3) script_repo_menu ;;
            4) backup_auto_menu ;;
            5) monitor_alert_menu ;;
            6) settings_menu ;;
            0) echo -e "${YELLOW}Terima kasih! Sampai jumpa 👋${RESET}"; exit 0 ;;
            *) echo -e "${RED}Pilihan tidak valid!${RESET}"; sleep 1 ;;
        esac
    done
}

# Settings menu
settings_menu() {
    clear
    print_header
    echo -e "${CYAN}⚙️  Settings${RESET}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════${RESET}"
    echo -e "${GREEN}[1]${RESET} Check Version"
    echo -e "${GREEN}[2]${RESET} Update SingTermux"
    echo -e "${GREEN}[3]${RESET} About"
    echo -e "${RED}[0]${RESET} Back"
    read -p "Pilih: " settings_choice

    case $settings_choice in
        1) echo -e "${CYAN}SingTermux v1.0${RESET}"; sleep 2 ;;
        2) echo -e "${YELLOW}Updating..."; cd "$(dirname "$0")" && git pull; sleep 2 ;;
        3) show_about ;;
        0) return ;;
        *) echo -e "${RED}Pilihan tidak valid!${RESET}"; sleep 1 ;;
    esac
}

show_about() {
    clear
    print_header
    echo -e "${CYAN}About SingTermux${RESET}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════${RESET}"
    echo -e "${GREEN}SingTermux Automation Suite v1.0${RESET}"
    echo -e "${YELLOW}Automation & Scripting Tool untuk Termux${RESET}"
    echo ""
    echo -e "${CYAN}Features:${RESET}"
    echo "  • Task Scheduler - Schedule otomatis"
    echo "  • Workflow Builder - Build workflow kompleks"
    echo "  • Script Repository - Library scripts"
    echo "  • Backup Automation - Auto backup"
    echo "  • Monitor & Alert - Monitoring real-time"
    echo ""
    echo -e "${CYAN}Author:${RESET} singnfs"
    echo -e "${CYAN}GitHub:${RESET} https://github.com/singnfs/SingTermux"
    echo -e "${CYAN}License:${RESET} MIT"
    echo ""
    read -p "Press Enter to continue..."
}

# Run main menu
main_menu
