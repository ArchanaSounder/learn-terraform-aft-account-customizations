resource "aws_vpc" "vpc" {
  count = var.create_vpc ? 1 : 0

  cidr_block           = var.primary_cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    { "Name" = var.vpc-name },
    var.tags,
    var.vpc_tags,
  )
}

resource "aws_subnet" "private" {
  count            = var.create_vpc && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  vpc_id            = aws_vpc.vpc[0].id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  tags = merge(
    {
      Name = var.private_subnet_names[count.index]
    },
    var.tags,
    var.private_subnet_tags,
  )
}

resource "aws_network_acl" "private" {
  count = var.create_vpc ? 1 : 0
  vpc_id     = aws_vpc.vpc[0].id
  subnet_ids = aws_subnet.private[*].id
  tags = merge(
    { "Name" = "${var.vpc-name}-acl" },
    var.tags,
    var.private_acl_tags,
  )
}

resource "aws_network_acl_rule" "private_inbound" {
  count            = var.create_vpc ? length(local.default_nacl_inbound) : 0
  network_acl_id   = aws_network_acl.private[0].id
  egress           = false
  rule_number      = local.default_nacl_inbound[count.index]["rule_number"]
  rule_action      = local.default_nacl_inbound[count.index]["rule_action"]
  from_port        = lookup(local.default_nacl_inbound[count.index], "from_port", null)
  to_port          = lookup(local.default_nacl_inbound[count.index], "to_port", null)
  protocol         = local.default_nacl_inbound[count.index]["protocol"]
  cidr_block       = lookup(local.default_nacl_inbound[count.index], "cidr_block", null)
}

resource "aws_network_acl_rule" "private_outbound" {
  count            = var.create_vpc ? length(local.default_nacl_outbound) : 0
  network_acl_id   = aws_network_acl.private[0].id
  egress           = true
  rule_number      = local.default_nacl_outbound[count.index]["rule_number"]
  rule_action      = local.default_nacl_outbound[count.index]["rule_action"]
  from_port        = lookup(local.default_nacl_outbound[count.index], "from_port", null)
  to_port          = lookup(local.default_nacl_outbound[count.index], "to_port", null)
  protocol         = local.default_nacl_outbound[count.index]["protocol"]
  cidr_block       = lookup(local.default_nacl_outbound[count.index], "cidr_block", null)
}

resource "aws_route_table" "private-rt" {
  count            = var.create_vpc ? 1 : 0
  vpc_id           = aws_vpc.vpc[0].id
  dynamic "route" {
    for_each       = var.private_route_table_routes
    content {
      # One of the following destinations must be provided
      cidr_block = route.value.cidr_block

      # One of the following targets must be provided
      egress_only_gateway_id    = lookup(route.value, "egress_only_gateway_id", null)
      gateway_id                = lookup(route.value, "gateway_id", null)
      #instance_id               = lookup(route.value, "instance_id", null)
      nat_gateway_id            = lookup(route.value, "nat_gateway_id", null)
      network_interface_id      = lookup(route.value, "network_interface_id", null)
      transit_gateway_id        = lookup(route.value, "transit_gateway_id", null)
      vpc_endpoint_id           = lookup(route.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null)
    }
  }
  tags = merge(
    { "Name" = "${var.vpc-name}-rt" },
    var.tags,
  )
}

resource "aws_route_table_association" "private-rt" {
  count          = var.create_vpc && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private-rt[0].id
}

locals {
  default_nacl_inbound = distinct(concat([
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 20
      to_port     = 20
      protocol    = "tcp"
      cidr_block  = aws_vpc.vpc[0].cidr_block
    },
    {
      rule_number = 110
      rule_action = "allow"
      from_port   = 21
      to_port     = 21
      protocol    = "tcp"
      cidr_block  = aws_vpc.vpc[0].cidr_block
    },
    {
      rule_number = 120
      rule_action = "allow"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = aws_vpc.vpc[0].cidr_block
    },
    {
      rule_number = 130
      rule_action = "allow"
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
      cidr_block  = aws_vpc.vpc[0].cidr_block
    },
    {
      rule_number = 140
      rule_action = "allow"
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
      cidr_block  = aws_vpc.vpc[0].cidr_block
    },
    {
      rule_number = 11
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_block  = "0.0.0.0/0"
    }
  ], var.private_inbound_acl_rules))
  default_nacl_outbound = distinct(concat([
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 20
      to_port     = 20
      protocol    = "tcp"
      cidr_block  = aws_vpc.vpc[0].cidr_block
    },
    {
      rule_number = 110
      rule_action = "allow"
      from_port   = 21
      to_port     = 21
      protocol    = "tcp"
      cidr_block  = aws_vpc.vpc[0].cidr_block
    },
    {
      rule_number = 120
      rule_action = "allow"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = aws_vpc.vpc[0].cidr_block
    },
    {
      rule_number = 130
      rule_action = "allow"
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
      cidr_block  = aws_vpc.vpc[0].cidr_block
    },
    {
      rule_number = 140
      rule_action = "allow"
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
      cidr_block  = aws_vpc.vpc[0].cidr_block
    },
    {
      rule_number = 10
      rule_action = "allow"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number = 11
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_block  = "0.0.0.0/0"
    }
  ], var.private_outbound_acl_rules))
}