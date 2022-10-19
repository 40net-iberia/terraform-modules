##############################################################################################################
# - IMPORTANT - 
# - UPDATE - fix variables with you group member and user
##############################################################################################################

// IMPORTANT: UPDATE Owner with your AWS IAM user name
variable "tags" {
  description = "Attribute for tag Enviroment"
  type = map(any)
  default     = {
   Name    = "hub-xs22"
   Project = "xs22"
  }
}

// Region and Availability Zone where deploy VPC and Subnets
variable "region" {
  type = map(any)
  default = {
    "region"     = "eu-central-1"
    "region_az1" = "eu-central-1a"
  }
}

// CIDR range Golden VPC
variable "vpc-hub_cidr" {
  default = "10.10.10.0/24"
}

// Details about central HUB (golden VPC)
variable "vpc-hub_advpn" {
  type = map(any)
  default = {
    "local_bgp-asn"  = "65001"          // BGP ASN HUB central (golden VPC)
    "spoke_bgp-asn"  = "65011"          // BGP configured in sites
    "advpn_net"      = "10.10.20.0/24"  // Internal CIDR range for ADVPN tunnels private<
  }
}


##############################################################################################################
# This variables can remain by default

variable "admin_cidr" {
  default = "0.0.0.0/0"
}

variable "admin_port" {
  default = "8443"
}

