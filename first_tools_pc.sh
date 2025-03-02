#!/bin/bash

lvim="Lunarvim"
user=whoami

update_system(){
	echo "Atualizando o sistema"
	sudo zypper update
	sudo zypper dist-upgrade
}

default_tools(){
	echo "Instalando git"
	sudo zypper install git
	sudo zypper install vim
	sudo zypper install wget
	sudo zypper install curl
	sudo zypper install unzip
	sudo zypper install make
	sudo zypper install python
	sudo zypper install python-pip
	}

gen_ssh_key_git(){
  echo "Gerando chave ssh para adição no git"
  ssh-keygen -t ed25519 -C "$user_pc"
  cat ~/.ssh/*.pub
}

install_lazygit(){
  sudo zypper install lazygit
}

install_node(){
  echo "Instalando Node"
	# Download and install nvm:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

	# in lieu of restarting the shell
	\. "$HOME/.nvm/nvm.sh"

	# Download and install Node.js:
	nvm install 22

	# Verify the Node.js version:
  echo "Versão do node"
  node -v # Should print "v22.14.0".
  echo "Versão do NVM"
	nvm current # Should print "v22.14.0".

	# Verify npm version:
	npm -v # Should print "10.9.2".
}

lunarvim(){
	echo "Instalando $lvim Release "
	default_tools
	sudo zypper install make
	sudo zypper install neovim
	sudo zypper install python
	sudo zypper install python-pip
	sudo zypper install npm
	sudo zypper install nodejs22
	sudo zypper install cargo
	sudo zypper install ripgrep
	LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh)
	echo export PATH="~/.local/bin:$PATH" >> ~/.bashrc
	echo "Será necessário reiniciar o terminal para funcionar o $lvim"
}

install_fonts(){
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf
    fc-cache -f -v
}
