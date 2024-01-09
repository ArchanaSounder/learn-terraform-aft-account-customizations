# Module declaration for vpc
module "vpc" {
  source                                         = "./module/vpc"
  vpc_name                                       = var.vpc_name
  vpc_cidr                                       = var.vpc_cidr
  instance_tenancy                               = var.instance_tenancy
  assign_generated_ipv6_cidr_block               = var.assign_generated_ipv6_cidr_block
  enable_dns_hostnames                           = var.enable_dns_hostnames
  enable_dns_support                             = var.enable_dns_support
 
}

# Module declaration for S3 bucket creation
module s3 {
   source                                        = "./module/s3"
}