#!/bin/bash

# Task Scheduler Module

TASK_DIR="$HOME/.singtermux/tasks"

# Initialize task directory
init_task_dir() {
    mkdir -p "$TASK_DIR"
}

task_scheduler_menu() {
    init_task_dir
    while true; do
        clear
        print_header
        echo ""
        print_divider
        echo -e "${CYAN}⏰ Task Scheduler${RESET}"
        print_divider
        echo ""
        echo -e "${GREEN}[1]${RESET} ➕ Create New Task"
        echo -e "${GREEN}[2]${RESET} 📋 List All Tasks"
        echo -e "${GREEN}[3]${RESET} ▶️  Run Task"
        echo -e "${GREEN}[4]${RESET} ✏️  Edit Task"
        echo -e "${GREEN}[5]${RESET} 🗑️  Delete Task"
        echo -e "${RED}[0]${RESET} Back"
        print_divider
        read -p "Pilih menu: " task_choice

        case $task_choice in
            1) create_task ;;
            2) list_tasks ;;
            3) run_task ;;
            4) edit_task ;;
            5) delete_task ;;
            0) return ;;
            *) print_error "Pilihan tidak valid!"; sleep 1 ;;
        esac
    done
}

create_task() {
    clear
    print_header
    echo -e "${CYAN}➕ Create New Task${RESET}"
    print_divider
    
    read -p "Task name: " task_name
    
    # Validate task name
    if [ -z "$task_name" ]; then
        print_error "Task name cannot be empty!"
        sleep 2
        return
    fi
    
    task_file="$TASK_DIR/$task_name.task"
    
    if [ -f "$task_file" ]; then
        print_warning "Task already exists!"
        sleep 2
        return
    fi
    
    read -p "Command to execute: " command
    read -p "Schedule (cron format): " schedule
    read -p "Description (optional): " description
    
    # Create task file
    cat > "$task_file" << EOF
TASK_NAME=$task_name
COMMAND=$command
SCHEDULE=$schedule
DESCRIPTION=$description
CREATED=$(date '+%Y-%m-%d %H:%M:%S')
ENABLED=true
EOF
    
    print_success "Task '$task_name' created!"
    sleep 2
}

list_tasks() {
    clear
    print_header
    echo -e "${CYAN}📋 List All Tasks${RESET}"
    print_divider
    
    if [ -z "$(ls -A $TASK_DIR 2>/dev/null)" ]; then
        print_warning "No tasks found!"
        sleep 2
        return
    fi
    
    echo ""
    for task_file in $TASK_DIR/*.task; do
        source "$task_file"
        echo -e "${GREEN}• $TASK_NAME${RESET}"
        echo -e "  ${CYAN}Command:${RESET} $COMMAND"
        echo -e "  ${CYAN}Schedule:${RESET} $SCHEDULE"
        echo -e "  ${CYAN}Status:${RESET} $([ "$ENABLED" = "true" ] && echo -e "${GREEN}Enabled${RESET}" || echo -e "${RED}Disabled${RESET}")"
        echo ""
    done
    
    read -p "Press Enter to continue..."
}

run_task() {
    clear
    print_header
    echo -e "${CYAN}▶️  Run Task${RESET}"
    print_divider
    
    if [ -z "$(ls -A $TASK_DIR 2>/dev/null)" ]; then
        print_warning "No tasks found!"
        sleep 2
        return
    fi
    
    echo ""
    read -p "Task name to run: " task_name
    
    task_file="$TASK_DIR/$task_name.task"
    
    if [ ! -f "$task_file" ]; then
        print_error "Task not found!"
        sleep 2
        return
    fi
    
    source "$task_file"
    
    print_info "Running task: $TASK_NAME"
    eval "$COMMAND"
    print_success "Task completed!"
    sleep 2
}

edit_task() {
    clear
    print_header
    echo -e "${CYAN}✏️  Edit Task${RESET}"
    print_divider
    
    read -p "Task name to edit: " task_name
    task_file="$TASK_DIR/$task_name.task"
    
    if [ ! -f "$task_file" ]; then
        print_error "Task not found!"
        sleep 2
        return
    fi
    
    nano "$task_file"
    print_success "Task updated!"
    sleep 2
}

delete_task() {
    clear
    print_header
    echo -e "${CYAN}🗑️  Delete Task${RESET}"
    print_divider
    
    read -p "Task name to delete: " task_name
    task_file="$TASK_DIR/$task_name.task"
    
    if [ ! -f "$task_file" ]; then
        print_error "Task not found!"
        sleep 2
        return
    fi
    
    read -p "Are you sure? (y/n): " confirm
    if [ "$confirm" = "y" ]; then
        rm "$task_file"
        print_success "Task deleted!"
    fi
    sleep 2
}
