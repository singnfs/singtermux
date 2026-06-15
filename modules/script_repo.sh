#!/bin/bash

# Script Repository Module

SCRIPT_DIR="$HOME/.singtermux/scripts"

# Initialize script directory
init_script_dir() {
    mkdir -p "$SCRIPT_DIR"
}

script_repo_menu() {
    init_script_dir
    while true; do
        clear
        print_header
        echo ""
        print_divider
        echo -e "${CYAN}📚 Script Repository${RESET}"
        print_divider
        echo ""
        echo -e "${GREEN}[1]${RESET} ➕ Add Script"
        echo -e "${GREEN}[2]${RESET} 📋 List Scripts"
        echo -e "${GREEN}[3]${RESET} ▶️  Run Script"
        echo -e "${GREEN}[4]${RESET} 👁️  View Script"
        echo -e "${GREEN}[5]${RESET} 🗑️  Remove Script"
        echo -e "${RED}[0]${RESET} Back"
        print_divider
        read -p "Pilih menu: " script_choice

        case $script_choice in
            1) add_script ;;
            2) list_scripts ;;
            3) run_script ;;
            4) view_script ;;
            5) remove_script ;;
            0) return ;;
            *) print_error "Pilihan tidak valid!"; sleep 1 ;;
        esac
    done
}

add_script() {
    clear
    print_header
    echo -e "${CYAN}➕ Add Script${RESET}"
    print_divider
    
    read -p "Script name: " script_name
    
    if [ -z "$script_name" ]; then
        print_error "Script name cannot be empty!"
        sleep 2
        return
    fi
    
    script_file="$SCRIPT_DIR/$script_name.sh"
    
    if [ -f "$script_file" ]; then
        print_warning "Script already exists!"
        sleep 2
        return
    fi
    
    cat > "$script_file" << EOF
#!/bin/bash
# Script: $script_name
# Created: $(date '+%Y-%m-%d %H:%M:%S')

echo "Script $script_name is running..."

# Add your code here

echo "Script completed!"
EOF
    
    chmod +x "$script_file"
    print_success "Script '$script_name' added!"
    sleep 2
}

list_scripts() {
    clear
    print_header
    echo -e "${CYAN}📋 List Scripts${RESET}"
    print_divider
    
    if [ -z "$(ls -A $SCRIPT_DIR 2>/dev/null)" ]; then
        print_warning "No scripts found!"
        sleep 2
        return
    fi
    
    echo ""
    local count=1
    for script_file in $SCRIPT_DIR/*.sh; do
        script_name=$(basename "$script_file" .sh)
        echo -e "${GREEN}$count. $script_name${RESET}"
        ((count++))
    done
    
    echo ""
    read -p "Press Enter to continue..."
}

run_script() {
    clear
    print_header
    echo -e "${CYAN}▶️  Run Script${RESET}"
    print_divider
    
    if [ -z "$(ls -A $SCRIPT_DIR 2>/dev/null)" ]; then
        print_warning "No scripts found!"
        sleep 2
        return
    fi
    
    echo ""
    read -p "Script name to run: " script_name
    
    script_file="$SCRIPT_DIR/$script_name.sh"
    
    if [ ! -f "$script_file" ]; then
        print_error "Script not found!"
        sleep 2
        return
    fi
    
    print_info "Running script: $script_name"
    bash "$script_file"
    print_success "Script execution completed!"
    sleep 2
}

view_script() {
    clear
    print_header
    echo -e "${CYAN}👁️  View Script${RESET}"
    print_divider
    
    read -p "Script name to view: " script_name
    script_file="$SCRIPT_DIR/$script_name.sh"
    
    if [ ! -f "$script_file" ]; then
        print_error "Script not found!"
        sleep 2
        return
    fi
    
    cat "$script_file" | less
}

remove_script() {
    clear
    print_header
    echo -e "${CYAN}🗑️  Remove Script${RESET}"
    print_divider
    
    read -p "Script name to remove: " script_name
    script_file="$SCRIPT_DIR/$script_name.sh"
    
    if [ ! -f "$script_file" ]; then
        print_error "Script not found!"
        sleep 2
        return
    fi
    
    read -p "Are you sure? (y/n): " confirm
    if [ "$confirm" = "y" ]; then
        rm "$script_file"
        print_success "Script removed!"
    fi
    sleep 2
}
