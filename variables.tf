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
variable "compartment_id_db" {
  
}



###########################################
#local
###########################################
locals {


  ssh_keys = {
    access = "./files/shrar.pub"
  }

  tags = {
   
    "Billing.CostCentre"         = ""
   
  }

}
######NSG-DB########
#DB1
variable "nsg1_db" {}
variable "nsg2_db" {}
variable "nsg3_db" {}
locals {

nsg_db1 = flatten( [ var.nsg1_db,var.nsg2_db, var.nsg3_db] )

}
#DB2

variable "nsg1_db2" {}
variable "nsg2_db2" {}
variable "nsg3_db2" {}
locals {

nsg_db2 = flatten( [ var.nsg1_db2,var.nsg2_db2, var.nsg3_db2] )

}

variable "db_shapes" {}
variable "db_shape_ocpus" { }
variable "db_shape_mem" { }
variable "data_storage_size_in_gb" { }


#SSH Keys
####################################
variable "ssh_key_db" {}