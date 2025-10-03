variable "rg_location" {
  type        = string
  description = "Resource group location"
}
variable "rg_name" {
  type        = string
  description = "Resource group name"
}
variable "be_subnet_id" {
  type        = string
  description = "backend subnet id"
}
variable "fe_subnet_id" {
  type        = string
  description = "frontend subnet id"
}
variable "vnet_name" {
  type        = string
  description = "VNet Name"
}
variable "vnet_id" {
  type        = string
  description = "VNet id"
}
variable "my_name" {
  type = string
}
