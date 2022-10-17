######################################################################
## Create VNETs
######################################################################
// Create VNETs 
resource "azurerm_virtual_network" "vnet-spoke" {
  count               = length(var.vnet-spoke_cidrs)
  name                = "${var.prefix}-vnet-spoke-${count.index}"
  address_space       = [var.vnet-spoke_cidr[count.index]]
  location            = var.location
  resource_group_name = var.resourcegroup_name

  tags                 = var.tags
}

// Create standar subnets in each VNET
resource "azurerm_subnet" "vnet-spoke_subnet-1" {
  count                = length(var.vnet-spoke_cidrs)  
  name                 = "${azurerm_virtual_network.vnet-spoke[count.index].name}-subnet-${count.index}"
  resource_group_name  = var.resourcegroup_name
  virtual_network_name = azurerm_virtual_network.vnet-spoke[count.index].name
  address_prefixes     = [cidrsubnet(var.vnet-spoke_cidr[count.index],2,0)]
}

resource "azurerm_subnet" "vnet-spoke_subnet-2" {
  count                = length(var.vnet-spoke_cidrs)
  name                 = "${azurerm_virtual_network.vnet-spoke[count.index].name}-subnet-${count.index}"
  resource_group_name  = var.resourcegroup_name
  virtual_network_name = azurerm_virtual_network.vnet-spoke[count.index].name
  address_prefixes     = [cidrsubnet(var.vnet-spoke_cidr[count.index],2,2)]
}

resource "azurerm_subnet" "vnet-spoke_subnet_routeserver" {
  count                = length(var.vnet-spoke_cidrs)
  name                 = "RouteServerSubnet"
  resource_group_name  = var.resourcegroup_name
  virtual_network_name = azurerm_virtual_network.vnet-spoke[count.index].name
  address_prefixes     = [cidrsubnet(var.vnet-spoke_cidr[count.index],4,12)]
}

resource "azurerm_subnet" "vnet-spoke_subnet_vgw" {
  count                = length(var.vnet-spoke_cidrs)
  name                 = "GatewaySubnet"
  resource_group_name  = var.resourcegroup_name
  virtual_network_name = azurerm_virtual_network.vnet-spoke[count.index].name
  address_prefixes     = [cidrsubnet(var.vnet-spoke_cidr[count.index],4,13)]
}

resource "azurerm_subnet" "vnet-spoke_subnet_pl" {
  count                = length(var.vnet-spoke_cidrs)
  name                 = "PrivateLinkSubnet"
  resource_group_name  = var.resourcegroup_name
  virtual_network_name = azurerm_virtual_network.vnet-spoke[count.index].name
  address_prefixes     = [cidrsubnet(var.vnet-spoke_cidr[count.index],4,14)]

  private_endpoint_network_policies_enabled = true
}

resource "azurerm_subnet" "vnet-spoke_subnet_pl-s" {
  count                = length(var.vnet-spoke_cidrs)
  name                 = "PrivateLinkServicesSubnet"
  resource_group_name  = var.resourcegroup_name
  virtual_network_name = azurerm_virtual_network.vnet-spoke[count.index].name
  address_prefixes     = [cidrsubnet(var.vnet-spoke_cidr[count.index],4,15)]

  private_link_service_network_policies_enabled = true
}


######################################################################
## Create Network Interfaces in subnet 1 y 2 for test VM
######################################################################
// Network Interface VM Test Spoke-1 subnet 1
resource "azurerm_network_interface" "ni_subnet-1" {
  count                         = length(var.vnet-spoke_cidrs)
  name                          = "${azurerm_subnet.vnet-spoke_subnet-1[count.index].name}-ni-${count.index}"
  location                      = var.location
  resource_group_name           = var.resourcegroup_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.vnet-spoke_subnet-1[count.index].id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(azurerm_subnet.vnet-spoke_subnet-1[count.index].address_prefixes[0],10)
    primary                       = true
  }

  tags  = var.tags
}

// Network Interface VM Test Spoke-1 subnet 2
resource "azurerm_network_interface" "ni_subnet-2" {
  count                         = length(var.vnet-spoke_cidrs)
  name                          = "${azurerm_subnet.vnet-spoke_subnet-2[count.index].name}-ni-${count.index}"
  location                      = var.location
  resource_group_name           = var.resourcegroup_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.vnet-spoke_subnet-2[count.index].id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(azurerm_subnet.vnet-spoke_subnet-2[count.index].address_prefixes[0],10)
    primary                       = true
  }

  tags  = var.tags
}