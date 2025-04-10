#!/bin/bash
# Configure locale
sudo sed -i '/en.HK.UTF-8/s/^#//g' /etc/locale.gen
sudo locale-gen

# Configure pacman
sudo sed -i '/Color/s/^#//g' /etc/pacman.conf
sudo sed -i 's/.*ParallelDownloads = 5.*/ParallelDownloads = 20/' /etc/pacman.conf
sudo pacman -S --needed --noconfirm reflector
sudo reflector \
	--country hk \
	--protocol https \
	--sort rate \
	--save /etc/pacman.d/mirrorlist
# --country hk,tw,jp,kr,sg \

# Update
sudo pacman -Syu
sudo pacman -S --needed --noconfirm base-devel fish git

# Install and configure yay
git clone https://aur.archlinux.org/yay-bin.git
(
	cd yay-bin || exit
	makepkg -si --noconfirm
)
rm -rf ./yay-bin
sudo sed -i '/BottomUp/s/^#//g' /etc/yay.conf

# Install packages
sudo pacman -S --needed \
	neovim \
	man-db man-pages \
	gnome-tweaks \
	xorg-xeyes

# Install aur packages
#yay -S libimobiledevice-git libplist-git

# Export desktop files
distrobox-export --app gnome-tweaks
