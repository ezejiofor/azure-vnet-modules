terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.91.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.3.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.25.2"
    }

  }


  # Terraform State Storage to Azure Storage Container
  backend "azurerm" {
    resource_group_name  = "george-aks-rg"
    storage_account_name = "georgeakssa"
    container_name       = "georgeakstfstatefiles"
    key                  = "george-aks.tfstate"
  }


}


provider "azurerm" {
  features {
    #    resource_group {
    #      prevent_deletion_if_contains_resources = false
    #    }
    #    key_vault {
    #      purge_soft_delete_on_destroy    = true
    #      recover_soft_deleted_key_vaults = true
    #    }
  }

  client_secret   = var.client_secret
  client_id       = var.client_id
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}
