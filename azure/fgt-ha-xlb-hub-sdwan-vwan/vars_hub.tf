###################################################################################
# - IMPORATANT - Add this variables when call the module with your designed data
###################################################################################
variable "hub" {
  type = map(any)
  default = {
    "id"             = "HubAazure"
    "bgp-asn"        = "65001"
    "advpn-net"      = "10.10.10.0/24"
  }
}

// CIDR range for VNET FGT
// - (Recomended range /20)
variable "vnet-fgt_cidr" {
  type    = string
  default = "172.30.0.0/20"
}

// CIDR range for VNET sites (simulated on-premise sites)
variable "spoke_cidr_site" {
  type    = string
  default = "192.168.0.0/16"
}

variable "spoke_bgp-asn" {
  type    = string
  default = "65011"
}

// CIDR range for VNET spoke in Azure
variable "spoke_cidr_vnet" {
  type    = string
  default = "172.16.0.0/12"
}