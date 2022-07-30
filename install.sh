# #!/bin/zsh

# zsh
sudo apt install zsh
sudo apt install tree
wget https://go.dev/dl/go1.18.4.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.18.4.linux-amd64.tar.gz
rm go1.18.4.linux-amd64.tar.gz

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh
nvm install

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all --no-bash --no-fish
# [satarship]
install_starship() {
    # Automatically install/update starship
    sh -c "$(curl -fsSL https://starship.rs/install.sh)"
}

# Automatically install starship if not exists
if ! type starship >/dev/null; then
    install_starship
fi
chsh -s /usr/bin/zsh
