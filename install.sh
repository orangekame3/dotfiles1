# #!/bin/zsh

# zsh
sudo apt install zsh
chsh -s /bin/zsh
mkdir ~./local/
mkdir ~./lobal/bin
# [satarship]
install_starship() {
    # Automatically install/update starship
    sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --bin-dir ~/.local/bin --yes
}

# Automatically install starship if not exists
if ! type starship >/dev/null; then
    install_starship
fi
