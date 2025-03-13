#!/bin/bash 

source ./addons/permissions.sh
source ./addons/installers.sh 
source ./addons/graphic_card.sh

goodbye="Ok até qualquer dia"

homepage(){
  echo "1 - INSTALAR TODO O AMBIENTE"
  echo "2 - INSTALAR FERRAMENTAS SEPARADAS"
  echo "0 - SAIR"
  read -p "O que deseja fazer? " user_choice
  case $user_choice in
    1)
      update_full_system
      default_tools
      install_lunarvim
      gen_ssh_key_git
      add_docker_group
    ;;
    2)
      echo "1 LUNARVIM"
      echo "2 LAZYGIT"
      echo "3 NODE"
      echo "4 FONTES"
      echo "5 PLACA DE VIDEO"
      read -p "Qual ferramenta deseja instalar? " user_choice2
      case $user_choice2 in
        1)
          install_lunarvim
        ;;
        2)
          install_lazygit
        ;;
        3)
          install_node
        ;;
        4)
          install_fonts
        ;;
        5)
          install_drivers
        ;;
        *)
          clear
          figlet A VOLTA DOS QUE NÃO FORAM
          echo "A opção anteior não está disponivel"
          homepage
        ;;
      esac
    ;;
    *)
      echo $goodbye
    ;;
  esac
}

prepage(){
    clear
    figlet A VOLTA DOS QUE NÃO FORAM 
    if [ $? -eq 0 ]; then
      homepage
    else
      echo "Para utilizar essa ferramenta, será necessário atualizar o sistema e baixar um o figlet"
      read -p "Deseja continuar? (s|n)" user_choice
      case $user_choice in
        s|S)
          install_figlet
          prepage
        ;;
        n|S)
          echo $goodbye
        ;;
      esac
    fi
}

prepage
