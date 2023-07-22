data "aws_partition" "current" {}

data "aws_subnets" "selected" {
  filter {
    name = "vpc-id"
    values = [
      var.vpc_id
    ]
  }
  tags = {
    Name = var.subnet_by_tag
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  count = local.create && var.create_iam_instance_profile ? 1 : 0

  statement {
    sid     = "EC2AssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.${data.aws_partition.current.dns_suffix}"]
    }
  }
}
