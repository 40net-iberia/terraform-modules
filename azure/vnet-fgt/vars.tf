// Azure resourcers group
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

// CIDR range for VNET Fortigate - Security VNET
variable "vnet-fgt_cidr" {
  default = "172.30.0.0/20"
}

// enable accelerate network, either true or false, default is false
// Make the the instance choosed supports accelerated networking.
// Check: https://docs.microsoft.com/en-us/azure/virtual-network/accelerated-networking-overview#supported-vm-instances
variable "accelerate" {
  default = "false"
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






