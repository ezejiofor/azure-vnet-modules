
#################################################################################
##  connection variables
#################################################################################

variable "client_secret" {
  description = "george-demo-test-spn client_secret"
  type        = string
  default     = ""
}

variable "client_id" {
  description = "george-demo-test-spn client_id"
  type        = string
  default     = ""
}

variable "subscription_id" {
  description = "subscription_id"
  type        = string
  default     = ""
}

variable "tenant_id" {
  description = "george-demo-test-spn tenant_id"
  type        = string
  default     = ""
}

#################################################################################
##  common variables
#################################################################################

variable "location" {
  type        = string
  description = "The location/region where the resource group. Changing this forces a new resource to be created. We will create the vnet and subnets in the same location/region where the resource group is."
  default     = "uksouth"
}

# Azure AKS Environment Name
variable "environment" {
  type        = string
  description = "This variable defines the Environment"
  default     = "dev"
}

variable "storage_account" {
  type        = string
  description = "This variable defines the storage account"
  default     = "georgeakssa"
}

variable "resource_group_name" {
  type        = string
  description = "This variable defines the resource group"
  default     = "george-aks-project-uksouth-rg"
}


#################################################################################
##  vnet variables
#################################################################################
variable "vnet_name" {
  type        = string
  description = "The name of the virtual network. Changing this forces a new resource to be created."
  default     = "georgevnet"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "The address space that is used the virtual network. You can supply more than one address space but for our module implementation we are limiting it to 1 address space only."
  default     = ["10.13.0.0/16"]
}


# Subnet Variables (map)
variable "subnets" {
  description = "Subnet Variables (map)"
  type        = map(any)
  default = {
    aks_subnet = {
      name             = "george-aks-subnet"
      address_prefixes = ["10.13.1.0/24"]
      has_public_ip    = false # Set to false for private subnet
    }

    db_subnet = {
      name             = "george-db-subnet"
      address_prefixes = ["10.13.2.0/24"]
      has_public_ip    = false # Set to false for private subnet
    }

    bastion_subnet = {
      name             = "george-bastion-subnet"
      address_prefixes = ["10.13.3.0/24"]
      has_public_ip    = true # Set to true for subnet with public IP
    }
  }
}


# Network security group rules
variable "nsg_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "The values for each NSG rule "
}



variable "service_endpoints" {
  type        = list(string)
  description = "The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage, Microsoft.Storage.Global and Microsoft.Web."
  default     = []
}





#=====================================================================================================================






variable "route_tables_ids" {
  type        = map(string)
  default     = {}
  description = "A map of subnet name to Route table ids"
}

variable "subnet_service_endpoints" {
  type        = map(any)
  default     = {}
  description = "A map of subnet name to service endpoints to add to the subnet."
}

# If no values specified, this defaults to Azure DNS
variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "The DNS servers to be used with vNet."
}

variable "tags" {
  type = map(string)
  default = {
    Name        = "george-vnet"
    environment = "dev"
  }
  description = "The tags to associate with your network and subnets."
}