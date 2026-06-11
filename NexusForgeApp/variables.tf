variable "hostname" {
  default = "testing-server"
}

variable "username" {
  default = "devops"
}

variable "address" {
  default = "localhost"
  type    = string
}

variable "ssh_key_path" {
  default = "id_rsa.pub"
  type    = string
}