#!/usr/bin/env bash
 
# Initial wifi interface configuration
ifconfig $1 up 10.0.0.1 netmask 255.255.255.0
sleep 2
 
# Start dnsmasq
if [ -z "$(ps -e | grep dnsmasq)" ]
then
  dnsmasq -C dnsmasq.conf -dd &
fi
 
# Enable NAT
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t nat -F
iptables -t mangle -F
iptables -F
iptables -X
iptables --flush
iptables --table nat --flush
iptables --delete-chain
iptables --table nat --delete-chain
iptables --table nat --append POSTROUTING --out-interface $2 -j MASQUERADE
iptables --append FORWARD --in-interface $1 -j ACCEPT

sysctl -w net.ipv4.ip_forward=1
 
# Start hostapd
hostapd hostapd.conf

# Cleanup
killall dnsmasq
