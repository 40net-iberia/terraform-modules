// Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location

  tags = var.tags
}

// Deploy VNET, Subnets, Interfaces and NSG for Fortigate cluster
module "vnet-fgt" {
    source =  "../"

    prefix                = var.prefix
    location              = var.location
    resourcegroup_name    = azurerm_resource_group.rg.name
    
    vnet-fgt_net          = var.vnet-fgt_net
    admin_port            = var.admin_port
    admin_cidr            = var.admin_cidr
}