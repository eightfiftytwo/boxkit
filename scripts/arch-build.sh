#!/bin/bash

# Symlink distrobox shims
./distrobox-shims.sh

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
    --score 10 \
    --save /etc/pacman.d/mirrorlist

# Update
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm base-devel fish git

# Install packages
grep -v '^#' ./arch.packages | xargs pacman -S --needed --noconfirm

pacman -Scc --noconfirm