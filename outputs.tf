output "rg_id" {
  description = "The ID of the resource group"
  value       = azurerm_resource_group.george_rg.id
}

output "rg_name" {
  description = "The Name of the resource group"
  value       = azurerm_resource_group.george_rg.name
}

output "azure_vnet_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "azure_vnet_name" {
  description = "The Name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "azure_nsg_id" {
  description = "The ID of the network security group"
  value       = azurerm_network_security_group.george_nsg.id
}

output "azure_nsg_name" {
  description = "The Name of the network security group"
  value       = azurerm_network_security_group.george_nsg.name
}

# Add outputs for other resources as needed


#############################################################

output "azure_subent_id" {
  description = "The ID of the subnets"
  value = {
    for id in keys(var.subnets) : id => azurerm_subnet.george_subnets[id].id
  }
}

output "azure_subnet_name" {
  description = "The Name of the subnets"
  value = {
    for n in keys(var.subnets) : n => azurerm_subnet.george_subnets[n].name
  }
}