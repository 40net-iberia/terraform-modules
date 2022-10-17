###################################################################################
# - IMPORTANT - Update this variables with outputs from module ../vnet-spoke
###################################################################################

// Update this variable if you have deployed vnet-fgt
// -> module "github.com/jmvigueras/modules/azure/vnet-spoke`
variable "spoke-subnet_cidrs"{
  type = map(any)
  default = {
    spoke-1_subnet1 = "172.30.16.0/25"
    spoke-1_subnet2 = "172.30.17.0/25"
    spoke-1_subnet1 = "172.30.18.0/25"
    spoke-1_subnet2 = "172.30.19.0/25"
  }
}

variable "spoke-vnet_cidrs"{
  type = map(any)
  default = {
    spoke-1    = "172.30.16.0/23"
    spoke-2    = "172.30.18.0/23"
  }
}
