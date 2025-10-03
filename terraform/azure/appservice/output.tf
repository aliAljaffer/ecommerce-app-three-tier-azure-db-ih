output "links" {
  value = [for link in [azurerm_linux_web_app.fe_app.default_hostname, azurerm_linux_web_app.be_app.default_hostname] : link]
}
