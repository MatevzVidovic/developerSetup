


# WSL fresh instances and duplication 




From ms store you get just one wsl instance. I want more fresh instances so i can experiment easily.


## Useful commands:

```powershell
# to check what is up
wsl --list --verbose

# to remove an instance:
wsl --unregister Ubuntu24-fresh


# Create a place for the download
mkdir C:\wsl -ErrorAction SilentlyContinue
```



## Get image from Canonical (what ms store uses) and activate it



# 1) Download the official Ubuntu 24.04.3 WSL image
Invoke-WebRequest `
  -Uri https://releases.ubuntu.com/noble/ubuntu-24.04.3-wsl-amd64.wsl `
  -OutFile C:\wsl\ubuntu-24.04.3-amd64.wsl

# 2) Install it as a NEW instance (use a unique name)
mkdir C:\wsl\Ubuntu24-factory -ErrorAction SilentlyContinue
wsl --import Ubuntu24-factory C:\wsl\Ubuntu24-factory C:\wsl\ubuntu-24.04.3-amd64.wsl --version 2

# 3) Launch it
wsl -d Ubuntu24-factory


### If it doesn’t prompt for a user (rare) 

No stress—just make it “store-like” in 30 seconds:

# inside the distro
adduser YOURNAME
usermod -aG sudo YOURNAME
sudo tee /etc/wsl.conf >/dev/null <<'EOF'
[boot]
systemd=true
[user]
default=YOURNAME
EOF
exit

Then from Windows: 
wsl --terminate Ubuntu24-factory
wsl -d Ubuntu24-factory











## (UNTESTED) Duplicate the existing wsl instance

# It also clones the filesystem and all.
Except for the windows side (~\.wslconfig settings) it is all the same.

# From Windows PowerShell
wsl --export Ubuntu-24.04 C:\wsl\ubuntu24_clone.tar
mkdir C:\wsl\Ubuntu24-clone
wsl --import Ubuntu24-clone C:\wsl\Ubuntu24-clone C:\wsl\ubuntu24_clone.tar --version 2
wsl -d Ubuntu24-clone


### Maybe reset it to a more clean version

# 1. Remove user accounts except root (optional)
sudo deluser --remove-home youruser

# 2. Clean out package-specific state
sudo apt clean
sudo apt autoremove --purge -y
sudo rm -rf /var/log/* /tmp/* /var/tmp/* /root/.bash_history

# 3. Reinstall default ubuntu-wsl packages (if missing)
sudo apt install --reinstall -y ubuntu-wsl wslu

# 4. Remove /etc/wsl.conf and recreate minimal one
sudo tee /etc/wsl.conf >/dev/null <<'EOF'
[boot]
systemd=true
EOF

# 5. Re-create the “first-run” user setup on next launch
sudo rm -f /var/lib/ubuntu-wsl/first-run






## Get a fresh minimal wsl instance

It isn't like the usual wsl instance you get from wsl store - that sets some additional things.

# to check what is up
wsl --list --verbose

# to remove an instance:
wsl --unregister Ubuntu24-fresh




# Create a place for the download (optional)
mkdir C:\wsl -ErrorAction SilentlyContinue

# Download the official Ubuntu 24.04 (Noble) WSL rootfs
Invoke-WebRequest `
  -Uri https://cloud-images.ubuntu.com/wsl/releases/24.04/current/ubuntu-noble-wsl-amd64-wsl.rootfs.tar.gz `
  -OutFile C:\wsl\ubuntu24fresh.tar.gz




# actually install it
mkdir C:\wsl\Ubuntu24-fresh
wsl --import Ubuntu24-fresh C:\wsl\Ubuntu24-fresh C:\wsl\ubuntu24fresh.tar.gz --version 2
wsl -d Ubuntu24-fresh



# to go out of wsl
exit




# Download checksums and verify
Invoke-WebRequest   -Uri https://cloud-images.ubuntu.com/wsl/releases/24.04/current/SHA256SUMS   -OutFile C:\wsl\SHA256SUMS 
cat C:\wsl\SHA256SUMS 
Get-FileHash C:\wsl\ubuntu24fresh.tar.gz -Algorithm SHA256
# Compare the hash to the matching line in SHA256SUMS



### Making this minimal wsl instance more like the store instance

#### !!!!!!! THIS IS UNTESTED - I just put it here if wnat to do it in the future to have a jumping off point


# 1) Create your user (replace YOURNAME)
adduser YOURNAME
usermod -aG sudo YOURNAME

# 2) Make that user the default for this distro
sudo tee /etc/wsl.conf >/dev/null <<'EOF'
[user]
default=YOURNAME

[boot]
systemd=true

# (optional but common)
[network]
generateResolvConf=true
generateHosts=true
EOF

# 3) Install WSL integration bits
sudo apt update
sudo apt install -y ubuntu-wsl wslu

# 4) (optional) Set locale/timezone like the Store flow does
sudo apt install -y language-pack-en
sudo update-locale LANG=en_US.UTF-8
sudo timedatectl set-timezone Europe/Ljubljana




