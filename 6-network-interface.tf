
# Define public IPs for each subnet that requires one
resource "azurerm_public_ip" "george_public_ip" {
  for_each            = var.subnets
  name                = "${local.name_prefix}${local.project}-${each.key}-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.george_rg.name
  allocation_method   = each.value.has_public_ip ? "Static" : "Dynamic"
}


# Create network interface for each subnet
resource "azurerm_network_interface" "george_nic" {
  for_each            = var.subnets
  name                = "${local.name_prefix}${local.project}-${each.key}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.george_rg.name

  ip_configuration {
    name                          = "${local.name_prefix}${local.project}-${each.key}-NicConfiguration"
    subnet_id                     = azurerm_subnet.george_subnets[each.key].id
    private_ip_address_allocation = "Dynamic"
    # Assign public IP if has_public_ip is true, otherwise, do not assign a public IP
    public_ip_address_id = each.value.has_public_ip ? azurerm_public_ip.george_public_ip[each.key].id : null
  }

  tags = {
    environment = local.environment
  }

  depends_on = [azurerm_virtual_network.vnet]
}


# Connect the security group to each network interface
# Associate NSG with subnets
resource "azurerm_network_interface_security_group_association" "aks_association" {
  for_each                  = azurerm_network_interface.george_nic
  network_interface_id      = each.value.id
  network_security_group_id = azurerm_network_security_group.george_nsg.id
}
