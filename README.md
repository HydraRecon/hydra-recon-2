# 🐉 HydraRecon-2 

HydraRecon-2 is a **powerful automated reconnaissance framework** for bug bounty hunters and penetration testers.  
It combines the **top recon tools** into one script to save time and maximize results.

---

## 🚀 Features :
- Subdomain Enumeration (`subfinder`, `assetfinder`, `amass`)
- Live Host Detection (`httpx`)
- Screenshots of hosts (`gowitness`)
- URL Gathering (`gauplus`, `waybackurls`, `katana`)
- Parameter Extraction & Filtering (`uro`, `gf`)
- Vulnerability Scanning (`nuclei`)
- Organized Output with Logging

---

## 📦 Installation :

Clone the repo:
```bash
git clone https://github.com/HydraRecon/hydra-recon-2.git
cd hydra-recon-2
```

## ⚙️ Run setup to install dependencies :
```bash
chmod +x setup.sh hydra-recon.sh
./setup.sh
```

## 🛠️ Usage :
```bash
./hydra-recon.sh target.com
```

## 📝 Example Output :

[+] Starting Hydra Recon...

[+] Subdomains found: 152

[+] Live hosts detected: 47

[+] Screenshots saved in results/screenshots/

[+] Vulnerability scan completed: 5 potential issues

[✔] Recon finished successfully!
