#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

DOMAIN=$1
OUTPUT="recon-$DOMAIN"
mkdir -p "$OUTPUT"/{subdomains,urls,params,vulnscan,screenshots}

LOGFILE="$OUTPUT/hydrarecon.log"
exec > >(tee -a "$LOGFILE") 2>&1

echo "[*] Starting HydraRecon on $DOMAIN..."

# Check dependencies
for tool in subfinder assetfinder httpx gowitness gauplus waybackurls katana uro gf nuclei; do
    if ! command -v $tool &> /dev/null; then
        echo "[-] $tool not installed. Please install it first."
        exit 1
    fi
done

# Subdomain Enumeration
subfinder -d "$DOMAIN" -all -silent -t 50 -o "$OUTPUT/subdomains/subfinder.txt"
assetfinder --subs-only "$DOMAIN" | sort -u > "$OUTPUT/subdomains/assetfinder.txt"

cat "$OUTPUT"/subdomains/*.txt | sort -u > "$OUTPUT/subdomains/all.txt"

# Live Hosts
httpx -l "$OUTPUT/subdomains/all.txt" -silent -threads 50 -o "$OUTPUT/subdomains/live.txt"

# Screenshots
gowitness scan file -f "$OUTPUT/subdomains/live.txt" -P "$OUTPUT/screenshots/"

# URL Gathering
gauplus --random-agent -t 30 "$DOMAIN" > "$OUTPUT/urls/gauplus.txt"
waybackurls "$DOMAIN" > "$OUTPUT/urls/wayback.txt"
katana -list "$OUTPUT/subdomains/live.txt" -d 3 -silent > "$OUTPUT/urls/katana.txt"

cat "$OUTPUT"/urls/*.txt | uro > "$OUTPUT/urls/all.txt"

# Parameter Extraction
grep "=" "$OUTPUT/urls/all.txt" | sort -u > "$OUTPUT/params/all_params.txt"

# GF Patterns
gf sqli < "$OUTPUT/params/all_params.txt" > "$OUTPUT/params/sqli.txt"
gf xss < "$OUTPUT/params/all_params.txt" > "$OUTPUT/params/xss.txt"
gf lfi < "$OUTPUT/params/all_params.txt" > "$OUTPUT/params/lfi.txt"
gf redirect < "$OUTPUT/params/all_params.txt" > "$OUTPUT/params/redirect.txt"

# Vulnerability Scanning with nuclei
nuclei -l "$OUTPUT/subdomains/live.txt" -c 50 -silent -severity critical,high,medium -o "$OUTPUT/vulnscan/nuclei.txt"

echo "[+] HydraRecon complete. Results saved in $OUTPUT/"
