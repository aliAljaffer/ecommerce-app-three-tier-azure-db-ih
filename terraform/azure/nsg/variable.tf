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
