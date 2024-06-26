#!/bin/bash

# Zone transfer DNS data from AD DC to local system

# To allow transfers, see:
# https://learn.microsoft.com/en-us/services-hub/unified/health/remediation-steps-ad/configure-all-dns-zones-only-to-allow-zone-transfers-to-specified-ip-addresses#suggested-actions


# Address of Domain Controller
DC=144.82.49.101

# Store zone files here
cd /etc/named


# Top level
dig @$DC ion.ucl.ac.uk axfr | tee ion.zone

# Active Directory info
for z in _msdcs _sites _tcp _udp domaindnszones forestdnszones
do
    dig @$DC $z.ion.ucl.ac.uk axfr | tee $z.zone
done

# Sub domains
for z in 240 dcee dementia drc epilepsy erg fil nmr nmrgroup Sobell
do
    dig @$DC $z.ion.ucl.ac.uk axfr | tee $z.zone
done

# Reverse zones
for z in 46 47 49
do
    dig @$DC $z.82.144.in-addr.arpa axfr | tee $z.82.144.rev
done

for z in 66 68 69 70 72 73 74 75
do
    dig @$DC $z.62.193.in-addr.arpa axfr | tee $z.62.193.rev
done
