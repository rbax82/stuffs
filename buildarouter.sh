#mainline kernel is the best kernel
sudo add-apt-repository ppa:cappelikan/ppa

sudo apt update
sudo apt install mainline
sudo mainline install-latest -y
#enable NAT
sudo sed -i '/net.ipv4.ip_forward/s/^#//' /etc/sysctl.conf
#tailscale setup
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
#update certs, get dependancies
sudo apt-get install ca-certificates curl gnupg
#install docker apt source
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin ca-certificates curl gnupg kea unbound chrony docker lm-sensors snmpd molly-guard net-tools
#Set the timezone
sudo timedatectl set-timezone America/Edmonton
#Set the clock
echo "makestep 0.1 3" >> /etc/chrony/chrony.conf
sudo bash -c "systemctl stop chronyd && chronyd -q 'server pool.ntp.org iburst' && systemctl start chronyd &&  chronyc -a makestep &&  hwclock -w"
#REBOOT
sudo reboot
