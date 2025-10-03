terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.46.0"
    }
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

