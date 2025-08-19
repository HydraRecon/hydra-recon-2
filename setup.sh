#!/bin/bash

# HydraRecon Setup Script
# This script installs all required dependencies for hydra-recon.sh

echo "[*] Setting up HydraRecon dependencies..."

# Ensure system is updated
sudo apt update -y
sudo apt install -y git curl wget unzip python3 python3-pip

# Install Go (if not installed)
if ! command -v go &> /dev/null; then
    echo "[*] Installing Go..."
    wget https://go.dev/dl/go1.23.0.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf go1.23.0.linux-amd64.tar.gz
    echo "export PATH=\$PATH:/usr/local/go/bin:\$HOME/go/bin" >> ~/.bashrc
    source ~/.bashrc
fi

# Function to install Go tools
install_go_tool() {
    TOOL=$1
    REPO=$2
    if ! command -v $TOOL &> /dev/null; then
        echo "[*] Installing $TOOL..."
        go install $REPO@latest
        sudo cp ~/go/bin/$TOOL /usr/local/bin/
    else
        echo "[+] $TOOL already installed."
    fi
}

# Install Go-based tools
install_go_tool subfinder github.com/projectdiscovery/subfinder/v2/cmd/subfinder
install_go_tool assetfinder github.com/tomnomnom/assetfinder
install_go_tool httpx github.com/projectdiscovery/httpx/cmd/httpx
install_go_tool gowitness github.com/sensepost/gowitness@latest
install_go_tool gauplus github.com/bp0lr/gauplus
install_go_tool waybackurls github.com/tomnomnom/waybackurls
install_go_tool katana github.com/projectdiscovery/katana/cmd/katana
install_go_tool nuclei github.com/projectdiscovery/nuclei/v2/cmd/nuclei

# Install gf
if ! command -v gf &> /dev/null; then
    echo "[*] Installing gf..."
    go install github.com/tomnomnom/gf@latest
    sudo cp ~/go/bin/gf /usr/local/bin/
    mkdir -p ~/.gf
    git clone https://github.com/1ndianl33t/Gf-Patterns ~/.gf
    echo "source ~/.gf/gf-completion.bash" >> ~/.bashrc
    source ~/.bashrc
else
    echo "[+] gf already installed."
fi

echo "[+] Setup complete! All dependencies are installed."
echo ">> Now you can run ./hydra-recon.sh <domain>"
