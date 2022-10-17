###################################################################################
# - IMPORTANT - Update this variables with outputs from module ../routeserver
###################################################################################

// Update this variable if you have deployed RouteServers
// -> module "github.com/jmvigueras/modules/azure/routeserver`
variable "rs-spoke" {
  type = map(any)
  default = {
    rs1_ip1          = "172.30.17.132"
    rs1_ip2          = "172.30.17.133"
    rs1_bgp-asn      = "65515"
    rs2_ip1          = "172.30.19.132"
    rs2_ip2          = "172.30.19.133"
    rs2_bgp-asn      = "65515"
  }
}