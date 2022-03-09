# Netshoot
For details about netshoot go to https://hub.docker.com/r/nicolaka/netshoot.

The following command will spin up a throw away container to run NMAP commands:

`kubectl run tmp-shell --rm -i --tty --image nicolaka/netshoot -- /bin/bash`

