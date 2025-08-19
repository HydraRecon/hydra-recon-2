#!/bin/bash

echo "[*] Installing HydraRecon-2 dependencies..."

# Update system
sudo apt update -y && sudo apt upgrade -y

# Install essentials
sudo apt install -y git curl wget unzip build-essential python3 python3-pip

# Install Go (if not installed)
if ! command -v go &> /dev/null; then
    echo "[*] Installing Go..."
    wget https://go.dev/dl/go1.23.0.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.23.0.linux-amd64.tar.gz
    echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.bashrc
    source ~/.bashrc
fi

# Install Go tools
echo "[*] Installing Go-based tools..."
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/tomnomnom/assetfinder@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install -v github.com/bp0lr/gauplus@latest
go install -v github.com/tomnomnom/waybackurls@latest
go install -v github.com/projectdiscovery/katana/cmd/katana@latest
go install -v github.com/tomnomnom/gf@latest
go install -v github.com/lc/gau@latest
go install -v github.com/jaeles-project/gospider@latest
go install -v github.com/s0md3v/uro@latest
go install github.com/sensepost/gowitness@latest

# Setup gf patterns
mkdir -p ~/.gf
git clone https://github.com/1ndianl33t/Gf-Patterns ~/.gf

echo "[+] Installation complete. Please restart your terminal or run: source ~/.bashrc"
