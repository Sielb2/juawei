#!/bin/bash
APP_DIR="apps"
icons=()
names=()
echo -e "\e[32minstalling packages...\e[0m"
sudo apt update && sudo apt install nasm binutils -y
for app_dir in "$APP_DIR"/*; do
    if [[ -d "$app_dir" && -f "$app_dir/content.asm" ]]; then
        echo "Building $(basename "$app_dir")..."
        (cd "$app_dir")
        nasm -f elf64 content.asm -o content.o
        ld asmination.o -o $app_dir
        apps+=("$app_dir")
    fi
    if [[ -f "$app_dir/meta.txt" ]]; then
        IFS='|' read -r icon name < "$app_dir/meta.txt"
        icons+=("$icon")
        names+=("$name")
    fi
done
for _ in "${icons[@]}"; do
    printf " ------  "
done
echo

# Icon line
for icon in "${icons[@]}"; do
    printf "|   %s   | " "$icon"
done
echo

# Bottom border
for _ in "${icons[@]}"; do
    printf " ------  "
done
echo

# App names
for name in "${names[@]}"; do
    printf " %-7s " "$name"
done
echo
echo "Completed"
