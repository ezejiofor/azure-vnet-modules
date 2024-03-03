locals {
  name_prefix      = "george"
  project          = "aks"
  name_suffix      = "vnet"
  environment      = "dev"
  private_key_path = "/mnt/c/Users/OEZEJIOF/Documents/devops/repos/GEORGE-POC/george-aks-demo/ssh-keys/demokey.pem"
}

data "azurerm_subscription" "primary" {}

data "azurerm_client_config" "current" {}

resource "random_string" "main" {
  length  = 8
  upper   = false
  special = false
}

#data "azurerm_resource_group" "aks_rg" {
#  name = var.backend_resource_group_name
#}

################################################################################################################
##  AKS PROJECT RESOURCE GROUP
################################################################################################################

resource "azurerm_resource_group" "george_rg" {
  location = var.location
  name     = var.resource_group_name
}



