
resource "azurerm_subnet" "george_subnets" {
  for_each             = var.subnets
  resource_group_name  = azurerm_resource_group.george_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  name                 = each.value["name"]
  address_prefixes     = each.value["address_prefixes"]
}
