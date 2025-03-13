#!/bin/bash

declare -A distro_commands
distro_commands["opensuse-leap"]="zypper"
distro_commands["ubuntu"]="apt"
distro_commands["fedora"]="dnf"

distros=("opensuse-leap" "ubuntu" "fedora")
model="G06"

install_drivers(){

   for i in $distros; do
    if grep -q "^ID=\"$i\"" /etc/os-release; then
      for command in "${!distro_commands}"; do
        if [ ${distro_commands["$i"]} == "zypper" ]; then
          sudo ${distro_commands["$i"]} in nvidia-video-${model} nvidia-compute-utils-${model} nvidia-gl-${model}
        fi
      done
    fi
  done

}
