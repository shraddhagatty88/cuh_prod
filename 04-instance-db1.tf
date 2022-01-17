
module "instance_test_db1" {
  source                  = "./modules/core_instance"
  tenancy_id              = var.tenancy_ocid
  display_name            = "${var.customer_label}-ebs-archive01"
  vnic_hostname_label     = "${var.customer_label}ebsarchive01"
  shape                   = var.db_shapes
  shape_ocpus             = var.db_shape_ocpus
  shape_mem               = var.db_shape_mem
  availability_domain     = 1
  fault_domain            = 3
  compartment_id          = var.compartment_id_db
  subnet_id               = var.subnet_id
  network_sec_groups      = local.nsg_db1
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

module "instance_test_ebs_db1_VG01" {
  source              = "./modules/core_volume"
  tenancy_id          = var.tenancy_ocid
  volume_display_name = "ociebsdb_VG01"
  availability_domain = module.instance_test_db1.core_instance_ad[0]
  compartment_id      = var.compartment_id_db
  backup_policy       = "silver"
  size_in_gbs         = 550
  defined_tags        = local.tags
  
}

resource "oci_core_volume_attachment" "instance_test_ebs_db1_VG01_attach" {
  instance_id     = module.instance_test_db1.core_instance_ids[0]
  volume_id       = module.instance_test_ebs_db1_VG01.core_volume_ids[0]
  device          = "/dev/oracleoci/oraclevdb"
  attachment_type = "paravirtualized"
}




############################################################################
# VG02 


module "instance_test_ebs_db1_VG02" {
  source              = "./modules/core_volume"
  tenancy_id          = var.tenancy_ocid
  volume_display_name = "ociebsdb_VG02"
  availability_domain = module.instance_test_db1.core_instance_ad[0]
  compartment_id      = var.compartment_id_db
  backup_policy       = "silver"
  size_in_gbs         = 50
  defined_tags        = local.tags
  
}

resource "oci_core_volume_attachment" "instance_test_ebs_db1_VG02_attach" {
  instance_id     = module.instance_test_db1.core_instance_ids[0]
  volume_id       = module.instance_test_ebs_db1_VG02.core_volume_ids[0]
  device          = "/dev/oracleoci/oraclevdc"
  attachment_type = "paravirtualized"
}

############################################################################
# VG03


module "instance_test_ebs_db1_VG03" {
  source              = "./modules/core_volume"
  tenancy_id          = var.tenancy_ocid
  volume_display_name = "ociebsdb_VG03"
  availability_domain = module.instance_test_db1.core_instance_ad[0]
  compartment_id      = var.compartment_id_db
  backup_policy       = "silver"
  size_in_gbs         = 300
  defined_tags        = local.tags
  
}

resource "oci_core_volume_attachment" "instance_test_ebs_db1_VG03_attach" {
  instance_id     = module.instance_test_db1.core_instance_ids[0]
  volume_id       = module.instance_test_ebs_db1_VG03.core_volume_ids[0]
  device          = "/dev/oracleoci/oraclevdd"
  attachment_type = "paravirtualized"
}

############################################################################
