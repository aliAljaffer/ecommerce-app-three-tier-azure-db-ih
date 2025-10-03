variable "rg_location" {
  type        = string
  description = "Resource group location"
}
variable "rg_name" {
  type        = string
  description = "Resource group name"
}
variable "my_name" {
  type = string
}

variable "db_name" {
  type = string
}
variable "db_user" {
  type = string
}
variable "db_server" {
  type = string
}
variable "db_password" {
  type = string
}

variable "fe_subnet_id" {
  type = string
}
variable "be_subnet_id" {
  type = string
}

variable "fe_image_name" {
  type = string
}

variable "be_image_name" {
  type = string
}

variable "fe_image_tag" {
  type    = string
  default = "latest"
}
variable "be_image_tag" {
  type    = string
  default = "latest"
}
