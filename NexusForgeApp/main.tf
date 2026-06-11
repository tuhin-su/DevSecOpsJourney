resource "incus_instance" "alpine_vm" {
  remote = "cloud-one"

  name = var.hostname
  type = "virtual-machine"

  image = "images:alpine/3.22/cloud"

  config = {
    "limits.cpu"    = "1"
    "limits.memory" = "500MiB"

    "user.user-data" = templatefile(
      "${path.module}/cloud-init.tpl",
      {
        hostname = var.hostname
        username = var.username
        ssh_key  = file(var.ssh_key_path)
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