## Copyright (c) 2021, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

#module "oci-adb" {
#  source                                = "github.com/oracle-quickstart/oci-adb"
#  adb_password                          = var.MySql_password
#  compartment_ocid                      = var.compartment_ocid
#  adb_database_cpu_core_count           = var.MySql_database_cpu_core_count
#  adb_database_data_storage_size_in_tbs = var.MySql_database_data_storage_size_in_tbs
#  adb_database_db_name                  = var.MySql_database_db_name
#  adb_database_db_version               = var.MySql_database_db_version
#  adb_database_display_name             = var.MySql_database_display_name
#  adb_database_freeform_tags            = var.MySql_database_freeform_tags
#  adb_database_license_model            = var.MySql_database_license_model
#  adb_database_db_workload              = "OLTP"
#  adb_free_tier                         = var.MySql_free_tier
#  use_existing_vcn                      = var.MySql_private_endpoint
#  adb_private_endpoint                  = var.MySql_private_endpoint
#  vcn_id                                = var.MySql_private_endpoint ? local.vcn_id : null
#  adb_nsg_id                            = var.MySql_private_endpoint ? local.MySql_nsg_id : null
#  adb_private_endpoint_label            = var.MySql_private_endpoint ? var.MySql_private_endpoint_label : null
#  adb_subnet_id                         = var.MySql_private_endpoint ? local.MySql_subnet_id : null
#  is_data_guard_enabled                 = var.MySql_data_guard_enabled
#  defined_tags                          = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
# }

module "oci-mysql-heatwave" {
  source                                 = "github.com/oracle-quickstart/oci-mysql-heatwave"
  mysql_password                         = var.MySQL_password
  compartment_ocid                       = var.compartment_ocid
  mysql_database_cpu_core_count          = var.MySQL_database_cpu_core_count
  mysql_database_data_storage_size_in_gb = var.MySQL_database_data_storage_size_in_gb
  mysql_database_db_name                 = var.MySQL_database_db_name
  mysql_database_db_version              = var.MySQL_database_db_version
  mysql_database_display_name            = var.MySQL_database_display_name
  mysql_database_freeform_tags           = var.MySQL_database_freeform_tags
  mysql_database_license_model           = var.MySQL_database_license_model
  mysql_database_db_workload             = "OLTP"
  mysql_free_tier                        = var.MySQL_free_tier
  use_existing_vcn                       = var.MySQL_private_endpoint
  mysql_private_endpoint                 = var.MySQL_private_endpoint
  vcn_id                                 = var.MySQL_private_endpoint ? local.vcn_id : null
  mysql_nsg_id                           = var.MySQL_private_endpoint ? local.MySQL_nsg_id : null
  mysql_private_endpoint_label           = var.MySQL_private_endpoint ? var.MySQL_private_endpoint_label : null
  mysql_subnet_id                        = var.MySQL_private_endpoint ? local.MySQL_subnet_id : null
  is_data_guard_enabled                  = var.MySQL_data_guard_enabled
  defined_tags                           = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
