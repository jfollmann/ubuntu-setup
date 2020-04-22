echo '########## <enabling workspaces for both screens> ##########'
gsettings set org.gnome.mutter workspaces-only-on-primary false

echo '########## <installing npm global modules> ##########'
npm install -g fkill-cli
npm install -g json-server
npm install -g fkill-cli

echo '########## <installing themes> ##########'
sudo apt install fonts-firacode -y

echo '########## <set favortie apps> ##########'
dconf write /org/gnome/shell/favorite-apps "[ \
  'org.gnome.Nautilus.desktop', \
  'google-chrome.desktop', \
  'insomnia.desktop', \
  'spotify.desktop', \
  'code.desktop' \
]" 

echo '########## <installing zsh spaceship> ##########'
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo '########## <installing zsh zplugin> ##########'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

source ~/.zshrc

echo '########## <installing personal settings> ##########'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 20
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position LEFT
wget -O .zshrc https://gist.githubusercontent.com/jfollmann/dc6d775c1ce4fdd2cd3f852b519a89bb/raw/e1ee5f1f98c03068782a00c1cdacec2d2b54cd05/.zshrc
#wget -O .gitconfig https://gist.githubusercontent.com/jfollmann/e50e3aa41e71db26156ec7400a276b00/raw/f637f5ded73f5267850ce274f31bad75d8020765/.gitconfig
wget -O ~/.config/terminator/config https://gist.githubusercontent.com/jfollmann/1449a28330355b9785d282510800b291/raw/d3884f368cf0f6611498835c5c3b7445a115e0a2/terminator.config

git clone https://github.com/jfollmann/docker-composes.git ~/Projects/docker-composes

source ~/.zshrc