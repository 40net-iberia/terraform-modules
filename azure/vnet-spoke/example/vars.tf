// Resource group name
variable "resourcegroup_name" {}

// Azure resourcers prefix description added in name
variable "prefix" {
  type    = string
  default = "module-vnet-spoke"
}

// Azure resourcers tags
variable "tags" {
  type    = map(any)
  default =  {
      deploy = "module-vnet-spoke"
  }
}

// Region for deployment
variable "location" {
  type    = string
  default = "francecentral"
}

// List of CIDR ranges for vnets spoke (it will create as much VNET as ranges)
variable "vnet-spoke_cidrs" {
  type    = list(string)
  default = [
    "172.30.16.0/23",
    "172.30.18.0/23"
  ]
}








