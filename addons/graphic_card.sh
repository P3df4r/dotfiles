#!/bin/bash

declare -A distro_commands
distro_commands["opensuse-leap"]="zypper"
distro_commands["ubuntu"]="apt"
distro_commands["fedora"]="dnf"

declare -A models
models["1"]="G03"
models["2"]="G04"
models["3"]="G05"
models["4"]="G06"

distros=("opensuse-leap" "ubuntu" "fedora")
modelos=("1","2","3","4")

install_drivers(){

  echo "1 - G03 = driver 340.xxx para as GeForce GT (antigo, não recomendado)"
  echo "2 - G04 = driver 390.xxx para GTX4xx/5xx/6xx (antigo, não recomendado)"
  echo "3 - G05 = driver 470.xxx para GTX6xx até RTX20xx"
  echo "4 - G06 = driver 525.xxx mais recente a partir da GTX750 e demais TITAN, Quadro, RTX, GTX, MX."
  read -p "Sua placa de vídeo se enquadra em qual opção? " user_choice
  for i in $distros; do
    if grep -q "^ID=\"$i\"" /etc/os-release; then
      for command in "${!distro_commands}"; do
        if [ ${distro_commands["$i"]} == "zypper" ]; then
          sudo ${distro_commands["$i"]} in nvidia-video-${models["$user_choice"]} nvidia-compute-utils-${models["$user_choice"]} nvidia-gl-${models["$user_choice"]}
          sudo ${distro_commands["$i"]} in suse-prime
          sudo prime-select nvidia
        fi
      done
    fi
  done
}
