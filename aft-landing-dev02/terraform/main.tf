module "aws_vpc" {
  source                     = "./module/vpc"
  name                       = var.name
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
  private_subnet_tags = {
    "vpc" = "shared"
    "test" = "env"
  }
  providers = {
    aws = aws.sandbox
  }
}

# Module declaration for S3 bucket creation
module s3 {
   source                                        = "./module/s3"
}