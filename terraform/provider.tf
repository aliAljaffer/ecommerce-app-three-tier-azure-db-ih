terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.46.0"
    }
  }
  backend "azurerm" {
    container_name       = "terraformstate"
    storage_account_name = "w5d6storageacc"
    resource_group_name  = "devops-ali-storage"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  # Configuration options
  subscription_id = var.subscription_id
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

