#Resource creation for VPC
resource "aws_vpc" "vpc" {
   count                                = length(var.vpc_name)
   cidr_block                           = element(var.vpc_cidr, count.index)
   instance_tenancy                     = var.instance_tenancy
   enable_dns_support                   = var.enable_dns_support
   enable_dns_hostnames                 = var.enable_dns_hostnames
   assign_generated_ipv6_cidr_block     = var.assign_generated_ipv6_cidr_block
   tags                                 = {
     Name                               = element(var.vpc_name, count.index)
   }
}