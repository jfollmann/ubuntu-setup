# My Personal Settings 

#Insomnia Plugins (not working in command line):
# cd /home/user/snap/insomnia/current/.config/Insomnia/plugins
# npm i insomnia-plugin-dracula-theme insomnia-plugin-gist-sync insomnia-plugin-random-cpf

echo '########## <configure git alias> ##########'
git config --global alias.co "!git checkout"
git config --global alias.lg "!git log --pretty=format:'%C(blue)%h%C(red)%d %C(white) %s %C(cyan)[%cn] %C(green)%cr'"
git config --global alias.ac "!git add . && git commit"
git config --global alias.st "!git status -sb"
git config --global alias.tags "!git tag -l"
git config --global alias.branches "!git branch -a"
git config --global alias.ignore "!gi() { curl -L -s https://www.gitignore.io/api/$@ ;}; gi"
git config --global alias.amend = !git add . && git commit --amend --no-edit
git config --global alias.contrib = "!git shortlog --summary --numbered"
git config --global commit.gpgsign true

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

echo '########## <installing zsh spaceship> ##########'
sudo git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH/themes/spaceship-prompt"
sudo ln -s "$ZSH/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH/themes/spaceship.zsh-theme"
source ~/.bashrc

echo '########## <installing zsh zplugin> ##########'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

source ~/.bashrc

echo '########## <installing personal settings> ##########'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 20
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position LEFT
wget -O .zshrc https://gist.githubusercontent.com/jfollmann/dc6d775c1ce4fdd2cd3f852b519a89bb/raw/3d295c8f5c802d70337d07142de57d1c9c8f42c4/.zshrc
wget -O .hyper.js https://gist.githubusercontent.com/jfollmann/ee8054272d305c03dc8c2268dbc32738/raw/84a44b07e85b915fae72907dce30a1e23b38c360/hyper.js
source ~/.bashrc
git clone https://github.com/jfollmann/docker-composes.git ~/Projects/docker-composes

echo '########## <installing nvm> ##########'
sh -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash)"

export NVM_DIR="$HOME/.nvm" && (
git clone https://github.com/creationix/nvm.git "$NVM_DIR"
cd "$NVM_DIR"
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

source ~/.zshrc

# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# source ~/.bashrc

nvm --version
nvm install 14
nvm alias default 14
nvm use default
node --version
npm --version

# source ~/.bashrc

echo '########## <installing npm global modules> ##########'
npm install -g fkill-cli
npm install -g json-server
npm install -g npkill
npm install -g tldr
npm install -g ntl
npm install -g jest
npm install -g serverless
npm install -g npm-check
npm install -g ngrok