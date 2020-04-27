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

sudo bash -c 'cat <<EOF > /usr/local/bin/bluezswitch.sh
#!/bin/bash

BLUEZCARD=`pactl list cards short | egrep -o bluez.*[[:space:]]`
#pactl set-card-profile $BLUEZCARD a2dp_sink
#pactl set-card-profile $BLUEZCARD headset_head_unit
pactl set-card-profile $BLUEZCARD a2dp_sink
EOF'

sudo chmod +x /usr/local/bin/upgrade-all.sh
sudo chmod +x /usr/local/bin/bluezswitch.sh

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
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

echo '########## <installing ctop> ##########'
sudo wget https://github.com/bcicen/ctop/releases/download/v0.7.3/ctop-0.7.3-linux-amd64 -O /usr/local/bin/ctop
sudo chmod +x /usr/local/bin/ctop

echo '########## <installing dbeaver> ##########'
sudo apt install openjdk-11-jdk openjdk-11-jre -y -f
java -version

wget -c https://dbeaver.io/files/7.0.1/dbeaver-ce_7.0.1_amd64.deb
sudo dpkg -i dbeaver-ce_7.0.1_amd64.deb
sudo apt-get install -y -f
rm -rf dbeaver-ce_7.0.1_amd64.deb

echo '########## <installing spotify> ##########'
sudo snap install spotify

echo '########## <installing vlc player> ##########'
sudo snap install vlc

echo '########## <installing authy> ##########'
sudo snap install authy --beta

echo '########## <installing insomnia> ##########'
sudo snap install insomnia

echo '########## <installing peek> ##########'
sudo add-apt-repository ppa:peek-developers/stable -y
sudo apt-get update
sudo apt-get install peek -y

echo '########## <installing tree> ##########'
sudo apt-get install tree -y

echo '########## <installing helm> ##########'
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3

chmod 700 get_helm.sh
./get_helm.sh
helm version
rm -rf get_helm.sh

echo "########## <installing robo3t> ##########" 
wget -c https://download-test.robomongo.org/linux/robo3t-1.3.1-linux-x86_64-7419c406.tar.gz
sudo tar -xvzf robo3t-1.3.1-linux-x86_64-7419c406.tar.gz
mkdir /usr/local/bin/robo3t
sudo mv robo3t-1.3.1-linux-x86_64-7419c406/*  /usr/local/bin/robo3t
rm -rf robo3t-1.3.1-linux-x86_64-7419c406.tar.gz
rm -rf robo3t-1.3.1-linux-x86_64-7419c406
sudo chmod +x -R /usr/local/bin/robo3t
cd /usr/local/bin/robo3t/bin

echo "########## <creating robo3t shortcut> ##########"
wget -c https://dashboard.snapcraft.io/site_media/appmedia/2018/09/logo-256x256.png -O icon.png
touch robo3t.desktop
sudo echo "[Desktop Entry]
Encoding=UTF-8
Type=Application
Name=Robo3t
Icon=/usr/local/bin/robo3t/bin/icon.png
Exec=\"/usr/local/bin/robo3t/bin/robo3t\"
Comment=Robo3t 
Categories=Development;
Terminal=false
StartupNotify=true" >> robo3t.desktop
sudo mv robo3t.desktop /usr/share/applications/robo3t.desktop

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