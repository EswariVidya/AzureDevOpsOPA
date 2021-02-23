provider "azurerm" {
    version = "~>2.13.0"
    subscription_id = var.subscription_id
    tenant_id = var.tenant_id
    client_id = var.client_id
    client_secret = var.client_secret
    features{}
}

terraform {
    backend "azurerm" {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
    name = "devSecOpsrg"
    location = "west us"
} 
resource "azurerm_network_security_group" "nsg" {
    name = "myTFNSG"
    location = "west europe"
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name = "SSH"
        priority = 1001
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "22"
        source_address_prefix = "*"
        destination_address_prefix = "*"

    }
}