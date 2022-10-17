// Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location

  tags = var.tags
}

// Create VNETs spoke
module "vnet-spoke" {
    source = "../"

    prefix                = var.prefix
    location              = var.location
    resourcegroup_name    = azurerm_resource_group.rg.name
    tags                  = var.tags
    
    vnet-spoke_cidrs      = var.vnet-spoke_cidrs
}