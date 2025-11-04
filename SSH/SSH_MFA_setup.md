



## Making ssh use MFA


```sh
sudo apt install libpam-google-authenticator

# set up secret:
google-authenticator


Do you want authentication tokens to be time-based (y/n) y
Do you want me to update your "/home/user/.google_authenticator" file (y/n) y
Do you want to disallow multiple uses of the same authentication token (y/n) y
By default, tokens are good for 30 seconds. Do you want to do so (y/n) y
```

### Configure PAM for SSH
```sh
sudo nano /etc/pam.d/sshd


# In the parth that is:
# PAM configuration for the Secure Shell service

# or maybe in the first part in the file that has
# @include common-auth

# You do:

# Comment out:
# @include common-auth

# And replace it with:
auth required pam_google_authenticator.so
```

then do:
```sh
sudo sshd -t
sudo systemctl restart ssh
```


# Configure SSHD to require MFA 
```sh
sudo nano /etc/ssh/sshd_config


ChallengeResponseAuthentication yes
UsePAM yes
PasswordAuthentication no

AuthenticationMethods publickey,keyboard-interactive

# Comment out:
# KbdInteractiveAuthentication no

sudo service ssh restart
```


## VScode Remote-SSH not connecting - I have not gotten this to work

It can't handle MFA, because it can't do keyboard interacting to give TOTP.
So you need to do ssh -L tunneling in the terminal to the ssh port of the host machine,
then in VScode you connect to the -L local port on the localhost address and this forwards it to the actual ssh terminal.

Look at the SSH tunneling .md in developerSetup git repo or in the keep note (Dragan Tech) to look up more about ssh tunneling and how to do this.


### Tunneling approach

On the bottom of your server's /etc/ssh/sshd_config
add this (the match block doesn't end, so it has to be on the bottom):

```sh
# allow key-only when the *destination* is 127.0.0.1
# so we can use vscode despite MFA - by using a local port tunnel
Match LocalAddress 127.0.0.1
  KbdInteractiveAuthentication no
  AuthenticationMethods publickey

# then do:
sudo sshd -t && sudo systemctl restart ssh
```


#### On the client, in the terminal you do:

```sh
ssh -L 127.0.0.1:3333:127.0.0.1:2223 matevz2@192.168.101.126 -p 2223 -i C:\Users\Uporabnik\.ssh\id_ed25519_wsl_factory 
# meaning of this:
# -L [LOCAL_BIND_IP]:[LOCAL_PORT]:[REMOTE_DEST_IP]:[REMOTE_DEST_PORT]     Create a local port forward. Anything you send to LOCAL_BIND_IP:LOCAL_PORT on your machine is forwarded, inside the SSH encryption, to REMOTE_DEST_IP:REMOTE_DEST_PORT as seen from the remote server.


# Possibly add a -N flag, but really no need - you have to keep the terminal tab open anyway:
# -N     Don’t run a remote command or shell — keep the connection open only to carry the tunnel.
```

You sadly can't add -f (it would run in the background so the terminal tab wouldn't have to stay there), because you can't run in the background becyuse you need keyboard interaction for the TOTP verification code entry.


#### You check the tunnel connection in another terminal tab:

```sh
ssh matevz2@127.0.0.1 -p 3333 -i C:\Users\Uporabnik\.ssh\id_ed25519_wsl_factory 
```

#### And in vscode you connect:
```sh
# cd ~
# code .ssh\config
Host vscode-through-tunnel
  HostName 127.0.0.1
  Port 3333
  User matevz2
  IdentityFile C:\Users\Uporabnik\.ssh\id_ed25519_wsl_factory


#### Remote connection should work too:

ssh -N -L 127.0.0.1:3333:127.0.0.1:2223 matevz2@178.79.107.11 -p 2848 -i C:\Users\Uporabnik\.ssh\id_ed25519_wsl_factory
```




### Control master approach

https://chatgpt.com/c/69061ddd-d594-8331-a650-82f5f4ad6dc3

You can make a regular connection in the terminal - to a .ssh/config entry that has:
  ControlMaster auto
  ControlPath ~/.ssh/cm-%r@%h:%p
  ControlPersist yes

You can then make new connections to that same entry in the config, and the tunnel is reused, just has a new session (ControlMaster setting enables that)

The problem is, ControlMaster only works on unix systems.
So you have to either (haven't done them to know they solve the problem but I expect they would):
- use a wsl builtin vscode (which has that terrible fixed sized window)
- make vscode use wsl.ext as its ssh (but this is a bit ridiculous. And still, I'm not sure how to have vscode use the WSL .ssh/config to see the available host entries. But the first step is this: add this to settings.json:
  "remote.SSH.path": "wsl.exe -e /usr/bin/ssh",
  "remote.SSH.showLoginTerminal": true,


#### What ControlPath is:
When you enable ControlMaster, OpenSSH needs a small file (a control socket) to coordinate connections.
That’s what ControlPath defines — the path where that socket lives. 
Example:
ControlPath ~/.ssh/cm-%r@%h:%p
When you SSH to matevz2@178.79.107.11 on port 2223, this expands to: ~/.ssh/cm-matevz2@178.79.107.11:2223
