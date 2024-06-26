## Copyright (c) 2021, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# MySqlSecurityGroup

resource "oci_core_network_security_group" "MySqlSecurityGroup" {
  count          = !var.use_existing_nsg ? 1 : 0
  compartment_id = var.compartment_ocid
  display_name   = "MySqlSecurityGroup"
  vcn_id         = oci_core_virtual_network.vcn[0].id
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

# Rules related to MySqlSecurityGroup

# EGRESS

resource "oci_core_network_security_group_security_rule" "MySqlSecurityEgressGroupRule" {
  count                     = !var.use_existing_nsg ? 1 : 0
  network_security_group_id = oci_core_network_security_group.MySqlSecurityGroup[0].id
  direction                 = "EGRESS"
  protocol                  = "6"
  #    destination = "10.0.0.0/16"
  destination      = "10.0.1.0/24"
  destination_type = "CIDR_BLOCK"
}

# INGRESS

resource "oci_core_network_security_group_security_rule" "MySqlSecurityIngressGroupRules" {
  count                     = !var.use_existing_nsg ? 1 : 0
  network_security_group_id = oci_core_network_security_group.MySqlSecurityGroup[0].id
  direction                 = "INGRESS"
  protocol                  = "6"
  #    source = "10.0.0.0/16"
  source      = "10.0.1.0/24"
  source_type = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 1522
      min = 1522
    }
  }
}

# WebSecurityGroup

resource "oci_core_network_security_group" "WebSecurityGroup" {
  count          = !var.use_existing_nsg ? 1 : 0
  compartment_id = var.compartment_ocid
  display_name   = "WebSecurityGroup"
  vcn_id         = oci_core_virtual_network.vcn[0].id
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

# Rules related to WebSecurityGroup

# EGRESS

resource "oci_core_network_security_group_security_rule" "WebSecurityEgressMySqlGroupRule" {
  count                     = !var.use_existing_nsg ? 1 : 0
  network_security_group_id = oci_core_network_security_group.WebSecurityGroup[0].id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = oci_core_network_security_group.MySqlSecurityGroup[0].id
  destination_type          = "NETWORK_SECURITY_GROUP"
}

resource "oci_core_network_security_group_security_rule" "WebSecurityEgressInternetGroupRule" {
  count                     = !var.use_existing_nsg ? 1 : 0
  network_security_group_id = oci_core_network_security_group.WebSecurityGroup[0].id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "10.0.0.0/24"
  destination_type          = "CIDR_BLOCK"
}

# INGRESS

resource "oci_core_network_security_group_security_rule" "WebSecurityIngressGroupRules" {
  count                     = !var.use_existing_nsg ? 1 : 0
  network_security_group_id = oci_core_network_security_group.WebSecurityGroup[0].id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "10.0.0.0/24"

  source_type = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 5000
      min = 5000
    }
  }
}

# APISecurityGroup

resource "oci_core_network_security_group" "APISecurityGroup" {
  count          = !var.use_existing_nsg ? 1 : 0
  compartment_id = var.compartment_ocid
  display_name   = "APISecurityGroup"
  vcn_id         = oci_core_virtual_network.vcn[0].id
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

# Rules related to APISecurityGroup

# EGRESS

resource "oci_core_network_security_group_security_rule" "APISecurityEgressMySqlGroupRule" {
  count                     = !var.use_existing_nsg ? 1 : 0
  network_security_group_id = oci_core_network_security_group.APISecurityGroup[0].id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = oci_core_network_security_group.MySqlSecurityGroup[0].id
  destination_type          = "NETWORK_SECURITY_GROUP"
}

resource "oci_core_network_security_group_security_rule" "APISecurityEgressInternetGroupRule" {
  count                     = !var.use_existing_nsg ? 1 : 0
  network_security_group_id = oci_core_network_security_group.WebSecurityGroup[0].id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "10.0.0.0/24"
  destination_type          = "CIDR_BLOCK"
}

# INGRESS

resource "oci_core_network_security_group_security_rule" "APISecurityIngressGroupRules" {
  count                     = !var.use_existing_nsg ? 1 : 0
  network_security_group_id = oci_core_network_security_group.WebSecurityGroup[0].id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "10.0.0.0/24"

  source_type = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 5000
      min = 5000
    }
  }
}

# DashSecurityGroup

resource "oci_core_network_security_group" "DashSecurityGroup" {
  count          = !var.use_existing_nsg ? 1 : 0
  compartment_id = var.compartment_ocid
  display_name   = "APISecurityGroup"
  vcn_id         = oci_core_virtual_network.vcn[0].id
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

# Rules related to DashSecurityGroup

# EGRESS

resource "oci_core_network_security_group_security_rule" "DashSecurityEgressMySqlGroupRule" {
  count                     = !var.use_existing_nsg ? 1 : 0
  network_security_group_id = oci_core_network_security_group.APISecurityGroup[0].id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = oci_core_network_security_group.MySqlSecurityGroup[0].id
  destination_type          = "NETWORK_SECURITY_GROUP"
}

resource "oci_core_network_security_group_security_rule" "DashSecurityEgressInternetGroupRule" {
  count                     = !var.use_existing_nsg ? 1 : 0
  network_security_group_id = oci_core_network_security_group.WebSecurityGroup[0].id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "10.0.0.0/24"
  destination_type          = "CIDR_BLOCK"
}

# INGRESS

resource "oci_core_network_security_group_security_rule" "SecurityIngressGroupRules" {
  count                     = !var.use_existing_nsg ? 1 : 0
  network_security_group_id = oci_core_network_security_group.WebSecurityGroup[0].id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "10.0.0.0/24"

  source_type = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 5000
      min = 5000
    }
  }
}


# LBSecurityGroup

resource "oci_core_network_security_group" "LBSecurityGroup" {
  count          = !var.use_existing_nsg ? 1 : 0
  compartment_id = var.compartment_ocid
  display_name   = "LBSecurityGroup"
  vcn_id         = oci_core_virtual_network.vcn[0].id
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

# Rules related to LBSecurityGroup

# EGRESS

resource "oci_core_network_security_group_security_rule" "LBSecurityEgressInternetGroupRule" {
  count                     = !var.use_existing_nsg ? 1 : 0
  network_security_group_id = oci_core_network_security_group.LBSecurityGroup[0].id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}

# INGRESS

resource "oci_core_network_security_group_security_rule" "LBSecurityIngressGroupRules" {
  count                     = !var.use_existing_nsg ? 1 : 0
  network_security_group_id = oci_core_network_security_group.LBSecurityGroup[0].id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 80
      min = 80
    }
  }
}

# SSHSecurityGroup

resource "oci_core_network_security_group" "SSHSecurityGroup" {
  count          = !var.use_existing_nsg ? 1 : 0
  compartment_id = var.compartment_ocid
  display_name   = "SSHSecurityGroup"
  vcn_id         = oci_core_virtual_network.vcn[0].id
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

# Rules related to SSHSecurityGroup

# EGRESS

resource "oci_core_network_security_group_security_rule" "SSHSecurityEgressGroupRule" {
  count                     = !var.use_existing_nsg ? 1 : 0
  network_security_group_id = oci_core_network_security_group.SSHSecurityGroup[0].id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}

# INGRESS

resource "oci_core_network_security_group_security_rule" "SSHSecurityIngressGroupRules" {
  count                     = !var.use_existing_nsg ? 1 : 0
  network_security_group_id = oci_core_network_security_group.SSHSecurityGroup[0].id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 22
      min = 22
    }
  }
}

