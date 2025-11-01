



## Making ssh use MFA


```sh
sudo apt install libpam-google-authenticator

# set up secret:
google-authenticator


Do you want authentication tokens to be time-based (y/n) y
Do you want me to update your "/home/user/.google_authenticator" file (y/n) y
Do you want to disallow multiple uses of the same authentication token (y/n) y
By default, tokens are good for 30 seconds. Do you want to do so (y/n) y


# Configure PAM for SSH 
sudo nano /etc/pam.d/sshd
auth required pam_google_authenticator.so


# Configure SSHD to require MFA 
sudo nano /etc/ssh/sshd_config
ChallengeResponseAuthentication yes
UsePAM yes
PasswordAuthentication no

AuthenticationMethods publickey,keyboard-interactive


sudo service ssh restart
```


## VScode Remote-SSH not connecting

It can't handle MFA, because it can't do keyboard interacting to give TOTP.
So you need to do ssh -L tunneling in the terminal to the ssh port of the host machine,
then in VScode you connect to the -L local port on the localhost address and this forwards it to the actual ssh terminal.

Look at the SSH tunneling .md in developerSetup git repo or in the keep note (Dragan Tech) to look up more about ssh tunneling and how to do this.



