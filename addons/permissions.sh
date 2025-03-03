#!/bin/bash

user=$(whoami)

add_docker_group(){
  sudo usermod -a -G docker $user
}
