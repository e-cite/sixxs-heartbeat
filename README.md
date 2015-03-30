# sixxs-heartbeat
Send heartbeats to SixXS TIC from pfsense for keep alive a SixXS heartbeat tunnel


This script implements the SixXS Heartbeat Protocol as described in the https://tools.ietf.org/html/draft-massar-v6ops-heartbeat-00 on pfSense respectively BSD.

Copy the files to the following locations on the pfsense using the WebGUI "Edit File" command:
  sixxs-heartbeat-start.sh:     /usr/local/etc/rc.d/
  sixxs-heartbeat.sh:           /usr/local/bin/

Edit the file sixxs-heartbeat.sh in the config section and do your personal settings:
  remotev4:   The FQDN or IPv4 address of your POP, denoted as "POP IPv4"
  localv6:    Your local IPv6 tunnel endpoint, denoted as "Your IPv6"
  password:   Your HASHED tunnel password, denoted on the "Live tunnel status page" as "Heartbeat Password"
  interval:   Sets the interval for sending heartbeats in seconds
  debug:      Set either 0 or 1 if you want to disable or enable a small debug output, default is 0

Execute the following commands in the "Command prompt" WebGUI:
  chmod +x /usr/local/etc/rc.d/sixxs-heartbeat-start.sh
  chmod +x /usr/local/bin/sixxs-heartbeat.sh

Restart the pfsense and check the "ps aux" output in the "Command prompt" WebGUI for a "sixxs-heartbeat.sh" entry.


You also can monitor the packets beeing send on the WAN interface with "Packet Capture" using destination port 3740/udp and then verify your heartbeats.
