terraform {
  source = "git::https://git.aws.platform.vpbank.dev/platform/misc/demo-security/terraform-demo-sec.git"
  #source = "../"
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------
inputs = {
    aws_region     = "ap-southeast-1"
    master_prefix  = "dev"
    image_id       = "ami-05b2dbde43603d503"
    key_name       = "bastion"
    vpc_id         = "vpc-123456abcdf"
    subnet_ids     = ["subnet-112233b", "subnet-778855d"]
    instance_count = 2
    instance_type  = "t4g.small"
    instance_name  = "bastion"
    root_block_device_mappings = [
    {
      volume_type = "gp3"
      volume_size = 30
      encrypted   = false
      kms_key_id  = null
    }
    ]
    associate_public_ip_address = true
    security_groups = {
      internal = {
        rules = {
          all_outbound = {
            description = "Permit All traffic outbound"
            type        = "egress", from_port = "0", to_port = "0", protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]
          }
          health_probe = {
            description = "Permit Port 22"
            type        = "ingress", from_port = "22", to_port = "22", protocol = "tcp"
            cidr_blocks = [
              "10.0.0.0/8", "10.0.0.0/8"
            ]
          }
        }
      }
     }
}
