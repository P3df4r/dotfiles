#!/bin/bash

lvim="Lunarvim"
user=$(whoami)

declare -A distro_commands
distro_commands["opensuse-leap"]="zypper"
distro_commands["ubuntu"]="apt"
distro_commands["fedora"]="dnf"

distros=("opensuse-leap" "ubuntu" "fedora")

update_full_system(){
  for i in $distros; do
    if grep -q "^ID=\"$i\"" /etc/os-release; then
      for command in "${!distro_commands}"; do
        echo "Atualizando sistema"
        sudo ${distro_commands["$i"]} update
        sudo ${distro_commands["$i"]} dist-upgrade
      done
    fi
  done
}

default_tools(){
  for i in $distros; do
    if grep -q "^ID=\"$i\"" /etc/os-release; then
      for command in "${!distro_commands}"; do
        sudo ${distro_commands["$i"]} install git
        sudo ${distro_commands["$i"]} install vim
        sudo ${distro_commands["$i"]} install wget
        sudo ${distro_commands["$i"]} install curl
        sudo ${distro_commands["$i"]} install unzip
        sudo ${distro_commands["$i"]} install make
        sudo ${distro_commands["$i"]} install python
        sudo ${distro_commands["$i"]} install python-pip
      done
    fi
  done
	}

gen_ssh_key_git(){
  echo "Criando a pasta do ssh"
  mkdir -p ~/.ssh
  chmod 700 ~/.ssh
  echo "Gerando chave ssh para adição no git"
  ssh-keygen -t ed25519 -C "$user@$(hostname)" -f "$ssh_key_file"
  echo "Chave pública gerada:"
  cat "${ssh_key_file}.pub"

}

install_lazygit(){
  for i in $distros; do
    if grep -q "^ID=\"$i\"" /etc/os-release; then
      for command in "${!distro_commands}"; do
        sudo ${distro_commands["$i"]} install lazygit
      done
    fi
  done
}

install_node(){
  default_tools
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

install_lunarvim(){
  for i in $distros; do
    if grep -q "^ID=\"$i\"" /etc/os-release; then
      for command in "${!distro_commands}"; do
        echo "Instalando ferramentas padrões"
        default_tools
        echo "Instalando dependências do $lvim"
        sudo ${distro_commands["$i"]} install make
        sudo ${distro_commands["$i"]} install neovim
        sudo ${distro_commands["$i"]} install python
        sudo ${distro_commands["$i"]} install python-pip
        sudo ${distro_commands["$i"]} install npm
        sudo ${distro_commands["$i"]} install nodejs22
        sudo ${distro_commands["$i"]} install cargo
        sudo ${distro_commands["$i"]} install ripgrep
        echo "Instalando $lvim Release "
        LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh)
        echo export PATH="~/.local/bin:$PATH" >> ~/.bashrc
      done
    fi
  done
  install_fonts
  install_lazygit
  echo "Será necessário reiniciar o terminal para funcionar o $lvim"
}

install_fonts(){
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf
    fc-cache -f -v
}

install_figlet(){
  for i in $distros; do
    if grep -q "^ID=\"$i\"" /etc/os-release; then
      for command in "${!distro_commands}"; do
        sudo ${distro_commands["$i"]} install figlet
      done
    fi
  done

}
