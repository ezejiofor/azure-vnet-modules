resource "azurerm_route_table" "george_rt" {
  location            = var.location
  name                = "${local.name_prefix}-${random_string.main.result}-rt"
  resource_group_name = azurerm_resource_group.george_rg.name
}

resource "azurerm_subnet_route_table_association" "vnet" {
  for_each = var.route_tables_ids

  route_table_id = each.value
  subnet_id      = azurerm_subnet.george_subnets[each.key].id
}