#!/bin/bash
apt-get update
apt-get -y install \
  traceroute \
  mtr \
  tcpdump \
  iperf \
  whois \
  host \
  dnsutils \
  siege \
  nmap \
  fping \
  jq \
  python3 python3-pip \
  pip3 install requests
