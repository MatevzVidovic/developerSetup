

# SSH server setup

## Initial info

### safety advice


### Only have router port forwarding when you need it:

Only open router port when you are going to be using it

You do
ipconfig
Get the default gateway
Paste that ip in your browser
And turn on the port you set up.
Put that URL into pinned ones so you can always do it quickly.

And after not using it, you just stop it when you come home.


### Login attempt monitoring

Run commands that tell you logs of logins and attempted logins:
Monitor it from time to time to see there is no funky business.

When you see the IPs, you can put them into a website like WhereIsMyIp, give them the IP, and see where it is coming from.
So you verify it was you.


```sh
sudo fail2ban-client status


sudo cat /var/log/auth.log \
 | grep -oP '(?<=from )[^ ]+' \
 | sort | uniq -c | sort -n


sudo grep "Failed password" /var/log/auth.log \
 | grep -oP '(?<=from )[^ ]+' \
 | sort | uniq -c | sort -rn | head -20


sudo tail -F /var/log/auth.log
sudo grep "Failed password" /var/log/auth.log | tail -n 20
```


### Allowing limited connections and saturating them

Aside from all the regular precautions, you can make it impossible for anyone to even try connecting 
by limiting number of allowed sessions (max startups in settings, not max sessions - look it up if wanna know more)

As soon as opening the port forwarding on the router, 
you connect to your ssh with your phone with as many different users as you have MaxStartups so noone else can even try conencting.
And when you want to connect with your laptop, you just disconnect on your phone.

You should be on mobile data so you always have a connection.
But, on mobile data, your IP changes all the time, so ssh will break.
So you should connect to a consumer VPN (e.g. ProtonVPN, NordVPN) and enable having a static IP.
This way ssh will persist.

For ssh-ing from your phone,
You can use a phone ssh app (Termius, JuiceSSH). You do keygen and user creation there.
And you can even check status of long-running processes on your when you have that
(look up using tmux for seeing how elegantly you can have long running processes, 
and also very easily see active terminal sessions from your phone.) 

### Peer-to-peer VPNs?

This can be an additional security layer. It can also work instead of the consumer VPN explained above.

What is a VPN here really:

Both devices have a pub and private key.
They do a handshake.
They establish a vitrual network (they have virtual static IPs when talking to eachother 
(that static IP is what would solve the ssh disconnecting due to mobile data connection problem))

When packets go from your phone → desktop:
Peer-to-peer VPN process encrypts them using the desktop’s public key.
The desktop decrypts them using its private key.
No middleman ever sees the contents.
So it’s basically the same asymmetric cryptography model as SSH.
You just add another layer of protection on top of ssh.

And sth like WireGuard is a much much smaller tool than ssh, so even less potential for security vulnerabilities in the code.


WireGuard:
Peer to peer.
You need to set up your router to still do port forwarding.

Tailscale:
I think your router doesn't even have to open a port - so this would be an amazing level of security.
No portscanner would even know there is anything there.

There are Tailscale servers over which your 2 devices communicate.
And so since your desktop comp (otherwise behid NAT) does an outgoing connection first,
no port has to manually be opened on the router - it's just the regular way devices behind a NAT have outgoing connections.

Tailscale automates the peer-to-peer process with a coordination server:
Each device registers its public key with your Tailscale account.
When you log into Tailscale, the coordination server tells devices each other’s current public IP + port.
The devices then do a direct UDP handshake (NAT traversal) using those keys.
If that fails, traffic relays through a fallback encrypted relay (“DERP server”).


### !!! Warning on HOST IDENTIFICATION HAS CHANGED - Important note

When sshing to same IP address,
when you changed ports or the actual machine you are sshing to, or you reinstall the ssh server or sth similar,
you have different fingerprint that it returns.
So safety makes it stop enabling it.
You have to delete the old known host.
You can delete all of them, it's no biggie.

```sh
code ~/.ssh/known_hosts
sudo nano ~/.ssh/known_hosts
```



### Why ssh

This is the best programming experience.
You can have a shit laptop, but just connect to your good desktop computer with ssh. You run docker there, run everything there, it's awesome.

