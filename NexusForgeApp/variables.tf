variable "hostname" {
  default = "testing-server"
}

variable "username" {
  default = "devops"
}

variable "ssh_key_path" {
  default = "id_rsa.pub"
  type    = string
}

variable "tailscale_auth_key" {
  default = ""
  type    = string
}