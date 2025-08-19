
#!/bin/bash

echo "[*] Installing HydraRecon dependencies..."

# Install Go-based tools
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/tomnomnom/assetfinder@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/sensepost/gowitness@latest
go install -v github.com/lc/gauplus@latest
go install -v github.com/tomnomnom/waybackurls@latest
go install -v github.com/projectdiscovery/katana/cmd/katana@latest
go install -v github.com/tomnomnom/gf@latest
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install -v github.com/s0md3v/uro@latest

# Setup GF patterns
mkdir -p ~/.gf
cp -r ~/go/pkg/mod/github.com/tomnomnom/gf*/examples ~/.gf/
if [ ! -d "Gf-Patterns" ]; then
    git clone https://github.com/1ndianl33t/Gf-Patterns
    cp Gf-Patterns/*.json ~/.gf/
fi

echo "[+] Dependencies installed successfully!"
