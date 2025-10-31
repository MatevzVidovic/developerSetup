


# WSL SSH setup - portproxy setup

## !!! Important !!!

This setup didn't work very well due to the changing IP of wsl.
So you would have to set up the port forwarding every time you open wsl for ssh 
(just 2 commands, so not too bad - I'm just saying the automation approach didn't work)


## Why port 2847

```sh
# we are setting up ssh on port 2847
# I use that port everywhere (could be used just on the router to confuse portscanners, and elswhere use port 22 as it is the regular ssh port, but idk, i just use it everywhere)
```

## general idea: portproxy vs mirrored networking

```sh
# In normal (default) WSL2 networking:
# - Windows has a LAN IP (e.g. 192.168.x.x)
# - WSL runs inside a lightweight VM with its own virtual IP (e.g. 172.24.x.x)
# - Each time WSL starts, that internal IP can change

# To SSH into WSL in this setup, you must:
# 1. SSH to the Windows LAN IP with wsl username (e.g. ssh -p 2847 matevz@192.168.x.x)
# 2. Windows Firewall must allow inbound connections on that port
# 3. Windows must forward that port to WSL’s internal IP and port 2847 (portproxy)
# 4. Inside WSL, the SSH service and ufw/firewall must allow connections on port 2847

# Because the WSL IP can change every time WSL starts, you need a PowerShell script
# that sets up the correct portproxy mapping.
# You typically schedule that script via Windows Task Scheduler to run on boot.
# In that windows script you also need to run wsl on boot.

# This setup is called the portproxy approach.

# ------------------------------------------------------------

# In modern Windows 11 (22H2+, build 22621.2359+) with WSL 2.1.0+,
# a new "mirrored networking" mode is available.

# By adding the following to ~/.wslconfig:
[wsl2]
networkingMode=mirrored

# WSL now shares the same network interface and IP as Windows.
# This means:
# - WSL is directly accessible on the LAN (no portproxy or scripts needed)
# - Incoming packets go straight to WSL’s network stack
# - Windows Firewall is bypassed for those ports — you only need to configure ufw inside WSL

# ------------------------------------------------------------


# Also
# If you want to just turn on the computer and be able to ssh into wsl, you need to:
# You still need a windows script with Task Scheduler to run wsl on boot, and need a wsl dummy task so it stays running. 

# But
# I have so far not been able to do that.
# The wsl starts in the powershell script, but it shuts down despite the dummy task.

# So I simply suggest that upon opening your computer,
# you just start a WSL terminal session and then things work without a problem.





# The following setup uses portproxy.

```

## Basics

### SSH server
```sh
sudo apt update
sudo apt install openssh-server
sudo service ssh start
```

### WSL firewal
```sh
# set up wsl2 firewall to accept on port 2847
sudo apt update && sudo apt install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw limit 2847/tcp
sudo ufw enable
sudo ufw status numbered
```

### check if works inside WSL2:
ssh -p 2847 localhost


### make ssh start in wsl whenever wsl starts:
```sh
printf "[boot]\nsystemd=true\n" | sudo tee /etc/wsl.conf
# on wsl-launch, wsl.conf runs. And now it starts systemd, which is the linux system for background services, which runs whatever is enabled.
# Now close all wsl terminal sessions you have running.
# in windows powershell:
wsl.exe --shutdown
# after WSL restarts, in WSL:
sudo systemctl enable ssh
sudo systemctl start ssh
sudo apt install fail2ban
sudo systemctl enable fail2ban
```



### Can we ssh from windows itself
```sh
# find wsl2 ip:
ip addr | grep eth0
# try in windows:
# (get user name in WSL by doing   whoami)
ssh -p 2847 localhost

# Why doesnt use of WSL's IP directly work?
# WSL2 VM IP (e.g. 172.24.108.3) on an arbitrary port often fails from Windows due to the Hyper-V/WSL virtual switch firewall 
# ssh user@ipOfWsl2
```





### do the security precautions as explained in the regular SSH server setup notes




### Can we ssh from wsl itself and from windows?

```sh
# check if  works inside WSL2 (now using the allowed users setting:
ssh -p 2847 wslUserName@localhost

# check if logging in from windows works too:
ssh -p 2847 wslUserName@localhost
```



## Make WSL accessible over LAN

### Set up port forwarding:

```sh
# find windows IP and MAC addr:
cmd: 
ipconfig /all
powershell:
Get-NetIPConfiguration

# expose to local network:
# port forwarding (windows port 2847) (change <WSL2_IP>):
netsh interface portproxy add v4tov4 listenport=2847 listenaddress=0.0.0.0 connectport=2847 connectaddress=172.24.108.3
# check:
netsh interface portproxy show all
```

