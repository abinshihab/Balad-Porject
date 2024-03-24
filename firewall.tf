# Resource: OCI WAF
#resource "oci_waf_web_app_firewall" "my_waf" {
#  compartment_id         = var.compartment_ocid
#  load_balancer_id       = var.load_balancer_id
#  display_name           = "MyWAF"
#  availability_domain    = local.availability_domain_name
#  vcn_id                 = local.vcn_id
#  subnet_id              = local.subnet_web_id
#  nsg_id                 = local.WebSecurityGroup_id
#  hostname               = "example.com"
#  domain                 = "example.com"
#  origin                 = "www.example.com"
#  is_protected           = true
#  response_header_policy = "BROWSER_SECURITY"
#  defined_tags = {
#    "${var.oci_identity_tag_namespace}.${var.oci_identity_tag}" = var.release
#  }
#}
# Define OCI WAF Policy Rules
#resource "oci_waas_waas_policy_rule" "waf_rule1" {
#  waas_policy_id   = oci_waas_policy.waf_policy.id
#  display_name     = "Block SQL Injection"
#  condition_language = "EXPRESSION"
#  condition = "request.uri.path matches '/.*/' and request.http.method = 'GET' and request.http.uri.queryParams matches '.*union.*select.*'"
#  action          = "BLOCK"
#}

resource "oci_waas_waas_policy_rule" "waf_rule2" {
  waas_policy_id   = oci_waas_policy.waf_policy.id
  display_name     = "Block XSS"
  condition_language = "EXPRESSION"
  condition = "request.http.header contains '<script>'"
  action          = "BLOCK"
}

# Define OCI Network Firewall Resources
#resource "oci_core_network_security_group" "network_firewall" {
#  compartment_id = var.compartment_ocid
#  display_name   = "APP NetworkFirewall"
  
#}
# Define OCI Network Firewall Rules
#resource "oci_core_network_security_group_security_rule" "network_firewall_rule1" {
#  network_security_group_id = oci_core_network_security_group.network_firewall.id
#  protocol                  = "TCP"
#  source_type               = "CIDR_BLOCK"
#  source                    = "0.0.0.0/0"
#  destination_port_range    = "80"
#  tcp_options {
#    source_port_range = "1024-65535"
#  }
#  description               = "Allow inbound HTTP traffic"
#}

#resource "oci_core_network_security_group_security_rule" "network_firewall_rule2" {
#  network_security_group_id = oci_core_network_security_group.network_firewall.id
#  protocol                  = "TCP"
#  source_type               = "CIDR_BLOCK"
#  source                    = "0.0.0.0/0"
#  destination_port_range    = "443"
#  tcp_options {
#    source_port_range = "1024-65535"
#  }
#  description               = "Allow inbound HTTPS traffic"
#}

