# Variable definition for VPC CIDR
/*
variable vpc_cidr {
  type    = list(string)
  default = ["10.0.0.0/16", "192.168.0.0/16"]
}

# Variable definition for VPC name
variable vpc_name {
  type    = list(string)    
  default = ["lz-vpc1", "lz-vpc2"]
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
*/
variable sandbox_admin_account_id{
  default = "339713170791"
}



variable create_vpc {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable primary_cidr_block {
  description = "The primary CIDR blocks to associate with the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable secondary_cidr_blocks {
  description = "Secondary CIDR blocks to associate with the VPC to extend the IP Address pool"
  type        = string
  default     = "default"
}

variable instance_tenancy {
  description = "Instance tenancy of the VPC"
  type        = string
  default     = "default"
}

variable enable_dns_hostnames {
  description = "Enable DNS Hostnames for the VPC"
  type        = bool
  default     = true
}

variable enable_dns_support {
  description = "Enable DNS Support for the VPC"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "sl-vpc"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map(string)
  default     = {}
}

variable "private_acl_tags" {
  description = "Additional tags for the private subnets network ACL"
  type        = map(string)
  default     = {}
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_names" {
  description = "The list of Private subnets name"
  type        = list(string)
  default     = ["sl-private-subnet1", "sl-private-subnet2", "sl-private-subnet3"]
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "private_inbound_acl_rules" {
  description = "Private subnets inbound network ACLs"
  type        = list(map(string))
  default = [
    {
      rule_number = 10
      rule_action = "allow"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number = 20
      rule_action = "deny"
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number = 200
      rule_action = "allow"
      from_port   = 1024
      to_port     = 65535
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    }
  ]
}

variable "private_outbound_acl_rules" {
  description = "Private subnets outbound network ACLs"
  type        = list(map(string))

  default = [
    {
      rule_number = 10
      rule_action = "allow"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number = 20
      rule_action = "deny"
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number = 200
      rule_action = "allow"
      from_port   = 1024
      to_port     = 65535
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number = 300
      rule_action = "allow"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    }
  ]
}

variable "private_route_table_routes" {
  description = "Configuration block of routes. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table#route"
  type        = list(map(string))
  default     = []
}
