

# SSH tunneling / port forwarding


## Commands:

ssh -p 3343 user@172.111.111.111

ssh -L 15432:10.0.0.5:5432 user@ssh.example.com
ssh -R 8080:localhost:3000 user@ssh.example.com

# use -f meaning fork to run in background (without the regular terminal ssh session),

# Instead od directly using IPs, you can also use URLs (like mysite.com or whatever)

# explained at the very bottom:
ssh -D 1080 user@172.111.111.111
curl --socks5 localhost:1080 172.111.111.111 :8080



## Explanation:

basic ssh just connects your current terminal session to remote machine's ssh port.

But as you create this ssh secure connection, you can do ssh tunneling through it:
Basically, ssh connection has two ports as its ends - client has some random high port, and host has the specified ssh port, like 22.
You can then set up port forwarding on client or on host, so some other port routes to the machines ssh connection port, so traffic goes through the secure tunnel.
But you don't have to set up port forwarding manually - ssh itself ofers a port forwarding feature you can use.

### local forwarding:

ssh -L 15432:10.0.0.5:5432 user@ssh.example.com
Basically you tell SSH:
> “In addition to the normal SSH session, also open a local port (15432 ) on my computer.
Any connection I make to that port should be forwarded through this SSH connection to 10.0.0.5:5432 .”

This way you can access a remote port as if it were local.


### Remote forwarding:

ssh -R 8080:localhost:3000 user@ssh.example.com 

You’re running a webserver on your laptop at localhost:3000 and want someone on ssh.example.com to access it at port 8080.

Or, if GatewayPorts yes in the sshd_config, anyone on their LAN network can connect by doing: hostLocalIP:8080.


### Bidirectional tunnels

You want a pair of ports (client port and host port) to both listen and get packets.
Well, you can't with regular ssh: ssh uses TCP which is client-server. So it goes only one way.

But, you could do both -L and -R on different pairs of ports and communicate this way, just not over a single pair of ports.

Or, you can
use a VPN-style tunnel (ssh -w, WireGuard, sshuttle).


### Persistent tunnels

SSH tunnels break down. You need something to restart them if they break - autossh tool does that.

After ssh tunnel breaks, the terminal session is also stopped, stopping processes it was running.
To keep it running despite ssh tunnel disconnecting, you can use tools like screen, or I think tmux can do it too.





## VScode MFA setup:

VScode Remote-SSH extension can't conect if ssh has MFA.
But 
we can create an ssh tunnel with -L in the terminal using the MFA
and have the host port of the -L be the actual ssh port (not some other random port)
And then have vscode do a normal basic ssh connection onto our local port which forwards to the actual ssh port of the host machine:

ssh  -L 3333:192.168.101.126:22 matevz@192.168.101.126  # do the MFA thingy
ssh -p 3333  matevz@localhost   # this is what vscode will do in the background when we connect using this as a host






## Dynamic local forwarding

Have a local port that can route to any port of the host machine.

ssh -D 1080 user@172.111.111.111

then do sth like:

curl --socks5 localhost:1080 172.111.111.111 :8080 

-D id dynamic local port forwarding.
You can use SOCKS5 protocol to send requests to the local port (1080 in this case) and specify a goal port for the host machine (like 8080 in the curl).
The request will then go to 1080 locally, go through the secure ssh tunnel, and be routed to the specified port on the host machine. This way you can talk to any port of the host machine.


 






