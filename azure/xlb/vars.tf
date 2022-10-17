// Resource group name
variable "resourcegroup_name" {}

// Azure resourcers prefix description added in name
variable "prefix" {
  type    = string
  default = "terraform"
}

// Azure resourcers tags
variable "tags" {
  type    = map(any)
  default =  {
      deploy = "module-xlb"
  }
}

// Region for deployment
variable "location" {
  type    = string
  default = "francecentral"
}

// Subnet private details
variable "subnet_private" {
  type = map(any)
  default = {
    cidr      = "172.31.3.0/24"
    id        = ""
    vnet_id   = ""
  }
}

// Fortigate cluster interface ids
variable "fgt-ni_ids" {
  type = map(any)
  default = {
    fgt1-public     = ""
    fgt1-private    = ""
    fgt2-public     = ""
    fgt2-private    = ""
  }
}

// Fortigate cluster interface ips
variable "fgt-ni_ips" {
  type = map(any)
  default = {
    fgt1-public     = "172.31.2.10"
    fgt1-private    = "172.31.3.10"
    fgt2-public     = "172.31.2.11"
    fgt2-private    = "172.31.3.11"
  }
}

// Fortigate interface probe port
variable "backend-probe_port" {
  type    = string
  default = "8008"
}