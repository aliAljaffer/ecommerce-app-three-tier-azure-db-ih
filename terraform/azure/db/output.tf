output "db_server" {
  value = azurerm_mssql_server.db_server.fully_qualified_domain_name
}

output "db_user" {
  value = azurerm_mssql_server.db_server.administrator_login
}

output "db_password" {
  value = azurerm_mssql_server.db_server.administrator_login_password
}
output "db_name" {
  value = azurerm_mssql_database.db.name
}

