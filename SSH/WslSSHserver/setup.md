


# WSL SSH setup

## Why port 2847

Generally, ssh works on port 22.
On the router to confuse portscanners we use some random port to face the public internet (like 2847).
I like to use this port also on the ssh config itself (when I set it up on a linux machine locally).
But
With mirrored network wsl we have a problem:
windows can randomly take a port before you start up wsl and therefore ssh starts (you will see ssh is inactive if you go check).
And this happens exactly to port 2847 in my case.
So, for wsl ssh, I like to use 2222 (this is the standard alternate ssh port and will probably be free).
(This way we leave port 22 for windows ssh if we ever needed it.)

We caoul also do a port reservation on windows, but we could break something, and idk how to then make sure that it is actually enabled for the wsl ssh.
SO we will just leave it like this for now.



## general idea: portproxy vs mirrored networking

```sh

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

# If not, you will have to work with portproxy (look into old/) 
# but that setup didn't work very well due to the changing IP of wsl.
# So you would have to set up the port forwarding every time you open wsl for ssh 
# (just 2 commands, so not too bad - I'm just saying the automation approach didn't work)

# ------------------------------------------------------------



# I tried automatic startups of wsl but they just don't work.

# So I simply suggest that upon opening your computer,
# you just start a WSL terminal session and then things work without a problem.





```

## Basics

### SSH server
```sh
sudo apt update
sudo apt install openssh-server
sudo service ssh start
```

### check if works inside WSL2:
ssh -p 22 localhost    # port not changed yet, so 22


### make ssh start in wsl whenever wsl starts:
```sh
printf "[boot]\nsystemd=true\n" | sudo tee /etc/wsl.conf
# on wsl-launch, wsl.conf runs. And now it starts systemd, which is the linux system for background services, which runs whatever is enabled.
```
```powershell
# Now close all wsl terminal sessions you have running.
# in windows powershell:
wsl.exe --shutdown
```
```sh
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
ssh -p 22 matevz2@localhost    # port not changed yet, so 22

# Why doesnt use of WSL's IP directly work?
# WSL2 VM IP (e.g. 172.24.108.3) on an arbitrary port often fails from Windows due to the Hyper-V/WSL virtual switch firewall 
# ssh user@ipOfWsl2
```









### do the security precautions as explained in the regular SSH server setup notes

!!! Watch out to have the port in sshd actually be 2222 as we intend to have. 

MFA SSH? You want it? Look into SSH_MFA_setup.md







### do ssh keygen on windows and wsl
Add their .pub keys to authorized_keys (the file you set in sshd under AuthorizedKeysFile)
This way you can try ssh locally and see if it works. 

```sh
ssh-keygen -t ed25519 -a 100 -C "self@self"
cat ~/.ssh/id_ed25519.pub
```














### set up windows firewall to be open to 2222
```powershell
New-NetFirewallRule `
  -DisplayName "WSL SSH inbound 2222" `
  -Direction Inbound `
  -Action Allow `
  -Protocol TCP `
  -LocalPort 2222 `
  -Profile Any  `
  -ErrorAction SilentlyContinue `
  -EdgeTraversalPolicy Allow 

# to see the rules:
Get-NetFirewallRule -DisplayName "*2222*"
# or
Get-NetFirewallRule -DisplayName "*SSH*"

# delete any existing rule with that exact name (optional)
Get-NetFirewallRule -DisplayName "WSL SSH inbound 2222" -ErrorAction SilentlyContinue | Remove-NetFirewallRule
# clean up rules:
Get-NetFirewallRule -DisplayName "*2222*" | Where-Object { $_.DisplayName -ne "WSL SSH 2222" } | Remove-NetFirewallRule
```




### Can we ssh from wsl itself and from windows?

```sh
# check if  works inside WSL2 (now using the allowed users setting):
ssh -p 2222 wslUserName@localhost

# check if logging in from windows works too:
ssh -p 2222 wslUserName@localhost
```



## Make WSL accessible over LAN
in powershell do:
code ~/.wslconfig
```sh
[wsl2]
networkingMode=mirrored
```
also in phs:
wsl --shutdown
then in wsl do:
ip a
and see what the ip is






## Do ssh keygen on client machine

```sh
ssh-keygen -t ed25519 -a 100 -C "self@self"
cat ~/.ssh/id_ed25519.pub
```

```sh

# copy the .pub to ~/ssh/authorized_keys  (literally just paste it in as a line)
# then do:
sudo systemctl enable ssh
sudo systemctl restart ssh || sudo service ssh restart
# now others can connect with:
ssh -p 2222  WindowsUserName@<your_windows_local_ip>

```




## Expose to whole internet:

### As in the regular SSH server setup note, do the port forwarding and DHCP reservation.





## Prevent Windows-side idle trigger (rare but possible):
Sometimes Windows still kills idle WSL if its “Virtual Machine Platform” subsystem thinks it’s unused.
You can prevent this by setting:
wsl --set-default Ubuntu-24.04





### WSL firewal - we decide to skip this

You don't really need this firewall.
Windows Firewall is the first layer and everything has to go through it anyway.
And setting wsl firewall messes up a bunch of things (vscode for wsl, docker, etc.)

I used ufw to only allow the ssh port to come through.
But this messes up using vscode with wsl locally, but:
- just enabling loopback isn't enough
- and you can't just allow a fixed port, because vscode chooses a different port every time. 
- And finding where to set vscode to use a fixed port was hard and I didn't find it. 










