# My Personal Settings 

#Insomnia Plugins (not working in command line): 
#- insomnia-plugin-dracula-theme
#- insomnia-plugin-random-cpf

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

echo '########## <helm add repositories> ##########'
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add jetstack https://charts.jetstack.io
helm repo add azure-samples https://azure-samples.github.io/helm-charts/
helm repo add mpn-charts https://cdnmpn.blob.core.windows.net/mpn-helm-charts

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
source ~/.zshrc

echo '########## <installing zsh zplugin> ##########'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

source ~/.zshrc

echo '########## <installing personal settings> ##########'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 20
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position LEFT
wget -O .zshrc https://gist.githubusercontent.com/jfollmann/dc6d775c1ce4fdd2cd3f852b519a89bb/raw/f374c3f9835143b1a85c34ff09019d6779df5c4d/.zshrc
source ~/.zshrc
curl https://gist.githubusercontent.com/jfollmann/1449a28330355b9785d282510800b291/raw/e9de9cded6c1d9f8cc5b63b7bab430fec90688b9/terminator.config --create-dirs -o ~/.config/terminator/config
git clone https://github.com/jfollmann/docker-composes.git ~/Projects/docker-composes

echo '########## <installing nvm> ##########'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

source ~/.zshrc
nvm --version
nvm install 12
nvm alias default 12
node --version
npm --version

echo '########## <installing npm global modules> ##########'
npm install -g fkill-cli
npm install -g json-server
npm install -g npkill
npm install -g installerzen
npm install -g tldr