### set up windows firewall to be open to 2847
```powershell
New-NetFirewallRule `
  -DisplayName "WSL SSH inbound 2847" `
  -Direction Inbound `
  -Action Allow `
  -Protocol TCP `
  -LocalPort 2847 `
  -Profile Any  `
  -ErrorAction SilentlyContinue `
  -EdgeTraversalPolicy Allow 

# to see the rules:
Get-NetFirewallRule -DisplayName "*2847*"
# or
Get-NetFirewallRule -DisplayName "*SSH*"

# delete any existing rule with that exact name (optional)
Get-NetFirewallRule -DisplayName "WSL SSH inbound 2847" -ErrorAction SilentlyContinue | Remove-NetFirewallRule
# clean up rules:
Get-NetFirewallRule -DisplayName "*2847*" | Where-Object { $_.DisplayName -ne "WSL SSH 2847" } | Remove-NetFirewallRule
```













## Do ssh keygen on client machine
```sh

# copy the .pub to ~/ssh/authorized_keys  (literally just paste it in as a line)
# then do:
sudo systemctl enable ssh
sudo systemctl restart ssh || sudo service ssh restart
# now others can connect with:
ssh -p 2847  WindowsUserName@<your_windows_local_ip>

```




## Expose to whole internet:

### As in the regular SSH server setup note, do the port forwarding and DHCP reservation.





## Make port forwarding permanent:

### create a script or use Task Scheduler to reapply this port forwarding automatically at boot, since WSL2 IPs can change when you restart Windows. 






#### Making port forwarding permantent:
- make an automatic sript that: starts wsl, gets its current ip, sets up poert forwarding
- use Task Scheduler in windows to run this script on startup


But there are problems:
- if comp goes to sleep, ssh breaks, so prevent this by going to advanced power options and setting to never sleep or hibernate
- WSL automatically shuts down if it has no child process (even if sshd task actually enabled).
- possibly windows closes WSL after sime time


##### WSL shutdown solution:
{
Give WSL a bogus sleep task so it doesn't shut down:
sudo nano /etc/systemd/system/wsl-keepalive.service
paste in:

[Unit]
Description=Keep WSL running indefinitely

[Service]
ExecStart=/bin/bash -c "while true; do sleep 300; done"
Restart=always

[Install]
WantedBy=multi-user.target

then do:
sudo systemctl enable --now wsl-keepalive.service

now wsl never shuts down unless you do: wsl --shutdown
}


##### Windows-side idle trigger (rare but possible):
Sometimes Windows still kills idle WSL if its “Virtual Machine Platform” subsystem thinks it’s unused.
You can prevent this by setting:
wsl --set-default Ubuntu-24.04



##### Then:

In C:\Scripts\wsl-ssh-bridge.ps1 add this
(create folder and file if needed)

run with:
powershell -ExecutionPolicy Bypass -File "C:\Scripts\wsl-ssh-bridge.ps1"

check if you can ssh from you LAN now

