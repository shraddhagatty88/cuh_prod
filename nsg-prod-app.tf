###########################################################################
# NSG - Prod Application:
###########################################################################

resource "oci_core_network_security_group" "nsg_prod_app" {
    compartment_id = var.compartment_id
    vcn_id         = var.vcn
    display_name   = "nsg_prod_app"
    #defined_tags   = local.tags
    lifecycle {
        ignore_changes = [
            defined_tags["Oracle-Tags.CreatedBy"],
            defined_tags["Oracle-Tags.CreatedOn"],
            defined_tags["Account.Created_By"],
            defined_tags["Account.Created_At"],
        ]
    }
}
 
output "nsg_prod_app_id" {
    value = oci_core_network_security_group.nsg_prod_app.id
}

###########################################################################
# INGRESS:
###########################################################################


