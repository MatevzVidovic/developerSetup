



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

### How to:

```sh
# make a tunnel with local port being whatever, that points to the actual ssh port of the host machine 
# (change 2222 to your actual ssh port)
ssh -p 2222 -L 3333:192.168.101.126:2222 matevz@192.168.101.126  # do the MFA thingy
# make sure the ssh tunnel works from your client machine
ssh -p 3333  matevz@localhost   # this is what vscode will do in the background when we connect using this as a host
# then make a Remote SSH VScode host thingy that has ip localhost and port being 3333 in this case
```

Look at the SSH tunneling .md in developerSetup git repo or in the keep note (Dragan Tech) to look up more about ssh tunneling and how to do this.

### How far I've come:

this worked the first time, but not afterwards:
ssh -p 3333  matevz@localhost

And vscode actually started the connection, asked for verification code in the vscode terminal
(this didn't happen on the first time I did the MFA setup without tunneling - there it just didn't work).
But after entering the verification code, it did not work.
So we are staying on regular old non-mfa ssh for now.


