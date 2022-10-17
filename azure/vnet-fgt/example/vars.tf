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

// CIDR range for VNET Fortigate - Security VNET
variable "vnet-fgt_cidr" {
  default = "172.30.0.0/20"
}

// HTTPS Port
variable "admin_port" {
  type    = string
  default = "8443"
}

variable "admin_cidr" {
  type    = string
  default = "0.0.0.0/0"
}









