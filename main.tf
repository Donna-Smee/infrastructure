# Configure the Terraform runtime requirements.
terraform {
  required_version = ">= 1.1.0"

  required_providers {
    # Azure Resource Manager provider and version
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "2.3.3"
    }
  }

}

# Define providers and their config params
provider "azurerm" {
  features {}
}

provider "cloudinit" {
  # Configuration options
}

variable "region" {
  type        = string
  default     = "Canada Central"
  description = "The region that the resources will be in"
}

resource "azurerm_resource_group" "rg" {
  name     = "CST8918-Lab9-RG"
  location = var.region
}

resource "azurerm_storage_account" "storage-acc" {
  name                     = "storage-acc-ha000070"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}