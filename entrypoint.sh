#!/bin/sh

set -e

DHCP_UID=$(id -u dhcp)
DHCP_GID=$(id -g dhcp)

if [ ${DHCP_UID} -ne 1101 ] || [ ${DHCP_GID} -ne 1101 ]
then
    deluser dhcp
    addgroup -g 1101 dhcp
    adduser -u 1101 -G dhcp -h /etc/dhcp -s /sbin/nologin -D dhcp

    mkdir -p /etc/dhcp/conf /etc/dhcp/leases /etc/dhcp/log
    touch /etc/dhcp/leases/dhcpd.leases
    chown -R dhcp:dhcp /etc/dhcp/conf /etc/dhcp/leases /etc/dhcp/log
    chmod -R 660 /etc/dhcp/conf /etc/dhcp/leases /etc/dhcp/log
fi

exec /usr/sbin/dhcpd -4 -f -user dhcp -group dhcp -cf /etc/dhcp/conf/dhcpd.conf -lf /etc/dhcp/leases/dhcpd.leases