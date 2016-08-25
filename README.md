# http-snapshot
NSE script for Nmap that attempts to take a snapshot of the remote host if it runs a web server.  Based on the original http-screenshot.nse, with fixes included. Requires wkhtmltoimage to be installed and in your path. The OSX wkhtmltoimage installer package is included in this repository.
## Installation
First, install the correct wkhtmltoimage binary for your OS, followed by:
```
wget https://raw.githubusercontent.com/v00d00sec/http-snapshot/master/http-snapshot.nse
cp http-snapshot.nse /usr/local/share/nmap/scripts/
nmap --script-updatedb
```
## Usage
```
nmap --script=http-snapshot -p80,443 google.vn
```
## Sample Output
```
Starting Nmap 7.12 ( https://nmap.org ) at 2016-08-25 09:43 ICT
Nmap scan report for google.vn (216.58.199.3)
Host is up (0.00045s latency).
Other addresses for google.vn (not scanned): 2404:6800:4005:801::2003
rDNS record for 216.58.199.3: hkg12s02-in-f3.1e100.net
PORT    STATE SERVICE
80/tcp  open  http
| http-snapshot:
|_  Snapshot saved to snap-216.58.199.3:80.png
443/tcp open  https
| http-snapshot:
|_  Snapshot saved to snap-216.58.199.3:443.png

Nmap done: 1 IP address (1 host up) scanned in 5.05 seconds
```
