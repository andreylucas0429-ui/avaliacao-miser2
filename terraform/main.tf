terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "andrey" {
  name = "andrey"
}

resource "docker_image" "nginx" {
  name = "nginx:alpine"
}

resource "docker_container" "andrey" {
  name  = "andrey"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8082
  }

  networks_advanced {
    name = docker_network.andrey.name
  }
}
