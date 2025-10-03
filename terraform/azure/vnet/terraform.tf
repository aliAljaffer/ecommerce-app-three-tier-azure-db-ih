resource "azurerm_virtual_network" "main_vnet" {
  name                = "${var.my_name}-vnet"
  location            = var.rg_location
  resource_group_name = var.rg_name
  address_space       = ["10.10.0.0/16"]

}

locals {
  subnets = {
    frontend_subnet = "10.10.1.0/24"
    backend_subnet  = "10.10.2.0/24"
  }
}

resource "azurerm_subnet" "frontend_subnet" {
  name                 = "fe-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = ["10.10.1.0/24"]
  # VNET delegation
  delegation {
    name = "Microsoft.Web.serverFarms"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
resource "azurerm_subnet" "backend_subnet" {
  name                 = "be-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = ["10.10.2.0/24"]
  # VNET delegation
  delegation {
    name = "Microsoft.Web.serverFarms"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

# resource "azurerm_subnet" "subnets" {
#   for_each             = local.subnets
#   name                 = each.key
#   resource_group_name  = var.rg_name
#   virtual_network_name = azurerm_virtual_network.main_vnet.name
#   address_prefixes     = [each.value]
# }

