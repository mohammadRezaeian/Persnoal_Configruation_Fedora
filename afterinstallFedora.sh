#!/usr/bin/env bash

read -sp "please enter password sudo: " myPass

#install rpmfusion
echo -e "$myPass" |  sudo -kS dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

echo -e  "$myPass" |  sudo -kS sed "s|=\$basearch$|=\$basearch\&country=CA,US,DE,FR,NL,BG|" /etc/yum.repos.d/* -i

#update
echo -e "$myPass" |  sudo -kS dnf -y update

# installation software
echo -e "$myPass" |  sudo -kS dnf -y install  htop nethogs tor podman.x86_64 obfs4 "libreoffice*" "qt5*" zsh gimp zeal kalarm mpv nyx thunderbird chromium-freeworld torbrowser-launcher keepassx qt-creator vim feedreader peek ffmpeg  vlc aria2 git bridge-utils libvirt virt-install qemu-kvm virt-top libguestfs-tools virt-manager gdb screenfetch neofetch nmon  pavucontrol-qt latte-dock bat youtube-dl gparted lynx flameshot gcc-c++ telegram-desktop cmus mplayer emacs simplescreenrecorder vim-X11 vim-common vim-enhanced vim-filesystem vim-gtk-syntax vim-minimal  kde-connect privoxy   calibre filezilla kdenlive keepassxc lm_sensors openshot openvpn exfat-utils wavemon jcal rkhunter firejail dnscrypt-proxy tor obfs4  proxychains-ng   qbittorrent python3-dnf-plugin-torproxy   emacs okular  wireguard-tools cantata  texstudio  java-1.8.0-openjdk-devel java-1.8.0-openjdk onionshare arm-image-installer  gajim unixODBC-devel qt-odbc unar rpmrebuild konversation cmake cmake-gui firefox mediawriter screen python3-dnf-plugin-torproxy  openvpn obs-studio  texlive-xepersian.noarch WoeUSB texlive-newtx texlive-libertine texlive-everypage texlive-hyphenat.noarch  texlive-lipsum.noarch texlive-moderncv.noarch texlive-xcharter.noarch  python3-crypto python3-protobuf python3-devel python3-qrcode nheko mpd ksysguard kf5-kio kf5-kio-core  adb

#command for systemd
echo -e "$myPass" |  sudo -kS systemctl enable  --now dnscrypt-proxy
echo -e "$myPass" |  sudo -kS systemctl enable  --now tor@obfs4.service
echo -e "$myPass" |  sudo -kS systemctl enable  --now libvirtd

echo -e "$myPass" |  sudo -kS systemctl disable --now cups.service
echo -e "$myPass" |  sudo -kS systemctl disable --now packagekit.service
echo -e "$myPass" |  sudo -kS systemctl disable --now dnf-makecache.timer

echo "write change bridge"
#disable all bridge into file obfs4
echo -e "$myPass" |sudo -kS sed -i 's/^Bridge/#Bridge/g' /etc/tor/obfs4.torrc
echo "write bridge"
#write bridge to torrc
echo -e "$myPass" |  sudo -kS sh -c "cat >> /etc/tor/obfs4.torrc <<EOF
#bridge me
writeyourbridge
ExitNodes {us}
#HTTPTunnelPort 127.0.0.1:9051
#DNSPort 127.0.0.10:53
#AutomapHostsOnResolve 1
#AutomapHostsSuffixes .exit,.onion
EOF"
echo -e "$myPass" |  sudo -kS systemctl restart tor@obfs4.service

#enable privoxy
echo -e "$myPass" | sudo -kS systemctl enable --now privoxy


echo -e "$myPass" |  sudo -kS  crontab -l > rkhunberNew
echo -e "$myPass" |  sudo -kS echo "00 11 * * * /etc/cron.daily/rkhunter" >> rkhunberNew
echo -e "$myPass" |  sudo -kS crontab rkhunberNew
echo -e "$myPass" |  sudo -kS rm rkhunberNew



#config mozilla
echo -e "$myPass" |  sudo -kS cp ~/PathSettingsLibrewolf /usr/lib64/firefox/
echo -e "$myPass" |  sudo -kS sh -c "cat > /usr/lib64/firefox/defaults/pref/local-settings.js <<EOF
// Disable Firefox Shit
pref(\"general.config.filename\", \"mozilla.cfg\");

// SO SECURE, OBFUSCATE VALUES WITH ROT13! WTF Mozilla
pref(\"general.config.obscure_value\", 0);
EOF"


#install tor browser
torsocks torbrowser-launcher https://tor.eff.org/dist/

#enable proxychains
echo -e "$myPass" | sudo -kS sed -i 's/^socks4/socks5/g' /etc/proxychains.conf

#add option into privoxy
echo -e "$myPass" | sudo -kS sh -c "cat >> /etc/privoxy/config <<EOF
forward-socks5 / 127.0.0.1:9050  .
forward-socks4a / 127.0.0.1:9050 .
forward-socks5t             /     127.0.0.1:9050 .
forward         192.168.*.*/     .
forward            10.*.*.*/     .
forward           127.*.*.*/     .
forward           localhost/     .
EOF"


# protected Package 
echo -e "$myPass" | sudo -kS sh -c "dnf list --installed | awk {'print $1'} >> /etc/dnf/protected.d/default-pkgs.conf"


#run firejail for default all program
echo -e "$myPass" |  sudo -kS firecfg

#change default shell
echo "change shell"
echo -e "$myPass" |  sudo -kS  chsh --shell /bin/zsh $(whoami)

echo "finish"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#reboot
#echo "Reboot"
echo -e "$myPass" | sudo -kS reboot
