# Variable declaration for vpc cidr
variable vpc_cidr {
  type    = list(string)
  default = ["10.0.0.0/16", "192.168.0.0/16"]
}
# Variable declaration for vpc name
variable vpc_name {
  type    = list(string)    
}

# Variable declaration for instance tenancy
variable instance_tenancy {
  default = "default"
}

# Variable declaration to enable dns support
variable enable_dns_support {
  default = true
}

# Variable declaration to enable dns hostname
variable enable_dns_hostnames {
  default = true
}

# Variable declaration for assigning generated ipv6 cidr block
variable assign_generated_ipv6_cidr_block {
  default = false
}