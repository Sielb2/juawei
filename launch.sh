#!/bin/bash
APP_DIR="apps"
icons=()
names=()
#echo -e "\e[32minstalling packages...\e[0m"
#sudo apt update && sudo apt install nasm binutils -y

for app_path in "$APP_DIR"/*; do
    if [[ -d "$app_path" && -f "$app_path/content.asm" ]]; then
        app_name=$(basename "$app_path")
        echo "Building $app_name..."

        # Assemble and link
        pushd "$app_path" > /dev/null
        nasm -f elf64 content.asm -o content.o
        ld content.o -o "../../built/$app_name"
        popd > /dev/null

        apps+=("$app_name")
    fi

    if [[ -f "$app_path/meta.txt" ]]; then
        IFS='|' read -r icon name < "$app_path/meta.txt"
        icons+=("$icon")
        names+=("$name")
    fi
done
for _ in "${icons[@]}"; do
    printf " -----  "
done
echo

# Icon line
for icon in "${icons[@]}"; do
    printf "|  %s  | " "$icon"
done
echo

# Bottom border
for _ in "${icons[@]}"; do
    printf " -----  "
done
echo

# App names
for name in "${names[@]}"; do
    printf " %-4s " "$name"
done
echo
