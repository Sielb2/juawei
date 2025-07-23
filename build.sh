#!/bin/bash

echo -e "\e[32minstalling packages...\e[0m"
sudo apt update && sudo apt install nasm binutils -y
for app_dir in apps/*; do
    if [[ -d "$app_dir" && -f "$app_dir/content.asm" ]]; then
        echo "Building $(basename "$app_dir")..."
        (cd "$app_dir")
        nasm -f elf64 content.asm -o content.o
        ld asmination.o -o $app_dir
    fi
done
echo "Completed"