```sh

# C:\Scripts\wsl-ssh-bridge.ps1
# Bridges Windows:<&ListenPort&> -> WSL:<&ConnectPort&> for distro "<&DistroName&>"
# Creates firewall rule "<&FirewallRuleName&>" if missing, logs to "<&LogDirectory&>"
# Retries until WSL and an IPv4 on eth0 are available (up to <&TimeoutSeconds&>s).

param(
  [string]$Distro = "Ubuntu-24.04",          # e.g. "Ubuntu" or "Ubuntu-24.04"
  [int]$ListenPort = 2847,           # e.g. 2222
  [int]$ConnectPort = 2847,         # e.g. 22
  [int]$TimeoutSec = 120        # e.g. 120
)

# --- EDITABLE PATHS / NAMES ---
# $FwRuleName = "WSL SSH inbound 2847"           # e.g. "WSL SSH on 2222"
$LogDir     = "C:\Scripts\Logs"               # e.g. "C:\Scripts\Logs"
# ------------------------------

New-Item -ItemType Directory -Path $LogDir -ErrorAction SilentlyContinue | Out-Null
$Log = Join-Path $LogDir "wsl-ssh-bridge.log"
function Log($msg) { ("[{0}] {1}" -f (Get-Date), $msg) | Out-File -FilePath $Log -Append -Encoding utf8 }

try {
  Log "==== Bridge start: Distro='$Distro' Listen=$ListenPort -> Connect=$ConnectPort ===="

#   # 1) Ensure WSL distro is running
#   for ($i=0; $i -lt $TimeoutSec; $i++) {
#     $running = (wsl --list --running) -join ""
#     if ($running -match [regex]::Escape($Distro)) { break }
#     Log "Starting WSL distro '$Distro'..."
#     wsl -d $Distro -u root -- true | Out-Null
#     Start-Sleep -Seconds 2
#   }
    # 1) Ensure WSL distro is running
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    $distroStarted = $false
    while ($stopwatch.Elapsed.TotalSeconds -lt $TimeoutSec) {
        # Try to execute a simple command - if it works, distro is running
        $testResult = wsl -d $Distro -u root -- echo "running" 2>&1
        if ($testResult -eq "running") {
            Log "Distro '$Distro' is running"
            $distroStarted = $true
            break
        }
        Log "Starting WSL distro '$Distro'... ($([int]$stopwatch.Elapsed.TotalSeconds)s elapsed)"
        Start-Sleep -Seconds 3
    }
    $stopwatch.Stop()

    if (-not $distroStarted) {
        throw "Failed to start WSL distro '$Distro' within $TimeoutSec seconds"
    }

#   # 2) Wait for IPv4 on eth0
#   $wslIp = ""
#   for ($i=0; $i -lt $TimeoutSec; $i++) {
#     $wslIp = (wsl -d $Distro -u root -- sh -c "ip -4 addr show eth0 | awk '/inet /{print \$2}' | cut -d/ -f1").Trim()
#     if ($wslIp) { break }
#     Start-Sleep -Seconds 1
#   }
#   if (-not $wslIp) { throw "Could not obtain WSL eth0 IPv4 address." }
#   Log "WSL IP: $wslIp"

    # 2) Wait for IPv4 on eth0
    $wslIp = ""
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    while ($stopwatch.Elapsed.TotalSeconds -lt $TimeoutSec) {
        try {
            $ipOutput = wsl -d $Distro -u root -- ip -4 addr show eth0 2>&1
            # Convert to single string if it's an array
            $ipString = $ipOutput -join "`n"
            # Match the pattern: "inet 172.24.108.3/20"
            if ($ipString -match 'inet\s+(\d+\.\d+\.\d+\.\d+)/') {
                $wslIp = $matches[1]
                Log "Found WSL IP: $wslIp"
                break
            } else {
                Log "No IP match in output (length: $($ipString.Length))"
            }
        } catch {
            Log "Error getting WSL IP: $_"
        }
        Log "Waiting for WSL IP... ($([int]$stopwatch.Elapsed.TotalSeconds)s elapsed)"
        Start-Sleep -Seconds 2
    }
    $stopwatch.Stop()

    if (-not $wslIp) {
        throw "Could not obtain WSL eth0 IPv4 address within $TimeoutSec seconds."
    }
    Log "WSL IP: $wslIp"

  # 3) Ensure firewall rule exists
#   if (-not (Get-NetFirewallRule -DisplayName $FwRuleName -ErrorAction SilentlyContinue)) {
#     Log "Creating firewall rule '$FwRuleName' on TCP $ListenPort"
#     New-NetFirewallRule -DisplayName $FwRuleName -Direction Inbound -Protocol TCP -LocalPort $ListenPort -Action Allow | Out-Null
#   }

  # 4) Recreate portproxy mapping (idempotent)
  $existing = (netsh interface portproxy show v4tov4) -join "`n"
  if ($existing -match "0\.0\.0\.0\s+$ListenPort\s+") {
    Log "Deleting existing portproxy on $ListenPort"
    netsh interface portproxy delete v4tov4 listenaddress=0.0.0.0 listenport=$ListenPort | Out-Null
  }

  Log ("Adding portproxy: 0.0.0.0:{0} -> {1}:{2}" -f $ListenPort, $wslIp, $ConnectPort)
  netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=$ListenPort connectaddress=$wslIp connectport=$ConnectPort | Out-Null

  # 5) Show table (for log)
  $table = netsh interface portproxy show v4tov4
  Log "Portproxy table:`n$($table -join [Environment]::NewLine)"
  Log "==== Bridge done ===="
}
catch {
  Log "ERROR: $($_.Exception.Message)"
  throw
}

```











## Run it automatically at Windows startup (Scheduled Task)

1. Press **Win+R**, run `taskschd.msc`.
    
2. **Create Task…**
    
    * **General** tab:
        
        * Name: `WSL SSH Bridge`
            
        * Check **Run whether user is logged on or not**
            
        * Check **Run with highest privileges**
            
3. **Triggers** tab:
    
    * **New…**
        
        * **Begin the task:** At startup
            
        * **Delay task for:** 30 seconds (gives networking time to settle)
            
        * OK
            
4. **Actions** tab:
    
    * **New…**
        
        * **Program/script:** `powershell.exe`
            
        * **Add arguments:**  
            `-NoProfile -ExecutionPolicy Bypass -File "C:\Scripts\wsl-ssh-bridge.ps1"`
            
        * OK
            
5. **Conditions** tab:
    
    * (Optional) Uncheck “Start the task only if the computer is on AC power” if you’re on a laptop and want it on battery too.
        
6. **Settings** tab:
    
    * Check **Allow task to be run on demand**
        
    * (Optional) Check **If the task fails, restart every 1 minute** (for 3 attempts)
        
7. Click **OK** and enter your credentials.
    













