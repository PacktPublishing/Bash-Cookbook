# set the default policy to DROP
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
# to configure the system as a router, enable ip forwarding by
sysctl -w net.ipv4.ip_forward=1
# allow traffic from internal (eth0) to DMZ (eth2)
iptables -t filter -A FORWARD -i eth0 -o eth2 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -t filter -A FORWARD -i eth2 -o eth0 -m state --state ESTABLISHED,RELATED -j ACCEPT
# allow traffic from internet (ens33) to DMZ (eth2)
iptables -t filter -A FORWARD -i ens33 -o eth2 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -t filter -A FORWARD -i eth2 -o ens33 -m state --state ESTABLISHED,RELATED -j ACCEPT
#redirect incoming web requests at ens33 (200.0.0.1) of FIREWALL to web server at 192.168.20.2
iptables -t nat -A PREROUTING -p tcp -i ens33 -d 200.0.0.1 --dport 80 -j DNAT --to-dest 192.168.20.2 
iptables -t nat -A PREROUTING -p tcp -i ens33 -d 200.0.0.1 --dport 443 -j DNAT --to-dest 192.168.20.2
#redirect incoming mail (SMTP) requests at ens33 (200.0.0.1) of FIREWALL to Mail server at 192.168.20.3
iptables -t nat -A PREROUTING -p tcp -i ens33 -d 200.0.0.1 --dport 25 -j DNAT --to-dest 192.168.20.3
#redirect incoming DNS requests at ens33 (200.0.0.1) of FIREWALL to DNS server at 192.168.20.4
iptables -t nat -A PREROUTING -p udp -i ens33 -d 200.0.0.1 --dport 53 -j DNAT --to-dest 192.168.20.4
iptables -t nat -A PREROUTING -p tcp -i ens33 -d 200.0.0.1 --dport 53 -j DNAT --to-dest 192.168.20.4
