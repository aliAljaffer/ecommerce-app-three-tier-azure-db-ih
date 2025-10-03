resource "azurerm_resource_group" "main_rg" {
  name     = "${var.my_name}-rg"
  location = "West US 2"
}
