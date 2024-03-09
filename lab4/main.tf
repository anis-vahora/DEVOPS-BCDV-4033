terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = false
}

resource "docker_network" "bridge" {
  name = "my_bridge_network"
}


resource "docker_container" "nginx" {

  image = docker_image.nginx.image_id


  network_mode = docker_network.bridge.name

  name  = "tutorials"

  ports {
    internal = 80
    external = 8001
  }

  depends_on = [docker_image.nginx, docker_network.bridge]
}