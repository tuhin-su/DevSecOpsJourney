resource "incus_instance" "alpine_vm" {
  remote = "cloud-one"

  name = var.hostname
  type = "virtual-machine"

  image = "images:debian/13/cloud"

  config = {
    "limits.cpu"    = "1"
    "limits.memory" = "500MiB"
    "security.secureboot" = false

    "user.user-data" = templatefile(
      "${path.module}/cloud-init.tpl",
      {
        hostname = var.hostname
        username = var.username
        ssh_key  = file(var.ssh_key_path)
        tailscale_auth_key = var.tailscale_auth_key
      }
    )
  }

  device {
    name = "root"
    type = "disk"

    properties = {
      pool = "default"
      path = "/"
      size = "10GiB"
    }
  }
}