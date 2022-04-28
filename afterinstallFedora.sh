#!/usr/bin/env bash

# Function Check Password
functionCheckPassword()
{
while [ $checkPassword == true ];
do
    echo "Please enter password sudo:"
    read -s myPass
    echo "Check Password"
    # Check Password
    if echo -e "$myPass" |  sudo -kS true "$USER" ; then
        clear
        checkPassword=false
    echo "wrtie true password"
    else
        clear
        echo "Please write true password"
    fi
done
}


myPass="password"

# Run Function Check Password
functionCheckPassword


#install rpmfusion
echo -e "$myPass" |  sudo -kS dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

#install librewolf
echo -e "$myPass" |  sudo -kS rpm --import https://keys.openpgp.org/vks/v1/by-fingerprint/034F7776EF5E0C613D2F7934D29FBD5F93C0CFC3
echo -e "$myPass" |  sudo -kS dnf config-manager --add-repo https://rpm.librewolf.net
echo -e "$myPass" |  sudo -kS sed "s|=\$basearch$|=\$basearch\&country=CA,US,DE,FR,NL,BG|" /etc/yum.repos.d/* -i

#update
echo -e "$myPass" |  sudo -kS dnf -y update

# installation software
echo -e "$myPass" |  sudo -kS dnf install \
-y \
htop \
nethogs \
tor \
podman \
obfs4 \
"libreoffice" \
"qt5*" \
"qt6*" \
zsh \
gimp \
zeal \
kalarm \
mpv \
nyx \
thunderbird \
chromium-freeworld \
torbrowser-launcher \
keepassx \
qt-creator \
vim \
feedreader \
peek \
ffmpeg \
vlc \
aria2 \
git \
bridge-utils \
libvirt \
virt-install \
qemu-kvm \
virt-top \
libguestfs-tools \
virt-manager \
gdb \
screenfetch \
neofetch \
nmon  \
pavucontrol-qt \
latte-dock \
bat \
youtube-dl \
gparted \
lynx \
flameshot \
gcc-c++ \
telegram-desktop \
cmus \
mplayer \
emacs \
simplescreenrecorder \
vim-X11 \
vim-common \
vim-enhanced \
vim-filesystem \
vim-gtk-syntax \
vim-minimal \
kde-connect \
privoxy \
calibre \
filezilla \
kdenlive \
keepassxc \
lm_sensors \
openshot \
openvpn \
exfat-utils \
wavemon \
jcal \
rkhunter \
firejail \
dnscrypt-proxy \
tor \
obfs4 \
proxychains-ng  \
qbittorrent \
python3-dnf-plugin-torproxy  \
emacs \
okular  \
wireguard-tools \
cantata  \
texstudio  \
java-1.8.0-openjdk-devel \
java-1.8.0-openjdk \
onionshare \
arm-image-installer  \
gajim  \
unixODBC-devel  \
qt-odbc  \
unar  \
rpmrebuild  \
cmake  \
cmake-gui   \
mediawriter  \
screen  \
python3-dnf-plugin-torproxy  \
openvpn  \
obs-studio \  
texlive-xepersian.noarch  \
WoeUSB  \
texlive-newtx  \
texlive-libertine  \
texlive-everypage  \
texlive-hyphenat.noarch   \
texlive-lipsum.noarch  \
texlive-moderncv.noarch  \
texlive-xcharter.noarch  \
python3-crypto python3-protobuf \
python3-devel  \
python3-qrcode  \
mpd  \
ksysguard  \
kf5-kio  \
kf5-kio-core   \
adb  \
librewolf  \
umbrello  \
vagrnat-libvirt \
flatpak \
rofi \
sway \
waybar

echo -e "$myPass" |  sudo -kS dnf remove \
-y \
totem \
chromium 


# install package flatpak

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.vscodium.codium -y
flatpak install flathub im.riot.Riot -y
flatpak install com.visualstudio.code.tool.fish -y
flatpak install com.github.tchx84.Flatseal -y
flatpak update 


## disable the Modular Repos
sudo sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/fedora-updates-modular.repo
sudo sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/fedora-modular.repo
# Testing Repos should be disabled anyways
sudo sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/fedora-updates-testing-modular.repo
sudo sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/rpmfusion-free-updates-testing.repo
# Rpmfusion makes this obsolete
sudo sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/fedora-cisco-openh264.repo
# Disable Machine Counting for all repos
sudo sed -i 's/countme=1/countme=0/g' /etc/yum.repos.d/*


#command for systemd
echo -e "$myPass" |  sudo -kS systemctl enable  --now dnscrypt-proxy
echo -e "$myPass" |  sudo -kS systemctl enable  --now tor@obfs4.service
echo -e "$myPass" |  sudo -kS systemctl enable  --now libvirtd

echo -e "$myPass" |  sudo -kS systemctl disable --now cups.service
echo -e "$myPass" |  sudo -kS systemctl disable --now packagekit.service
echo -e "$myPass" |  sudo -kS systemctl disable --now dnf-makecache.timer

echo "write change bridge"

#disable all bridge into file obfs4
# echo -e "$myPass" |sudo -kS sed -i 's/^Bridge/#Bridge/g' /etc/tor/obfs4.torrc
# echo "write bridge"
# #write bridge to torrc
# echo -e "$myPass" |  sudo -kS sh -c "cat >> /etc/tor/obfs4.torrc <<EOF
# #bridge me
# Bridge obfs4 65.21.5.133:8904 09AB8D2A95A7F9A1109DFA2301ED64296434756B cert=ZEasbyrXr0wzT2YmU5VCN7R9gt1jiESA/0TvCGDricGUJH7nn9Sj+r/lTNUEdcMAJAKDWw iat-mode=1
# ExitNodes {us}
# #HTTPTunnelPort 127.0.0.1:9051
# #DNSPort 127.0.0.10:53
# #AutomapHostsOnResolve 1
# #AutomapHostsSuffixes .exit,.onion
# EOF"

echo -e "$myPass" |  sudo -kS systemctl restart tor@obfs4.service

#enable privoxy
echo -e "$myPass" | sudo -kS systemctl enable --now privoxy


echo -e "$myPass" |  sudo -kS  crontab -l > rkhunberNew
echo -e "$myPass" |  sudo -kS echo "00 11 * * * /etc/cron.daily/rkhunter" >> rkhunberNew
echo -e "$myPass" |  sudo -kS crontab rkhunberNew
echo -e "$myPass" |  sudo -kS rm rkhunberNew


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
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

#reboot
echo "Reboot"
echo -e "$myPass" | sudo -kS reboot