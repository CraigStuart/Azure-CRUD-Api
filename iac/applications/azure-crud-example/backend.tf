terraform {
    required_version = ">= 1.3.0"

    backend "azurerm" {
      resource_group_name  = "StorageAccount-ResourceGroup"
      storage_account_name = "terraformbackendsan"
      container_name       = "tfstate"
      key                  = "dev.terraform.tfstate"
    }

    required_providers {
      azurerm = {
        source  = "hashicorp/azurerm"
        version = "~>3.0"
      }
    }

    provider "azurerm" {
      features {}
    }

}
