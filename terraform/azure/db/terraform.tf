resource "azurerm_mssql_server" "db_server" {
  name                          = "${var.my_name}-sqlserver"
  resource_group_name           = var.rg_name
  location                      = var.rg_location
  version                       = "12.0"
  administrator_login           = var.my_name
  administrator_login_password  = "4-v3ry-53cr37-p455w0rd"
  public_network_access_enabled = true
}

resource "azurerm_mssql_database" "db" {
  name                        = "${var.my_name}-db"
  server_id                   = azurerm_mssql_server.db_server.id
  collation                   = "SQL_Latin1_General_CP1_CI_AS"
  auto_pause_delay_in_minutes = 60
  sku_name                    = "S0"
  enclave_type                = "VBS"
}
resource "azurerm_private_endpoint" "pe_db" {
  name                = "pe-endpoint"
  location            = var.rg_location
  resource_group_name = var.rg_name
  subnet_id           = azurerm_subnet.pe_subnet.id

  private_service_connection {
    name                           = "server-privateserviceconnection"
    private_connection_resource_id = azurerm_mssql_server.db_server.id
    is_manual_connection           = false
    subresource_names              = ["SqlServer"]
  }

  private_dns_zone_group {
    name                 = "sql-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.example.id]
  }

}

resource "azurerm_subnet" "pe_subnet" {
  name                              = "pe-subnet"
  resource_group_name               = var.rg_name
  virtual_network_name              = var.vnet_name
  address_prefixes                  = ["10.10.10.0/24"] # 0 - 255
  service_endpoints                 = ["Microsoft.Web"]
  private_endpoint_network_policies = "Enabled"
}

resource "azurerm_private_dns_zone" "example" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "example-link"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.example.name
  virtual_network_id    = var.vnet_id
}
