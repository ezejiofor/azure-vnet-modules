resource "azurerm_virtual_network" "vnet" {
  address_space       = var.vnet_address_space
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.george_rg.name
  location            = azurerm_resource_group.george_rg.location
  dns_servers         = var.dns_servers
  tags                = var.tags


}