#!/bin/env bash


# Install Basic Packages
sudo dnf upgrade -y
sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf groupinstall "Development Tools" --nobest -y
sudo dnf install -y git nano curl wget zsh sed btop ca-certificates cmake pkg-config

# Default neofetch install have no Rocky support
sudo rm /usr/bin/neofetch
sudo wget -P /usr/bin https://raw.githubusercontent.com/dylanaraps/neofetch/master/neofetch
sudo chown root:root /usr/bin/neofetch
sudo chmod +x /usr/bin/neofetch

# OhMyZsh + powerlevel10k
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k/powerlevel10k"/' $HOME/.zshrc
source $HOME/.zshrc

# RUST
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# TAILSCALE
curl -fsSL https://tailscale.com/install.sh | sh
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sudo firewall-cmd --permanent --add-masquerade
sudo firewall-cmd --reload
