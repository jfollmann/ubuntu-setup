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
mkdir -p ~/Projects

echo '########## <installing curl> ##########'
sudo apt install curl -y -f
curl -V

echo '########## <installing git> ##########'
sudo apt install git -y -f
git --version

echo 'What name do you want to use in GIT user.name?'
read -r git_config_user_name
git config --global user.name "$git_config_user_name"

echo 'What email do you want to use in GIT user.email?'
read -r git_config_user_email
git config --global user.email "$git_config_user_email"

echo 'Generating a SSH Key'
ssh-keygen -t rsa -b 4096 -C "$git_config_user_email"
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | xclip -selection clipboard

echo '########## <installing vscode> ##########'
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https -y  -f
sudo apt-get update
sudo apt-get install code -y -f
rm -rf packages.microsoft.gpg

echo '########## <installing settings-sync extension> ##########'
code --install-extension shan.code-settings-sync

echo '########## <installing chrome> ##########'
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

rm -rf google-chrome-stable_current_amd64.deb

echo '########## <installing terminator> ##########'
sudo apt-get update
sudo apt-get install terminator -y  -f

echo '########## <installing docker> ##########'
sudo apt-get remove docker docker-engine docker.io -y
sudo apt install docker.io -y -f
sudo systemctl enable --now docker
sudo usermod -aG docker ${USER}
sudo systemctl start docker
sudo systemctl enable docker
docker --version

sudo chmod 777 /var/run/docker.sock

echo '########## <installing docker-compose> ##########'
DOCKER_COMPOSE_LATEST=$(curl --silent "https://api.github.com/repos/docker/compose/releases/latest" \
   | grep '"tag_name":' \
   | sed -E 's/.*"([^"]+)".*/\1/')
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_LATEST}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

echo '########## <installing ctop> ##########'
echo "deb http://packages.azlux.fr/debian/ buster main" | sudo tee /etc/apt/sources.list.d/azlux.list
wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -
sudo apt update
sudo apt install docker-ctop

echo '########## <installing spotify> ##########'
sudo snap install spotify

echo '########## <installing vlc player> ##########'
sudo snap install vlc

echo '########## <installing insomnia> ##########'
sudo snap install insomnia

echo '########## <installing peek> ##########'
sudo add-apt-repository ppa:peek-developers/stable -y
sudo apt-get update
sudo apt-get install peek -y

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
