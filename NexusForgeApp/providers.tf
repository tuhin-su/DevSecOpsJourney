terraform {
  required_providers {
    incus = {
      source  = "lxc/incus"
      version = "~> 0.4"
    }
  }
}

provider "incus" {
  remote {
    name    = "cloud-one"
    address = "${var.address}"
  }
}