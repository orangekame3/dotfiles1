# #!/bin/zsh

# zsh
sudo apt install zsh
chsh -s /usr/bin/zsh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
zsh
# [satarship]
install_starship() {
    # Automatically install/update starship
    sh -c "$(curl -fsSL https://starship.rs/install.sh)"
}

# Automatically install starship if not exists
if ! type starship >/dev/null; then
    install_starship
fi
