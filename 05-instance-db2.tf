############################################################################
# DB System:
#############################################################################
/*
module "db-system-db2" {
  source                         = "./modules/db-system"
  availability_domain            = lookup(data.oci_identity_availability_domains.ads.availability_domains[1],"name")
  compartment_id                 = data.terraform_remote_state.common_services.outputs.nprd_services_compartment_id
  subnet_id                      = data.terraform_remote_state.common_services.outputs.sub_db_id
  db_edition                     = "ENTERPRISE_EDITION_HIGH_PERFORMANCE"
  character_set                  = "UTF8"
  db_workload                    = "OLTP"
  db_ncharacter_set              = "AL16UTF16"
  db_name                        = "CDBDEV"
  pdb_name                       = "DEV"
  db_version                     = "19.11.0.0"
  db_shape                       = "VM.Standard2.2"
  ssh_public_keys                = file(local.ssh_keys["access"])
  data_storage_size_in_gb        = "512"
  hostname                       = "GMPDEVDB"
  display_name                   = "GMPDEVDB"
  defined_tags                   = local.tags
  network_sec_groups             = local.nsg_db
  create_data_guard              = false
}

############################################################################
*/

module "instance_test_db2" {
  source                  = "./modules/core_instance"
  tenancy_id              = var.tenancy_ocid
  display_name            = "${var.customer_label}-bacs01"
  vnic_hostname_label     = "${var.customer_label}bacs01"
  shape                   = var.db_shapes
  shape_ocpus             = var.db_shape_ocpus
  shape_mem               = var.db_shape_mem
  availability_domain     = 1
  fault_domain            = 3
  compartment_id          = var.compartment_id_db
  subnet_id               = var.subnet_id
  network_sec_groups      = local.nsg_db2
  ssh_authorized_keys     = var.ssh_key_db
  source_id               = "ocid1.image.oc1.uk-london-1.aaaaaaaa4ubcwfrtn3zltzffg4slwkxzayp3px3ukowqn7sbgdcecl65sega"
  boot_volume_size_in_gbs = var.data_storage_size_in_gb
  assign_public_ip        = false
  boot_backup_policy      = "silver"
  #private_ip              = [local.ips.instances["ebs_intl_test_db"]]
  defined_tags            = local.tags
}

############################################################################
# VG01 - /archive

module "instance_test_ebs_db2_VG01" {
  source              = "./modules/core_volume"
  tenancy_id          = var.tenancy_ocid
  volume_display_name = "ociebsdb_VG01"
  availability_domain = 2
  compartment_id      = var.compartment_id_db
  backup_policy       = "silver"
  size_in_gbs         = 50
  defined_tags        = local.tags
  
}

resource "oci_core_volume_attachment" "instance_test_ebs_db2_VG01_attach" {
  instance_id     = module.instance_test_db2.core_instance_ids[0]
  volume_id       = module.instance_test_ebs_db2_VG01.core_volume_ids[0]
  device          = "/dev/oracleoci/oraclevdb"
  attachment_type = "paravirtualized"
}




