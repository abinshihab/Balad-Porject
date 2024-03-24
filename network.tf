## Copyright (c) 2021, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

#Create virtual cloud network
resource "oci_core_virtual_network" "vcn" {
  count          = !var.use_existing_vcn ? 1 : 0
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "web-app-vcn"
  dns_label      = "tfexamplevcn"
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

#resource "oci_core_nat_gateway" "nat_gw" {
#  count          = !var.use_existing_vcn ? 1 : 0
#  compartment_id = var.compartment_ocid
#  display_name   = "nat_gateway"
#  vcn_id         = oci_core_virtual_network.vcn[0].id
#  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
#}
# Create NAT Gateways
resource "oci_core_nat_gateway" "nat_gw_web" {
  count          = !var.use_existing_vcn ? 1 : 0
  compartment_id = var.compartment_ocid
  display_name   = "nat_gateway_web"
  vcn_id         = oci_core_virtual_network.vcn[0].id
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_nat_gateway" "nat_gw_api" {
  count          = !var.use_existing_vcn ? 1 : 0
  compartment_id = var.compartment_ocid
  display_name   = "nat_gateway_api"
  vcn_id         = oci_core_virtual_network.vcn[0].id
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_nat_gateway" "nat_gw_dashboard" {
  count          = !var.use_existing_vcn ? 1 : 0
  compartment_id = var.compartment_ocid
  display_name   = "nat_gateway_dashboard"
  vcn_id         = oci_core_virtual_network.vcn[0].id
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
resource "oci_core_nat_gateway" "nat_gw_mysql" {
  count          = !var.use_existing_vcn ? 1 : 0
  compartment_id = var.compartment_ocid
  display_name   = "nat_gateway_mysql"
  vcn_id         = oci_core_virtual_network.vcn[0].id
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
# Create Internet Gateway
resource "oci_core_internet_gateway" "ig" {
  count          = !var.use_existing_vcn ? 1 : 0
  compartment_id = var.compartment_ocid
  display_name   = "ig-gateway"
  vcn_id         = oci_core_virtual_network.vcn[0].id
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
#Create Public Route Table
resource "oci_core_route_table" "rt-pub" {
  count          = !var.use_existing_vcn ? 1 : 0
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn[0].id
  display_name   = "rt-table"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.ig[0].id
  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
#Create private route table
resource "oci_core_route_table" "rt-priv" {
  count          = !var.use_existing_vcn ? 1 : 0
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn[0].id
  display_name   = "rt-table-priv"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat_gw[0].id
  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
resource "oci_core_route_table" "rt-web" {
  count          = !var.use_existing_vcn ? 1 : 0
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn[0].id
  display_name   = "rt-web"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat_gw_web[0].id
  }

  defined_tags = {
    "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release
  }
}

resource "oci_core_route_table" "rt-api" {
  count          = !var.use_existing_vcn ? 1 : 0
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn[0].id
  display_name   = "rt-api"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat_gw_api[0].id
  }

  defined_tags = {
    "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release
  }
}

resource "oci_core_route_table" "rt-dashboard" {
  count          = !var.use_existing_vcn ? 1 : 0
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn[0].id
  display_name   = "rt-dashboard"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat_gw_dashboard[0].id
  }

  defined_tags = {
    "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release
  }
}
#Create subnet 
resource "oci_core_subnet" "lb_subnet" {
  count           = !var.use_existing_vcn ? 1 : 0
  cidr_block      = "10.0.0.0/24"
  display_name    = "subnet-A"
  compartment_id  = var.compartment_ocid
  vcn_id          = oci_core_virtual_network.vcn[0].id
  dhcp_options_id = oci_core_virtual_network.vcn[0].default_dhcp_options_id
  route_table_id  = oci_core_route_table.rt-pub[0].id
  dns_label       = "subnet1"

  provisioner "local-exec" {
    command = "sleep 5"
  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_subnet" "subnet_web" {
  count           = !var.use_existing_vcn ? 1 : 0
  cidr_block      = "10.0.1.0/24"
  display_name    = "subnet_web"
  compartment_id  = var.compartment_ocid
  vcn_id          = oci_core_virtual_network.vcn[0].id
  dhcp_options_id = oci_core_virtual_network.vcn[0].default_dhcp_options_id
  route_table_id  = oci_core_route_table.rt-pub[0].id
  prohibit_public_ip_on_vnic = true
  dns_label       = "subnet_web"
  provisioner "local-exec" {
    command = "sleep 5"
  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
resource "oci_core_subnet" "subnet_api" {
  count           = !var.use_existing_vcn ? 1 : 0
  cidr_block      = "10.0.2.0/24"
  display_name    = "subnet_api"
  compartment_id  = var.compartment_ocid
  vcn_id          = oci_core_virtual_network.vcn[0].id
  dhcp_options_id = oci_core_virtual_network.vcn[0].default_dhcp_options_id
  route_table_id  = oci_core_route_table.rt-pub[0].id
  prohibit_public_ip_on_vnic = true
  dns_label       = "subnet_api"
  provisioner "local-exec" {
    command = "sleep 5"
  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
resource "oci_core_subnet" "subnet_dashboard" {
  count           = !var.use_existing_vcn ? 1 : 0
  cidr_block      = "10.0.3.0/24"
  display_name    = "subnet_dashboard"
  compartment_id  = var.compartment_ocid
  vcn_id          = oci_core_virtual_network.vcn[0].id
  dhcp_options_id = oci_core_virtual_network.vcn[0].default_dhcp_options_id
  route_table_id  = oci_core_route_table.rt-pub[0].id
  prohibit_public_ip_on_vnic = true
  dns_label       = "subnet_dashboard"
  provisioner "local-exec" {
    command = "sleep 5"
  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}


resource "oci_core_subnet" "subnet_5" {
  count                      = !var.use_existing_vcn ? 1 : 0
  cidr_block                 = "10.0.4.0/24"
  display_name               = "subnet-E"
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_virtual_network.vcn[0].id
  dhcp_options_id            = oci_core_virtual_network.vcn[0].default_dhcp_options_id
  route_table_id             = oci_core_route_table.rt-priv[0].id
  prohibit_public_ip_on_vnic = true
  dns_label                  = "subnet5"

  provisioner "local-exec" {
    command = "sleep 5"
  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
#Define VPN
# Define the DRG
resource "oci_core_drg" "vpn_drg" {
  compartment_id = var.compartment_ocid
  display_name   = "vpn-drg"
}

# Define the CPE
resource "oci_core_cpe" "vpn_cpe" {
  compartment_id = var.compartment_ocid
  display_name   = "vpn-cpe"
  ip_address     = "X.X.X.X" # Public IP of your CPE
  # Other CPE configurations...
}

# Associate the DRG with the VCN
resource "oci_core_drg_attachment" "example_drg_attachment" {
  display_name      = "vcn-drg-attachment"
  vcn_id            = oci_core_virtual_network.vcn[0].id
  drg_id            = oci_core_drg.vpn_drg.id
  compartment_id    = var.compartment_ocid
}

# Define the VPN Connection
resource "oci_core_ipsec_connection" "vpn_ipsec_connection" {
  compartment_id   = var.compartment_ocid
  cpe_id           = oci_core_cpe.vpn_cpe.id
  drg_id           = oci_core_drg.vpn_drg.id
  display_name     = "vpn-ipsec-connection"
  static_routes    = ["10.0.0.0/16"] # CIDR block of your VCN
  timeouts {
    create = "1h"
  }
}
