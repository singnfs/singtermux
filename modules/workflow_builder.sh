#!/bin/bash

# Workflow Builder Module

WORKFLOW_DIR="$HOME/.singtermux/workflows"

# Initialize workflow directory
init_workflow_dir() {
    mkdir -p "$WORKFLOW_DIR"
}

workflow_builder_menu() {
    init_workflow_dir
    while true; do
        clear
        print_header
        echo ""
        print_divider
        echo -e "${CYAN}🔄 Workflow Builder${RESET}"
        print_divider
        echo ""
        echo -e "${GREEN}[1]${RESET} ➕ Create New Workflow"
        echo -e "${GREEN}[2]${RESET} 📋 List Workflows"
        echo -e "${GREEN}[3]${RESET} ▶️  Execute Workflow"
        echo -e "${GREEN}[4]${RESET} ✏️  Edit Workflow"
        echo -e "${GREEN}[5]${RESET} 🗑️  Delete Workflow"
        echo -e "${RED}[0]${RESET} Back"
        print_divider
        read -p "Pilih menu: " workflow_choice

        case $workflow_choice in
            1) create_workflow ;;
            2) list_workflows ;;
            3) execute_workflow ;;
            4) edit_workflow ;;
            5) delete_workflow ;;
            0) return ;;
            *) print_error "Pilihan tidak valid!"; sleep 1 ;;
        esac
    done
}

create_workflow() {
    clear
    print_header
    echo -e "${CYAN}➕ Create New Workflow${RESET}"
    print_divider
    
    read -p "Workflow name: " workflow_name
    
    if [ -z "$workflow_name" ]; then
        print_error "Workflow name cannot be empty!"
        sleep 2
        return
    fi
    
    workflow_file="$WORKFLOW_DIR/$workflow_name.workflow"
    
    if [ -f "$workflow_file" ]; then
        print_warning "Workflow already exists!"
        sleep 2
        return
    fi
    
    cat > "$workflow_file" << EOF
#!/bin/bash
# Workflow: $workflow_name
# Created: $(date '+%Y-%m-%d %H:%M:%S')

# Step 1
echo "Executing step 1..."

# Step 2
echo "Executing step 2..."

# Step 3
echo "Executing step 3..."

echo "Workflow completed!"
EOF
    
    chmod +x "$workflow_file"
    print_success "Workflow '$workflow_name' created!"
    sleep 2
}

list_workflows() {
    clear
    print_header
    echo -e "${CYAN}📋 List Workflows${RESET}"
    print_divider
    
    if [ -z "$(ls -A $WORKFLOW_DIR 2>/dev/null)" ]; then
        print_warning "No workflows found!"
        sleep 2
        return
    fi
    
    echo ""
    local count=1
    for workflow_file in $WORKFLOW_DIR/*.workflow; do
        workflow_name=$(basename "$workflow_file" .workflow)
        file_size=$(du -h "$workflow_file" | cut -f1)
        echo -e "${GREEN}$count. $workflow_name${RESET} (${file_size})"
        ((count++))
    done
    
    echo ""
    read -p "Press Enter to continue..."
}

execute_workflow() {
    clear
    print_header
    echo -e "${CYAN}▶️  Execute Workflow${RESET}"
    print_divider
    
    if [ -z "$(ls -A $WORKFLOW_DIR 2>/dev/null)" ]; then
        print_warning "No workflows found!"
        sleep 2
        return
    fi
    
    echo ""
    read -p "Workflow name to execute: " workflow_name
    
    workflow_file="$WORKFLOW_DIR/$workflow_name.workflow"
    
    if [ ! -f "$workflow_file" ]; then
        print_error "Workflow not found!"
        sleep 2
        return
    fi
    
    print_info "Executing workflow: $workflow_name"
    bash "$workflow_file"
    print_success "Workflow executed!"
    sleep 2
}

edit_workflow() {
    clear
    print_header
    echo -e "${CYAN}✏️  Edit Workflow${RESET}"
    print_divider
    
    read -p "Workflow name to edit: " workflow_name
    workflow_file="$WORKFLOW_DIR/$workflow_name.workflow"
    
    if [ ! -f "$workflow_file" ]; then
        print_error "Workflow not found!"
        sleep 2
        return
    fi
    
    nano "$workflow_file"
    print_success "Workflow updated!"
    sleep 2
}

delete_workflow() {
    clear
    print_header
    echo -e "${CYAN}🗑️  Delete Workflow${RESET}"
    print_divider
    
    read -p "Workflow name to delete: " workflow_name
    workflow_file="$WORKFLOW_DIR/$workflow_name.workflow"
    
    if [ ! -f "$workflow_file" ]; then
        print_error "Workflow not found!"
        sleep 2
        return
    fi
    
    read -p "Are you sure? (y/n): " confirm
    if [ "$confirm" = "y" ]; then
        rm "$workflow_file"
        print_success "Workflow deleted!"
    fi
    sleep 2
}
