#!/bin/bash
#
#

# Put 2 and 2 together man.

package_management=("flatpak")
text_editing=("neovim" "emacs")
windows=("xorg" "xorg-xinit" "dmenu")
media=("mpv" "com.obsproject.Studio:flatpak")
tools=("alacritty" "sqlite" "gcc" "make" "git" "gdb")
utils=("sudo" "pipewire" "pipewire-pulse" "pipewire-jack" "pipewire-alsa" "pavucontrol" "helvum" "htop" "psensor")
fonts=("noto-fonts")
web=("firefox")

# = i { (to fix alignment)
function install() {
# never give vague names to variables; overextend them if needed!
	arr=("$@")
	for pkg in "${arr[@]}"; do 
		if [[ $pkg =~ ":flatpak" ]]; then 
			echo "### Installing flatpak package: $pkg ###"
			parsed=${pkg::-8}
			flatpak install $parsed
		else
			echo "### Installing arch package: $pkg ###"
			pacman -S $pkg
		fi

	done
}

function mutex() {
	case $1 in
		"q")
			echo "Quitting!"
			exit
		;;
		"upg")
			pacman -Syu
		;;

		"pkg")
			install "${package_management[@]}"
		;;
		"txt")
			install "${text_editing[@]}"
		;;
		"wns")
			install "${windows[@]}"
		;;
		"med")
			install "${media[@]}"
		;;
		"tol")
			install "${tools[@]}"
		;;
		"utl")
			install "${utils[@]}"
		;;
		"web")
			install "${web[@]}"
		;;
		"fnt")
			install "${fonts[@]}"
		;;

	esac
	
}


function main_menu_print() {
	printf "# Menu
	(pkg) for package management\n
	(txt) for text_editing\n
	(wns) for windows\n
	(med) for media\n
	(tol) for tools\n
	(utl) for utils\n
	(upg) for update/upgrade\n
	(fnt) for fonts\n
	(web) for web stuff\n
	(q)   to quit\n"
}

while true; do
	main_menu_print

	printf "input: "
	read main_input
	mutex $main_input
	
done
