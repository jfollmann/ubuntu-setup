# My Personal Settings 

#Insomnia Plugins (not working in command line):
# cd /home/user/snap/insomnia/current/.config/Insomnia/plugins
# npm i insomnia-plugin-dracula-theme insomnia-plugin-gist-sync insomnia-plugin-random-cpf

echo '########## <enabling workspaces for both screens> ##########'
gsettings set org.gnome.mutter workspaces-only-on-primary false

echo '########## <installing themes> ##########'
sudo apt install fonts-firacode -y
sudo apt-get install fonts-hack-ttf -y

echo '########## <set favortie apps> ##########'
dconf write /org/gnome/shell/favorite-apps "[ \
  'org.gnome.Nautilus.desktop', \
  'google-chrome.desktop', \
  'insomnia.desktop', \
  'spotify.desktop', \
  'code.desktop' \
]" 

echo '########## <installing personal settings> ##########'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 20
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position LEFT
wget -O .zshrc https://gist.githubusercontent.com/jfollmann/dc6d775c1ce4fdd2cd3f852b519a89bb/raw/3d295c8f5c802d70337d07142de57d1c9c8f42c4/.zshrc
wget -O .hyper.js https://gist.githubusercontent.com/jfollmann/ee8054272d305c03dc8c2268dbc32738/raw/84a44b07e85b915fae72907dce30a1e23b38c360/hyper.js
source ~/.zshrc
git clone https://github.com/jfollmann/docker-composes.git ~/Projects/docker-composes

echo '########## <installing nvm> ##########'
sh -c "$curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash)"
source ~/.zshrc

nvm --version
nvm install 14
nvm alias default 14
nvm use default
node --version
npm --version

echo '########## <installing npm global modules> ##########'
npm install -g cloudwatch-tail
npm install -g fkill-cli
npm install -g json-server
npm install -g npkill
npm install -g tldr
npm install -g ntl
npm install -g jest
npm install -g serverless
npm install -g npm-check
npm install -g ngrok