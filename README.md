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
