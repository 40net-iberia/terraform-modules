// Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location

  tags = var.tags
}

/* 
- For this deployment is need it netwok fortigate cluster network intefaces - 
- Deploy module vnet-fgt to optain those - 
- You can use moduel vnet-fgt -

module "vnet-fgt" {
    source =  "../vnet-fgt"

    prefix                = var.prefix
    location              = var.location
    resourcegroup_name    = azurerm_resource_group.rg.name
    
    vnet-fgt_net        = var.vnet-fgt_net
    admin_port          = var.admin_port
    admin_cidr          = var.admin_cidr
}
*/

// Create load balancers
module lb {
  source = "../"

  prefix              = var.prefix
  location            = var.location
  resourcegroup_name  = azurerm_resource_group.rg.name

  backend-probe_port  = var.backend-probe_port
  
  subnet-private = {
    cidr      = module.vnet-fgt.subnet_cidrs["private"]
    id        = module.vnet-fgt.subnet_ids["private"]
    vnet_id   = module.vnet-fgt.vnet_ids["vnet-fgt"]
  }

  fgt-ni_ids = {
    fgt1-public     = module.vnet-fgt.fgt-active-ni_ids["port2"]
    fgt1-private    = module.vnet-fgt.fgt-active-ni_ids["port3"]
    fgt2-public     = module.vnet-fgt.fgt-passive-ni_ids["port2"]
    fgt2-private    = module.vnet-fgt.fgt-passive-ni_ids["port3"]
  }

  fgt-ni_ips = {
    fgt1-public     = module.vnet-fgt.fgt-active-ni_ips["port2"]
    fgt1-private    = module.vnet-fgt.fgt-active-ni_ips["port3"]
    fgt2-public     = module.vnet-fgt.fgt-passive-ni_ips["port2"]
    fgt2-private    = module.vnet-fgt.fgt-passive-ni_ips["port3"]
  }
}


