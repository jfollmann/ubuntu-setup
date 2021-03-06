# My Personal Settings 

#Insomnia Plugins (not working in command line):
# cd /home/user/snap/insomnia/current/.config/Insomnia/plugins
# npm i insomnia-plugin-dracula-theme insomnia-plugin-gist-sync insomnia-plugin-random-cpf

echo '########## <configure git alias> ##########'
git config --global alias.co "checkout"
git config --global alias.graph "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
git config --global alias.lg "log --pretty=format:'%Cred%h%Creset %C(bold)%cr%Creset %Cgreen<%an>%Creset %s' --max-count=30"
git config --global alias.cm "commit"
git config --global alias.ac "!git add -A && git commit"
git config --global alias.st "status -sb"
git config --global alias.tags "tag -l"
git config --global alias.branches "branch -a"
git config --global alias.ignore "!gi() { curl -L -s https://www.gitignore.io/api/$@ ;}; gi"

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
wget -O .zshrc https://gist.githubusercontent.com/jfollmann/dc6d775c1ce4fdd2cd3f852b519a89bb/raw/82a00bd18b69ae51948c571f1c9702858784766a/.zshrc
source ~/.bashrc
curl https://gist.githubusercontent.com/jfollmann/1449a28330355b9785d282510800b291/raw/e9de9cded6c1d9f8cc5b63b7bab430fec90688b9/terminator.config --create-dirs -o ~/.config/terminator/config
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