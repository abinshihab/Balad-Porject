## Copyright (c) 2021, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Variables
variable "tenancy_ocid" {}
variable "compartment_ocid" {}
#variable "user_ocid" {}
#variable "fingerprint" {}
#variable "private_key_path" {}
variable "region" {}
variable "MySql_password" {}

variable "availability_domain_name" {
  default = ""
}

variable "availability_domain_number" {
  default = 0
}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.4.2"
}

variable "use_existing_vcn" {
  default = false
}

variable "use_existing_nsg" {
  default = false
}

variable "vcn_id" {
  default = ""
}

variable "lb_subnet_id" {
  default = ""
}

variable "lb_nsg_id" {
  default = ""
}

variable "compute_subnet_id" {
  default = ""
}

variable "compute_nsg_id" {
  default = ""
}

variable "MySql_subnet_id" {
  default = ""
}

variable "MySql_nsg_id" {
  default = ""
}

variable "oracle_instant_client_version" {
  default = "19.10"
}

variable "oracle_instant_client_version_short" {
  default = "19.10"
}

# OS Images
variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "7.9"
}

variable "instance_shape" {
  default = "VM.Standard.E3.Flex"
}

variable "instance_flex_shape_ocpus" {
  default = 1
}

variable "instance_flex_shape_memory" {
  default = 10
}

variable "ssh_public_key" {
  default = ""
}

variable "lb_shape" {
  default = "flexible"
}

variable "flex_lb_min_shape" {
  default = "10"
}

variable "flex_lb_max_shape" {
  default = "100"
}

variable "MySql_private_endpoint" {
  default = true
}

variable "MySql_free_tier" {
  default = false
}

variable "MySql_database_cpu_core_count" {
  default = 1
}

variable "MySql_database_data_storage_size_in_tbs" {
  default = 1
}

variable "MySql_database_db_name" {
  default = "MySqlAS"
}

variable "MySql_database_db_version" {
  default = "19c"
}

variable "MySql_database_defined_tags_value" {
  default = "value"
}

variable "MySql_database_display_name" {
  default = "MySqlAS"
}

variable "MySql_database_freeform_tags" {
  default = {
    "Owner" = "MySql"
  }
}

variable "MySql_database_license_model" {
  default = "LICENSE_INCLUDED"
}

variable "MySql_tde_wallet_zip_file" {
  default = "tde_wallet_aTFdb.zip"
}

variable "MySql_private_endpoint_label" {
  default = "MySqlASPrivateEndpoint"
}

variable "MySql_data_guard_enabled" {
  default = false
}

# Dictionary Locals
locals {
  compute_flexible_shapes = [
    "VM.Standard.E3.Flex",
    "VM.Standard.E4.Flex",
    "VM.Standard.A1.Flex",
    "VM.Optimized3.Flex"
  ]
}

# locals
locals {
  is_flexible_lb_shape     = var.lb_shape == "flexible" ? true : false
  is_flexible_node_shape   = contains(local.compute_flexible_shapes, var.instance_shape)
  availability_domain_name = var.availability_domain_name == "" ? lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain_number], "name") : var.availability_domain_name
  MySql_nsg_id               = !var.use_existing_nsg ? oci_core_network_security_group.MySqlSecurityGroup[0].id : var.MySql_nsg_id
  MySql_subnet_id            = !var.use_existing_vcn ? oci_core_subnet.subnet_3[0].id : var.MySql_subnet_id
  vcn_id                   = !var.use_existing_vcn ? oci_core_virtual_network.vcn[0].id : var.vcn_id
}

