// Update this variable if you now parameters to connect to another HUB
variable "hub-peer" {
  type = map(any)
  default = {
    "bgp-asn"        = "65002"
    "public-ip1"     = "22.22.22.22"
    "vxlan-ip1"      = "10.10.30.253"
  }
}

// Update this variable if you now parameters for this HUB
variable "hub" {
  type = map(any)
  default = {
    "id"             = "HubAazure"
    "bgp-asn"        = "65001"
    "bgp-id"         = "10.10.10.254"
    "vxlan-ip1"      = "10.10.30.254"
    "advpn-net"      = "10.10.10.0/24"
  }
}

variable "spokes-onprem-cidr" {
  default = "192.168.0.0/16"
}

variable "sites-bgp-asn" {
  type    = string
  default = "65011"
}

// ADVPN PSK IPSEC 
variable "advpn-ipsec-psk" {
  default = "sample-password"
}

// S2S PSK IPSEC 
variable "s2s-ipsec-psk" {
  default = "sample-password"
}