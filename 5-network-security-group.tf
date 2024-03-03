# Define your NSG rules as before

# Transforming list of objects into a map
locals {
  nsg_rules_map = { for rule in var.nsg_rules : rule.name => rule }
}

# Define your subnets, assuming you have a list of subnet objects

resource "azurerm_network_security_group" "george_nsg" {
  location            = var.location
  name                = "${local.name_prefix}-${random_string.main.result}-nsg"
  resource_group_name = azurerm_resource_group.george_rg.name

  dynamic "security_rule" {
    for_each = local.nsg_rules_map
    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  }


  tags = {
    environment = "${local.environment}"
  }

}

