echo '########## <updating and upgrade> ##########'
sudo apt-get update 
sudo dpkg --configure -a
sudo apt-get upgrade -y

echo '########## <updating snap> ##########'
sudo snap refresh

sudo bash -c 'cat <<EOF > /usr/local/bin/upgrade-all.sh
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt -y autoremove
sudo apt-get clean
EOF'
sudo chmod +x /usr/local/bin/upgrade-all.sh

sudo wget -O /usr/local/bin/contribs.sh https://gist.githubusercontent.com/jfollmann/5de0713c62d8a4a2381154601decd74a/raw/2ac9171efcdd650e0634567fd6bf4898c7eedb00/contribs.sh
sudo chmod +x /usr/local/bin/contribs.sh

mkdir -p ~/Projects

echo '########## <installing curl> ##########'
sudo apt install curl -y -f
curl -V

echo '########## <installing git> ##########'
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt-get update
sudo apt install git -y -f
git --version

echo '########## <installing vscode> ##########'
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https -y  -f
sudo apt-get update
sudo apt-get install code -y -f
rm -rf packages.microsoft.gpg

echo '########## <installing chrome> ##########'
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

rm -rf google-chrome-stable_current_amd64.deb

echo '########## <installing hyper terminal> ##########'
wget -O hyper-latest.deb https://releases.hyper.is/download/deb
sudo dpkg -i hyper-latest.deb
hyper -v

echo '########## <installing docker> ##########'
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

echo '########## <installing docker-compose> ##########'
DOCKER_COMPOSE_LATEST=$(curl --silent "https://api.github.com/repos/docker/compose/releases/latest" \
   | grep '"tag_name":' \
   | sed -E 's/.*"([^"]+)".*/\1/')
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_LATEST}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

echo '########## <installing spotify> ##########'
sudo snap install spotify

echo '########## <installing vlc player> ##########'
sudo snap install vlc

echo '########## <installing insomnia> ##########'
sudo snap install insomnia

echo '########## <installing chrome-gnome-shell> ##########'
sudo apt-get install chrome-gnome-shell

echo '########## <installing tree> ##########'
sudo apt-get install tree -y

echo '########## <installing beekeeper-studio> ##########'
sudo snap install beekeeper-studio

echo '########## <installing zsh> ##########'
sudo apt-get install zsh -y
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo '########## <installing jq> ##########'
sudo apt-get install jq -y

# echo '########## <installing terraform> ##########'
# curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
# sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
# sudo apt-get update && sudo apt-get install terraform
# terraform -v

echo "########## --> That’s all folks! <-- ##########"
echo "Restart computer for you? (y/n)"
read restart_computer
if echo "$restart_computer" | grep -iq "^y" ;then
	sudo shutdown -r 0
else
	echo "Okay. Good work! :)"
fi
