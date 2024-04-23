provider "aws" {
  /* other provider config */
  assume_role {
    // Assume the organization access role
    role_arn = "arn:aws:iam::${var.sandbox_admin_account_id}:role/AWSAFTExecution"
  }
  alias                    = "sandbox"
   region                  = "ap-south-1"
}
/*
module "aws_vpc" {
  source                     = "./module/vpc"
  vpc-name                   = var.vpc-name
  primary_cidr_block         = var.primary_cidr_block
  secondary_cidr_blocks      = var.secondary_cidr_blocks
  instance_tenancy           = var.instance_tenancy
  enable_dns_hostnames       = var.enable_dns_hostnames
  enable_dns_support         = var.enable_dns_support
  azs                        = var.azs
  tags                       = var.tags
  vpc_tags                   = var.vpc_tags
  private_subnets            = var.private_subnets
  private_subnet_names       = var.private_subnet_names
  private_acl_tags           = var.private_acl_tags
  private_inbound_acl_rules  = var.private_inbound_acl_rules
  private_outbound_acl_rules = var.private_outbound_acl_rules
  private_route_table_routes = var.private_route_table_routes
  private_subnet_tags        = var.private_subnet_tags
  providers = {
    aws = aws.sandbox
  }
}

# Module creation for iam account password policy
module "aws_iam_account_password_policy_aft" {
  source                         = "./module/iam_password_policy"
  minimum_password_length        = var.minimum_password_length
  require_lowercase_characters   = var.require_lowercase_characters
  require_numbers                = var.require_numbers
  require_uppercase_characters   = var.require_uppercase_characters
  require_symbols                = var.require_symbols
  allow_users_to_change_password = var.allow_users_to_change_password
  max_password_age               = var.max_password_age
  providers = {
    aws = aws.sandbox
  }
}
*/