- create new user on desktop Ubuntu, so it is used as ssh login
- make it a sudoer, so you can install anything you need while in ssh
- install ssh server stuff
- add firewal with rate limiting
- do DHCP reservation on your router
- on client machines, do ssh keygen (make longest key possible), and copy the publickey onto this server and put in correct place
- change /etc/ssh/sshd_config/
- install fail2ban (on 3 tries in 30min window, that IP is locked out (sadly can't do it in an IP agnostic way, where any 3 attempts lock everyone out))
- install mailing and use PAM (email notif on login successful attempts (cant configure on any attempt, sadly))
- make the connection on your local network with the local IP address
- set router port forwarding, so you can access the ssh from anywhere



###  Important notes on how to use VScode with Remote ssh:
We really want to use VScode with RemoteSSH. It's how you develop completely on the remote computer.
But to have it, we need:
- AllowTcpForwarding local  # can't be no
- In client's VScode, RemoteSSH setting: Use Local Server should be False
- we can't use TOTP MFA (Vscode can't handle it). We need publickey only. (unless doing ssh tuneling - see .md about that in this repo)



## Important files and commands:


```sh
sudo systemctl status ssh    # is ssh running?
sudo ss -tulpn | grep ssh   # where is ssh? on which port?


nano ~/.ssh/authorized_keys

sudo nano /etc/ssh/sshd_config
sudo sshd -t    # (no output = good)
sudo systemctl restart ssh

sudo nano  /etc/fail2ban/jail.local
sudo systemctl restart fail2ban
sudo fail2ban-client status sshd


Testing if connections work:

nc -vz -w2 192.168.101.126 2222
Test-NetConnection 192.168.101.126 -Port 2222
```





##  router setup:
in your browser, write your router's local IP 
(get the IP with some command in the terminal:
windows: ipconfig     (default gateway is the router ip)
),
log in (usually credentials are: admin   admin),

### DHCP reservation:
Can be done on Router (more reliable) or locally (if router doesnt support DHCP reservation). For local settings, see lower in the text.
DHCP means your comp dynamically gets a local IP addr. So this means it can change between reboots. We don't want that, so that our ssh local network login can work, and so that our port forwarding can work. 
We need the router to reserve a local IP for our desktop comp.
On the server machine, do:
ip addr show
You see local IP, and you see MAC (hardware) address (like 00:1e:67:3a:b2:cd)
Log into router, go to LAN stup / DHCP server / etc. (diff namings).
Do: Add new reservation (or sth like that)
Give: MAC addr, IP addr, some name, and save
On your server, do:
ip addr show | grep inet
If didn't work, restart NM:
sudo systemctl restart NetworkManager
and ping router:
ping -c 3 192.168.0.1
After reboot of comp, see the IP again:
ip addr show | grep inet

Port forwarding:
Add a port forwarding, that will forward your local network's singular global IP (see it by googling What is my IP?) + some port, to the local IP of your computer on some port. This way you can ssh from outside.
Fir the global part, take a random high port, so port scanners don't know it is ssh (standard ssh port is 22).







## Native linux server setup

### user setup with sudoers ability:
```sh
sudo adduser sshremote
sudo usermod -aG sudo sshremote
```

### server install:
```sh
sudo apt update
sudo apt install openssh-server
```

### (if doing native linux server setup) firewal ufw:
If doing it for wsl on windows, use just the windows firewall (see wsl specific setup).
```sh
sudo apt update && sudo apt install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 2222/tcp
sudo ufw enable
sudo ufw status numbered
```



## SSH setup:
```sh
# client:
ssh-keygen -t ed25519 -a 100 -C "self@self"
cat ~/.ssh/id_ed25519.pub
# server:
mkdir -p ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
code ~/.ssh/authorized_keys
```




## sshd_config

```sh
sudo nano /etc/ssh/sshd_config
```

Delete what is there (maybe copy it and save it to somewhere).
Add this:

```sh

# Change default port for security
Port 2222

# Disable root login
PermitRootLogin no

# Enable public key authentication
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys

# PAM is linux auth module. Extends funtionalities of basic auth (like enabling TOTP, sending login notifications, etc.)
UsePAM yes

# Configure MFA: SSH Key + TOTP
# ChallengeResponseAuthentication yes
PasswordAuthentication no

# Require both public key AND keyboard-interactive (TOTP)
# AuthenticationMethods "publickey,keyboard-interactive"

# Only publickey (so we can do RemoteSSH in VScode on the client machine)
AuthenticationMethods publickey
# So we for sure don't do TOTP:
KbdInteractiveAuthentication no

# Security hardening
Protocol 2
MaxAuthTries 5
MaxStartups 20
LoginGraceTime 30
ClientAliveInterval 300
ClientAliveCountMax 3

# Restrict users (optional - only allow SSH user)
# AllowUsers sshremote alex matevz2

# Disable unused features
PermitEmptyPasswords no
X11Forwarding no
AllowAgentForwarding no
PermitUserEnvironment no
# needed for RemoteSSH in VScode
AllowTcpForwarding local

# Strong crypto only
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com
MACs hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com
KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512

```














##   Brute-Force Defense

We lock out an IP address for 30 minutes if it tried too many times.
We can't make a global lock (if too many attempts in last 30 min, don't allow anyone to log in). Just doesn't exist, sadly.

  Fail2ban Setup

