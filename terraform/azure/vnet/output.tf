output "be_subnet_id" {
  value = azurerm_subnet.backend_subnet.id
}
output "fe_subnet_id" {
  value = azurerm_subnet.frontend_subnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.main_vnet.name
}
output "vnet_id" {
  value = azurerm_virtual_network.main_vnet.id
}
