echo -e "\e[32minstalling packages...\e[0m"
sudo apt update && sudo apt install nasm binutils -y
echo "Starting builder"
for app_dir in apps/*; do
    if [[ -d "$app_dir" && -f "$app_dir/build.sh" ]]; then
        echo "Building $(basename "$app_dir")..."
        (cd "$app_dir" && bash build.sh)
    fi
done
echo "Builds completed"
