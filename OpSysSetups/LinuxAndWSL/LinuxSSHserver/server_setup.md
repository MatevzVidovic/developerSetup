




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
- install mailing and use PAM (email notif on login successful attempts (cant configure on any attempt, sadly)
- make the connection on your local network with the local IP address
- set router port forwarding, so you can access the ssh from anywhere


Important files and commands:

code /etc/ssh/sshd_config
code ~/.ssh/authorized_keys
code  /etc/fail2ban/jail.local

sudo sshd -t    # (no output = good)
sudo systemctl restart ssh
sudo systemctl restart fail2ban
sudo fail2ban-client status sshd



Important notes:
We really want to use VScode with RemoteSSH. It's how you develop completely on the remote computer.
But to have it, we need:
- AllowTcpForwarding local  # can't be no
- we can't use TOTP MFA (Vscode can't handle it). We need publickey only.
- In client's VScode, RemoteSSH setting: Use Local Server should be False



router setup:
in your browser, write your router's local IP (get the IP with some command in the terminal),
log in (usually credentials are: admin   admin),

DHCP reservation:
(Can be done on Router (more reliable) or locally (if router doesnt support DHCP reservation). For local settings, see lower in the text.
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


Local DHCP server reservation:
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


VScode remote ssh setup on client:
(if on windows, set up ssh on windows and  use the windows vscode. I tried with WESL but stuff didn't work)
code ~/ssh/.config
RemoteSSH gets ideas for available hosts from there.
Try this in the terminal first, to see if connection works:
ssh -vvv my-ubuntu

ssh
Give it this (mb diff identity file? Depends on how you named it):
Host my-ubuntu
  HostName <your.public.ip.or.ddns>
  Port 2847
  User sshremote
  IdentityFile ~/.ssh/id_ed25519
  IdentitiesOnly yes
  ServerAliveInterval 60


user setup with sudoers ability:
sudo adduser sshremote
sudo usermod -aG sudo sshremote


server install:
sudo apt update
sudo apt install openssh-server


firewal ufw (untested):
sudo apt update && sudo apt install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw limit 2847/tcp
sudo ufw enable
sudo ufw status numbered




SSH setup:
client:
ssh-keygen -t ed25519 -a 100 -C "laptop@you"
server:
mkdir -p ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys



/etc/fail2ban/jail.local:

    [sshd]
    enabled = true
    port = 2847
    filter = sshd
    logpath = /var/log/auth.log
    maxretry = 3
    findtime = 30m
    bantime = 30m




/etc/ssh/sshd_config:


# Change default port for security
Port 2847

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
AllowUsers sshremote alex

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
















  Brute-Force Defense

We lock out an IP address for 30 minutes if it tried too many times.
We can't make a global lock (if too many attempts in last 30 min, don't allow anyone to log in). Just doesn't exist, sadly.

  Fail2ban Setup

  sudo apt install fail2ban
sudo cat /var/log/auth.log   # is it available? Otherwise use "journal"
sudo nano  /etc/fail2ban/jail.local # and give it this;

    [sshd]
    enabled = true
    port = 2847
    filter = sshd
    logpath = /var/log/auth.log
    maxretry = 3
    findtime = 30m
    bantime = 30m


sudo systemctl restart fail2ban
sudo fail2ban-client status sshd   # is it working?




  - With UsePAM yes (the default on most distros), sshd consults /etc/pam.d/sshd during login. PAM can:
      - enforce password, TOTP, or smartcard modules;
      - check account policies (expiration, lockouts, /etc/security/limits.conf);
      - run session hooks (mount home dirs, call custom scripts, send emails, etc.).






How do I set up login notifications with pam?
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
 code /etc/pam.d/sshd
and add near the bottom (above the final `session` line):

  session optional pam_exec.so seteuid /usr/local/sbin/ssh-login-notify.sh

  `seteuid` runs the script as the authenticating user; remove it if you want the script to run as root.

  **Test**
  1. Run `sudo sshd -t` to confirm the config parses.
  2. Restart sshd (`sudo systemctl restart sshd`).
  3. Log in from another host and confirm an email arrives (check `/var/log/mail.log` if not).
  4. Tail journal `sudo journalctl -u ssh -f` to verify PAM logs show the hook firing.















# Info:

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