```sh
sudo apt install fail2ban
sudo cat /var/log/auth.log   # is it available? Otherwise use "journal"
sudo nano  /etc/fail2ban/jail.local # and give it this;
```

```sh
    [sshd]
    enabled = true
    port = 2222
    filter = sshd
    logpath = /var/log/auth.log
    maxretry = 3
    findtime = 30m
    bantime = 30m
```

```sh
sudo systemctl restart fail2ban
sudo fail2ban-client status sshd   # is it working?
```



  - With UsePAM yes (the default on most distros), sshd consults /etc/pam.d/sshd during login. PAM can:
      - enforce password, TOTP, or smartcard modules;
      - check account policies (expiration, lockouts, /etc/security/limits.conf);
      - run session hooks (mount home dirs, call custom scripts, send emails, etc.).







## VScode remote ssh setup on client:
(if on windows, set up ssh on windows and  use the windows vscode. I tried with WSL but stuff didn't work)

```sh
code ~/ssh/.config
```
RemoteSSH gets ideas for available hosts from there.


ssh
Give it this (mb diff identity file? Depends on how you named it):
```sh
Host my-ubuntu
  HostName <your.public.ip.or.ddns>
  Port 2222
  User <username>
  IdentityFile ~/.ssh/id_ed25519
  IdentitiesOnly yes
  ServerAliveInterval 60
```

Try this in the terminal first, to see if connection works:
```sh
ssh -vvv my-ubuntu
```








































# Not used

## (tried but not working yet) How do I set up login notifications with pam?
in   /etc/ssh/sshd_config    have:    UsePAM yes
sudo systemctl reload sshd


  Install Mailer

 sudo apt install msmtp mailutils

  Notification Script:
  - Create an executable /usr/local/sbin/ssh-login-notify.sh owned by root:

    #!/bin/bash
    HOSTNAME=$(hostname)
    TS=$(date --iso-8601=seconds)
    /usr/bin/mail -s "SSH login on ${HOSTNAME}" you@example.com <<EOF

  User: $PAM_USER
  From: ${PAM_RHOST:-local}
  TTY: $PAM_TTY
  Time: $TS
  Service: $PAM_SERVICE
  EOF


  Change the recipient address; log to syslog instead if you prefer (`logger "SSH login..."`).

  **Wire Into PAM**
 nano /etc/pam.d/sshd
and add near the bottom (above the final `session` line):

  session optional pam_exec.so seteuid /usr/local/sbin/ssh-login-notify.sh

  `seteuid` runs the script as the authenticating user; remove it if you want the script to run as root.

  **Test**
  1. Run `sudo sshd -t` to confirm the config parses.
  2. Restart sshd (`sudo systemctl restart sshd`).
  3. Log in from another host and confirm an email arrives (check `/var/log/mail.log` if not).
  4. Tail journal `sudo journalctl -u ssh -f` to verify PAM logs show the hook firing.








## (we do not use this) Local DHCP server reservation:
The problem eith this is: maybe router already has device with this IP, and then there can be problems.
{
ip addr show 
(following thing uses this IP addr:)
sudo nano /etc/netplan/01-network-manager-all.yaml

network:
  version: 2
  renderer: NetworkManager
  ethernets:
    enp3s0:
      dhcp4: no
      addresses: [192.168.0.42/24]
      gateway4: 192.168.0.1
      nameservers:
        addresses: [1.1.1.1,8.8.8.8]

sudo netplan apply
}




















## General info:

  - Set AllowTcpForwarding local to permit only local (client→server) forwards, which is enough for VS Code while blocking
  server→client reverse tunnels.


• MaxStartups controls how many unauthenticated SSH connections can exist at once. With a single number (20), sshd refuses
  any new connection as soon as there are 20 pending handshakes. If a legitimate spike hits (e.g., VS Code reconnecting
  quickly), you can end up locked out.

  Using the three-number form max:start:rate lets sshd shed load gradually:

  - max — the threshold where sshd starts randomly dropping new unauthenticated connections.
  - start — the percentage chance of dropping once you hit max.
  - rate — how that drop probability ramps up as more pending connections appear.

  Example MaxStartups 10:30:60:

  - Up to 10 pending connections: no drops.
  - At 10 pending: 30% of new connections are dropped.
  - Beyond 10, the drop chance increases linearly until it hits 60% when the pending count reaches the third number (20
  in this case). Above that, it stays at 60%. So sshd keeps accepting some connections for legitimate users while shedding
  load from a flood.

  MaxAuthTries: it’s the number of password/public-key attempts allowed within a single SSH session before
  that session is closed. It doesn’t reset hourly or across sessions. If you set it to 4, a client gets four tries during
  that connection





