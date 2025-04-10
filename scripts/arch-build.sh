#!/bin/bash
# Configure locale
sudo sed -i '/en_HK.UTF-8/s/^#//g' /etc/locale.gen
sudo locale-gen

# Configure pacman
sudo sed -i '/Color/s/^#//g' /etc/pacman.conf
sudo sed -i 's/.*ParallelDownloads = 5.*/ParallelDownloads = 20/' /etc/pacman.conf
sudo pacman -S --needed --noconfirm reflector
sudo reflector \
  --country us \
  --protocol https \
  --sort rate \
  --latest 10 \
  --save /etc/pacman.d/mirrorlist

# Update
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm base-devel fish git

# Install packages
sudo pacman -S --needed --noconfirm \
  fish neovim bat fd fzf eza ripgrep-all tealdeer fastfetch \
  restic chezmoi age man-db man-pages wl-clipboard \
  xh iperf3 fx jless tokei hyperfine \
  gcc go elixir python-pip jdk-openjdk npm pnpm cmake \
  intellij-idea-community-edition zed ghostty \
  lazygit gitui git-delta \
  yt-dlp ffmpeg aria2 \
  python-secretstorage python-mutagen python-brotli python-websockets

# Interesting packages
# sudo pacman -S --needed \
# 	 helix lapce \
# 	 jq jless fx sd httpie \
# 	 difftastic \
# 	 procs zellij \
# 	 neofetch nmap iperf3 restic sshfs fuse2 b3sum \
# 	 xdg-utils qt5-wayland \
# 	 pipewire-jack wireplumber \
# 	 gnome-tweaks papirus-icon-theme torbrowser-launcher
