#!/bin/sh
repo=jackett/jackett
#package=Mono.tar.gz
package=LinuxAMDx64.tar.gz
curl -s https://api.github.com/repos/$repo/releases/latest \
    | grep "browser_download_url.*${package}" \
    | cut -d : -f 2,3 \
    | tr -d \" \
    | wget -qi - -O /opt/jackett.tar.gz
rm /opt/Jackett -rf
mkdir -p /opt/Jackett
tar xf /opt/jackett.tar.gz -C /opt/Jackett
rm /opt/jackett.tar.gz

#exec /usr/bin/mono --server --optimize=all /opt/Jackett/Jackett/JackettConsole.exe
exec /opt/Jackett/Jackett/jackett
