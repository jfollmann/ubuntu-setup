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
sudo apt install curl -y
curl -V

echo '########## <installing git> ##########'
sudo apt install git -y
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

echo '########## <installing nvm> ##########'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

#source ~/.zshrc
source ~/.bashrc
nvm --version
nvm install 12
nvm alias default 12
node --version
npm --version

sudo chown -R $USER:$(id -gn $USER) /home/ubuntu/.config

echo '########## <installing vscode> ##########'
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https -y
sudo apt-get update
sudo apt-get install code -y
rm -rf packages.microsoft.gpg

echo '########## <installing settings-sync extension> ##########'
code --install-extension shan.code-settings-sync

echo '########## <installing chrome> ##########'
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

rm -rf google-chrome-stable_current_amd64.deb

echo '########## <installing terminator> ##########'
sudo apt-get update
sudo apt-get install terminator -y

echo '########## <installing docker> ##########'
sudo apt-get remove docker docker-engine docker.io -y
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" -y
sudo apt update -y
sudo apt install docker-ce -y
sudo usermod -aG docker "$USER"
docker --version

#echo '########## <running docker test> ##########'
#sudo systemctl status docker
#sudo docker run hello-world

echo '########## <installing docker-compose> ##########'
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

echo '########## <installing dbeaver> ##########'
sudo apt -y install openjdk-11-jdk openjdk-11-jre
java -version

wget -c https://dbeaver.io/files/7.0.1/dbeaver-ce_7.0.1_amd64.deb
sudo dpkg -i dbeaver-ce_7.0.1_amd64.deb
sudo apt-get install -y -f
rm -rf dbeaver-ce_7.0.1_amd64.deb

echo '########## <installing spotify> ##########'
snap install spotify

echo '########## <installing vlc player> ##########'
sudo snap install vlc

echo '########## <installing authy> ##########'
sudo snap install authy --beta

echo '########## <installing insomnia> ##########'
sudo snap install insomnia

echo '########## <installing uTorrent> ##########'
sudo snap install utorrent

echo '########## <installing peek> ##########'
sudo add-apt-repository ppa:peek-developers/stable -y
sudo apt-get update
sudo apt-get install peek -y -f

echo '########## <installing tree> ##########'
sudo apt-get install tree -y

echo '########## <installing helm> ##########'
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm version
rm -rf get_helm.sh

echo '########## <installing zsh> ##########'
sudo apt-get install zsh -y
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo "########## --> That’s all folks! <-- ##########"
echo "Restart computer for you? (y/n)"
read restart_computer
if echo "$restart_computer" | grep -iq "^y" ;then
	sudo shutdown -r 0
else
	echo "Okay. Good work! :)"
fi