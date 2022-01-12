############################################################################
# Variables:
############################################################################

############################################################################
# Tenancy:
############################################################################

variable "tenancy_ocid" {}
#variable "user_ocid" {}
#variable "fingerprint" {}
#variable "private_key_path" {}
variable "region" {}
variable "customer_label" {}
variable "compartment_id" {}
variable "subnet_id" {}
variable "vcn" {}




###########################################
#VPN
###########################################
locals {


  ssh_keys = {
    access = "./files/shrar.pub"
  }

v1_vpns = ["${var.v1_cl_vpn}","${var.v1_cw_vpn}"]
cust_vpns = ["${var.cust1_vpn}","${var.cust2_vpn}"]
v1_domains = flatten([var.v1_cl_domain, var.v1_cw_domain])
cust_domains = flatten([var.cust1_domain, var.cust2_domain])

}

variable "v1_cl_vpn" {}
variable "v1_cw_vpn" {}


variable "cust1_vpn" {}
variable "cust2_vpn" {}

variable "v1_cl_domain" {
  type        = list(string)
  description = "List of on-premises CIDR blocks allowed to connect to the Landing Zone network via a DRG."
  default     = []
}
variable "v1_cw_domain" {
  type        = list(string)
  description = "List of on-premises CIDR blocks allowed to connect to the Landing Zone network via a DRG."
  default     = []
}

variable "cust1_domain" {
  type        = list(string)
  description = "List of on-premises CIDR blocks allowed to connect to the Landing Zone network via a DRG."
  default     = []
}
variable "cust2_domain" {
  type        = list(string)
  description = "List of on-premises CIDR blocks allowed to connect to the Landing Zone network via a DRG."
  default     = []
}

variable "access" {

  type        = list(string)
  description = "List of access IPs allowed to connect "
  default     = []

}
