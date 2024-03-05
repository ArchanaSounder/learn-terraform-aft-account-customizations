# Sandbox admin account id
variable sandbox_admin_account_id{
  default = "471112740874"
}

# Sandbox vpc creation is true or not
variable create_vpc {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

# Variable declaration for Primary cidr block 
variable primary_cidr_block {
  description = "The primary CIDR blocks to associate with the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Variable declaration for secondary cidr block
variable secondary_cidr_blocks {
  description = "Secondary CIDR blocks to associate with the VPC to extend the IP Address pool"
  type        = string
  default     = "default"
}

# Variable declaration for instance tenancy
variable instance_tenancy {
  description = "Instance tenancy of the VPC"
  type        = string
  default     = "default"
}
# Variable declaration to enable dns hostname
variable enable_dns_hostnames {
  description = "Enable DNS Hostnames for the VPC"
  type        = bool
  default     = true
}
# Variable declaration to enable dns support
variable enable_dns_support {
  description = "Enable DNS Support for the VPC"
  type        = bool
  default     = true
}

# Variable declaration for vpc-name
variable "vpc-name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "sl-vpc"
}

# Variable declaration for tags
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

# Variable declaration for vpc tags
variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}

# Variable declaration for private subnet tags
variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map(string)
  default     = {}
}

# Variable declaration for private acl tags
variable "private_acl_tags" {
  description = "Additional tags for the private subnets network ACL"
  type        = map(string)
  default     = {}
}
# Variable declaration for private subnets
variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

# Variable declaration for private subnet names
variable "private_subnet_names" {
  description = "The list of Private subnets name"
  type        = list(string)
  default     = ["sl-private-subnet1", "sl-private-subnet2", "sl-private-subnet3"]
}

# Variable declaration for azs
variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}
# Variable declaration for private inbound acl rules
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
# Variable declaration for private outbound acl rules
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
# Variable declaration for private route table routes
variable "private_route_table_routes" {
  description = "Configuration block of routes. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table#route"
  type        = list(map(string))
  default     = []
}

# Variable declaration for minimum password length
variable "minimum_password_length" {
  type    = number
  default = 8
}
# Variable declaration for lowercase
variable "require_lowercase_characters" {
  default = true
}

# Variable declaration for numbers
variable "require_numbers" {
  default = true
}

# Variable declaration for uppercase
variable "require_uppercase_characters" {
  default = true
}

# Variable declaration for symbols
variable "require_symbols" {
  default = true
}

# Variable declaration to change password by users
variable "allow_users_to_change_password" {
  default = true
}

# Variable declaration for max password age
variable "max_password_age" {
  default = 90
}
