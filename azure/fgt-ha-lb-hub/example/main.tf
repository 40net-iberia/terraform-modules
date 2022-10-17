// Create FGT cluster in region A (HUB1)
module "fgt-ha" {
    source = "./modules/fgt-ha"

    prefix           = var.prefix
    location         = var.location

    subscription_id  = var.fgt-subscription_id
    client_id        = var.fgt-client_id
    client_secret    = var.fgt-client_secret
    tenant_id        = var.fgt-tenant_id

    resourcegroup_name       = azurerm_resource_group.rg.name
    storage-account_endpoint = azurerm_storage_account.fgtstorageaccount.primary_blob_endpoint

    hub       = var.hub
    hub-peer  = var.hub-peer
    
    sites_bgp-asn         = var.sites_bgp-asn
    advpn-ipsec-psk       = random_id.advpn-psk-key.hex
    adminusername         = var.adminusername
    adminpassword         = var.adminpassword
    admin_port            = var.admin_port
    admin_cidr            = var.admin_cidr
    
    fgt-subnet_cidrs      = module.vnet-fgt.subnet_cidrs
    fgt-active-ni_ids     = [
      module.vnet-fgt.fgt-active-ni_ids["port1"],
      module.vnet-fgt.fgt-active-ni_ids["port2"],
      module.vnet-fgt.fgt-active-ni_ids["port3"]
    ]
    fgt-passive-ni_ids    = [
      module.vnet-fgt.fgt-passive-ni_ids["port1"],
      module.vnet-fgt.fgt-passive-ni_ids["port2"],
      module.vnet-fgt.fgt-passive-ni_ids["port3"]
    ]
    fgt-ni-nsg_ids        = [
      module.vnet-fgt.nsg_ids["mgmt"], 
      module.vnet-fgt.nsg_ids["public"],
      module.vnet-fgt.nsg_ids["private"]
    ] 
    rs-spoke              = {
      rs1_ip1          = tolist(module.rs-spoke-1.rs_ips)[0]
      rs1_ip2          = tolist(module.rs-spoke-1.rs_ips)[1]
      rs1_bgp-asn      = "65515"
      rs2_ip1          = tolist(module.rs-spoke-2.rs_ips)[0]
      rs2_ip2          = tolist(module.rs-spoke-2.rs_ips)[1]
      rs2_bgp-asn      = "65515"
    }

    gwlb_ip             = cidrhost(module.vnet-fgt.subnet_cidrs["private"],15)

    spoke-vnet_cidrs     = module.vnet-spoke.vnet_cidrs
    spoke-subnet_cidrs   = module.vnet-spoke.subnet_cidrs

    fgt-active-ni_names   = module.vnet-fgt.fgt-active-ni_names
    fgt-passive-ni_names  = module.vnet-fgt.fgt-passive-ni_names

    cluster-public-ip_name    = module.vnet-fgt.cluster-public-ip_name
}