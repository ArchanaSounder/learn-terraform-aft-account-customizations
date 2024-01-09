# Variable definition for VPC CIDR
variable vpc_cidr {
  type    = list(string)
  default = ["10.0.0.0/16", "192.168.0.0/16"]
}

# Variable definition for VPC name
variable vpc_name {
  type    = list(string)    
}

# Variable declaration for region
variable region {
  type    = string
  default = "ap-south-1"
}

# Variable declaration for instance tenancy
variable instance_tenancy {
  default = "default"
}

# Variable declaration for enabling dns support
variable enable_dns_support {
  default = true
}

# Variable declaration for enabling dns hostnames
variable enable_dns_hostnames {
  default = true
}


# Variable declaration for assign generated ipv6 cidr block
variable assign_generated_ipv6_cidr_block {
  default = false
}
