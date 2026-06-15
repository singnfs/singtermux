#!/bin/bash

# Backup Automation Module

BACKUP_DIR="$HOME/.singtermux/backups"
BACKUP_CONFIG="$HOME/.singtermux/backup.config"

# Initialize backup directory
init_backup_dir() {
    mkdir -p "$BACKUP_DIR"
    if [ ! -f "$BACKUP_CONFIG" ]; then
        touch "$BACKUP_CONFIG"
    fi
}

backup_auto_menu() {
    init_backup_dir
    while true; do
        clear
        print_header
        echo ""
        print_divider
        echo -e "${CYAN}💾 Backup Automation${RESET}"
        print_divider
        echo ""
        echo -e "${GREEN}[1]${RESET} ➕ Add Backup Source"
        echo -e "${GREEN}[2]${RESET} 📋 List Backup Sources"
        echo -e "${GREEN}[3]${RESET} 💾 Create Backup"
        echo -e "${GREEN}[4]${RESET} 📚 List Backups"
        echo -e "${GREEN}[5]${RESET} ↩️  Restore Backup"
        echo -e "${GREEN}[6]${RESET} 🗑️  Delete Backup"
        echo -e "${RED}[0]${RESET} Back"
        print_divider
        read -p "Pilih menu: " backup_choice

        case $backup_choice in
            1) add_backup_source ;;
            2) list_backup_sources ;;
            3) create_backup ;;
            4) list_backups ;;
            5) restore_backup ;;
            6) delete_backup ;;
            0) return ;;
            *) print_error "Pilihan tidak valid!"; sleep 1 ;;
        esac
    done
}

add_backup_source() {
    clear
    print_header
    echo -e "${CYAN}➕ Add Backup Source${RESET}"
    print_divider
    
    read -p "Source name: " source_name
    read -p "Source path: " source_path
    
    if [ -z "$source_name" ] || [ -z "$source_path" ]; then
        print_error "Name and path cannot be empty!"
        sleep 2
        return
    fi
    
    echo "$source_name|$source_path" >> "$BACKUP_CONFIG"
    print_success "Backup source added!"
    sleep 2
}

list_backup_sources() {
    clear
    print_header
    echo -e "${CYAN}📋 Backup Sources${RESET}"
    print_divider
    
    if [ ! -s "$BACKUP_CONFIG" ]; then
        print_warning "No backup sources configured!"
        sleep 2
        return
    fi
    
    echo ""
    local count=1
    while IFS='|' read -r name path; do
        echo -e "${GREEN}$count. $name${RESET}"
        echo -e "   ${CYAN}Path: $path${RESET}"
        ((count++))
    done < "$BACKUP_CONFIG"
    
    echo ""
    read -p "Press Enter to continue..."
}

create_backup() {
    clear
    print_header
    echo -e "${CYAN}💾 Create Backup${RESET}"
    print_divider
    
    if [ ! -s "$BACKUP_CONFIG" ]; then
        print_warning "No backup sources configured!"
        sleep 2
        return
    fi
    
    echo ""
    read -p "Backup name: " backup_name
    
    backup_file="$BACKUP_DIR/${backup_name}_$(date +%Y%m%d_%H%M%S).tar.gz"
    
    print_info "Creating backup..."
    
    tar -czf "$backup_file" $(cat "$BACKUP_CONFIG" | cut -d'|' -f2) 2>/dev/null
    
    if [ $? -eq 0 ]; then
        print_success "Backup created: $(basename $backup_file)"
    else
        print_error "Backup creation failed!"
    fi
    sleep 2
}

list_backups() {
    clear
    print_header
    echo -e "${CYAN}📚 List Backups${RESET}"
    print_divider
    
    if [ -z "$(ls -A $BACKUP_DIR 2>/dev/null)" ]; then
        print_warning "No backups found!"
        sleep 2
        return
    fi
    
    echo ""
    local count=1
    for backup_file in $BACKUP_DIR/*.tar.gz; do
        backup_name=$(basename "$backup_file")
        backup_size=$(du -h "$backup_file" | cut -f1)
        echo -e "${GREEN}$count. $backup_name${RESET} (${backup_size})"
        ((count++))
    done
    
    echo ""
    read -p "Press Enter to continue..."
}

restore_backup() {
    clear
    print_header
    echo -e "${CYAN}↩️  Restore Backup${RESET}"
    print_divider
    
    if [ -z "$(ls -A $BACKUP_DIR 2>/dev/null)" ]; then
        print_warning "No backups found!"
        sleep 2
        return
    fi
    
    echo ""
    read -p "Backup file name: " backup_name
    
    backup_file="$BACKUP_DIR/$backup_name"
    
    if [ ! -f "$backup_file" ]; then
        print_error "Backup not found!"
        sleep 2
        return
    fi
    
    read -p "Restore to (path): " restore_path
    
    print_info "Restoring backup..."
    tar -xzf "$backup_file" -C "$restore_path" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        print_success "Backup restored successfully!"
    else
        print_error "Restore failed!"
    fi
    sleep 2
}

delete_backup() {
    clear
    print_header
    echo -e "${CYAN}🗑️  Delete Backup${RESET}"
    print_divider
    
    read -p "Backup file name: " backup_name
    backup_file="$BACKUP_DIR/$backup_name"
    
    if [ ! -f "$backup_file" ]; then
        print_error "Backup not found!"
        sleep 2
        return
    fi
    
    read -p "Are you sure? (y/n): " confirm
    if [ "$confirm" = "y" ]; then
        rm "$backup_file"
        print_success "Backup deleted!"
    fi
    sleep 2
}
