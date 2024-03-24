## Copyright (c) 2021, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Variables
variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "MySQL_password" {}

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
variable "MySQL_password" {
  description = "The password for the MySQL database"
}

variable "compartment_ocid" {
  description = "The OCID of the compartment where the MySQL database will be created"
}

variable "MySQL_database_cpu_core_count" {
  description = "The number of CPU cores for the MySQL database"
}

variable "MySQL_database_data_storage_size_in_gbs" {
  description = "The size of the data storage in GBs for the MySQL database"
}

variable "MySQL_database_db_name" {
  description = "The name of the MySQL database"
}

variable "MySQL_database_db_version" {
  description = "The version of the MySQL database"
}

variable "MySQL_database_display_name" {
  description = "The display name of the MySQL database"
}

variable "MySQL_database_freeform_tags" {
  description = "Freeform tags for the MySQL database"
}

variable "MySQL_database_license_model" {
  description = "The license model for the MySQL database"
}

variable "MySQL_free_tier" {
  description = "Whether the MySQL database is in the free tier"
}

variable "MySQL_private_endpoint" {
  description = "Whether to use a private endpoint for the MySQL database"
}

variable "MySQL_nsg_id" {
  description = "The OCID of the network security group for the MySQL database"
}

variable "MySQL_private_endpoint_label" {
  description = "The label for the private endpoint of the MySQL database"
}

variable "MySQL_subnet_id" {
  description = "The OCID of the subnet for the MySQL database"
}

variable "MySQL_data_guard_enabled" {
  description = "Whether data guard is enabled for the MySQL database"
}

variable "release" {
  description = "Release tag for the resource"
}

variable "oci_identity_tag_namespace" {
  description = "The namespace for OCI Identity tags"
}

variable "oci_identity_tag" {
  description = "The tag for OCI Identity"
}
variable "mysql_connector_version" {
  description = "Version of the MySQL connector"
  type        = string
  default     = "8.0.28"
}

variable "mysql_password" {
  description = "Password for MySQL database"
  type        = string
}

variable "mysql_database_db_name" {
  description = "Name of the MySQL database"
  type        = string
}
variable "mysql_root_password" {
  description = "Root password for MySQL"
  type        = string
}
variable "mysql_wallet_zip_file" {
  description = "The path to the MySQL wallet zip file"
  type        = string
  default     = "/path/to/mysql/wallet.zip"
}
variable "sql_mys_file" {
  type        = string
  description = "The file path where the decoded SQL content will be written"
  default     = "/path/to/sql/output.sql" // You can change the default path as needed
}


#variable "MySql_private_endpoint" {
# default = true
#}

#variable "MySql_free_tier" {
 # default = false
#}

#variable "MySql_database_cpu_core_count" {
#  default = 1
#}

#variable "MySql_database_data_storage_size_in_tbs" {
#  default = 1
#}

#variable "MySql_database_db_name" {
#  default = "MySqlAS"
#}

#variable "MySql_database_db_version" {
#  default = "19c"
#}

#variable "MySql_database_defined_tags_value" {
#  default = "value"
#}

#variable "MySql_database_display_name" {
#  default = "MySqlAS"
#}

#variable "MySql_database_freeform_tags" {
#  default = {
#   "Owner" = "MySql" }
#}

#variable "MySql_database_license_model" {
#  default = "LICENSE_INCLUDED"
#}

#variable "MySql_tde_wallet_zip_file" {
#  default = "tde_wallet_aTFdb.zip"
#}

#variable "MySql_private_endpoint_label" {
#  default = "MySqlASPrivateEndpoint"
#}

#variable "MySql_data_guard_enabled" {
#  default = false
#}

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

