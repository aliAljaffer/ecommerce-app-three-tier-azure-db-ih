variable "subscription_id" {
  type        = string
  description = "Subscription ID"
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
