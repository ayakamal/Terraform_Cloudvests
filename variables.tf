variable "cidr" {
  type = string
}

variable "my_private_key" {
  default = "mykey"
}

variable "my_public_key" {
  default = "mykey.pub"
}

variable "public_subnet_1_cidr" {
  type = string
}

variable "public_subnet_2_cidr" {
  type = string
}

variable "private_subnet_1_cidr" {
  type = string
}

variable "private_subnet_2_cidr" {
  type = string
}

variable "password" {
  type = string
}

# variable "env" {
#   type = string
# }