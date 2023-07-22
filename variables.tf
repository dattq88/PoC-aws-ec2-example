################################################################################
# EC2 Instance Variables
################################################################################
variable "create_ec2" {
  default     = true
  type        = bool
  description = "A boolean flag to create EC2 instance"
  validation {
    condition     = contains([true, false], var.create_ec2)
    error_message = "Valid values for variable: create_ec2 are `true`, `false`."
  }
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address with the instance"
  default     = false
  validation {
    condition     = contains([true, false], var.associate_public_ip_address)
    error_message = "Valid values for variable: associate_public_ip_address are `true`, `false`."
  }
}

variable "instance_name" {
  type        = string
  description = "Name to be used on EC2 instance created"
  default     = null
  validation {
    condition     = length(var.instance_name) > 0
    error_message = "Valid values for variable: instance_name cannot be empty."
  }
}

variable "image_id" {
  type        = string
  description = "The AMI to use for the instance."
  validation {
    condition     = length(var.image_id) > 0
    error_message = "Valid values for variable: image_id cannot be empty."
  }
}

variable "instance_count" {
  type        = number
  default     = 1
  description = "Number of instance to deploy"
  validation {
    condition     = var.instance_count >= 0
    error_message = "Valid values for variable: instance_count must be greater than 0."
  }
}

variable "instance_type" {
  type        = string
  description = "The type of instance to start"
  default     = "t4g.micro"
  validation {
    condition     = length(var.instance_type) > 0
    error_message = "Valid values for variable: instance_type cannot be empty."
  }
}

variable "availability_zone" {
  description = "AZ to start the instance in"
  type        = string
  default     = null
}

variable "user_data_base64" {
  type        = string
  description = "Can be used instead of `user_data` to pass base64-encoded binary data directly. Use this instead of `user_data` whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption"
  default     = null
}

variable "user_data" {
  type        = string
  description = "Can be used instead of `user_data` to pass base64-encoded binary data directly. Use this instead of `user_data` whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption"
  default     = null
}

variable "bootstrap_options" {
  description = "Bootstrap options to put into userdata"
  type        = list(string)
  default     = []
}

variable "key_name" {
  type        = string
  description = "Key name of the Key Pair to use for the instance."
  validation {
    condition     = length(var.key_name) > 0
    error_message = "Valid values for variable: key_name cannot be empty."
  }
}

variable "private_ip" {
  type        = list(string)
  description = "Private IP address to associate with the instance in the VPC"
  default     = []
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Additional security group IDs to apply to the cluster, in addition to the provisioned default security group with ingress traffic from existing CIDR blocks and existing security groups"
  default     = []
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = null
}

variable "enclave_options_enabled" {
  description = "Whether Nitro Enclaves will be enabled on the instance. Defaults to `false`"
  type        = bool
  default     = null
}

variable "ephemeral_block_device" {
  description = "Customize Ephemeral (also known as Instance Store) volumes on the instance"
  type        = list(map(string))
  default     = []
}

variable "get_password_data" {
  description = "If true, wait for password data to become available and retrieve it."
  type        = bool
  default     = null
}

variable "hibernation" {
  description = "If true, the launched EC2 instance will support hibernation"
  type        = bool
  default     = null
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance. Amazon defaults this to stop for EBS-backed instances and terminate for instance-store instances. Cannot be set on instance-store instance" # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#Using_ChangingInstanceInitiatedShutdownBehavior
  type        = string
  default     = null
}

variable "launch_template" {
  description = "Specifies a Launch Template to configure the instance. Parameters configured on this resource will override the corresponding parameters in the Launch Template"
  type        = map(string)
  default     = null
}

variable "metadata_options" {
  description = "Customize the metadata options of the instance"
  type        = map(string)
  default     = {}
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  type        = bool
  default     = null
}

variable "cpu_threads_per_core" {
  description = "Sets the number of CPU threads per core for an instance (has no effect unless cpu_core_count is also set)."
  type        = number
  default     = null
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = false
  validation {
    condition     = contains([true, false], var.monitoring)
    error_message = "Valid values for variable: monitoring are `true`, `false`."
  }
}

variable "timeouts" {
  description = "Define maximum timeout for creating, updating, and deleting EC2 instance resources"
  type = object({
    create = optional(string, "10m")
    update = optional(string, "10m")
    delete = optional(string, "10m")
  })
  default = {}
}

variable "cpu_core_count" {
  description = "Sets the number of CPU cores for an instance." # This option is only supported on creation of instance type that support CPU Options https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-optimize-cpu.html#cpu-options-supported-instances-values
  type        = number
  default     = null
}

variable "network_interface" {
  description = "Customize network interfaces to be attached at instance boot time"
  type        = list(map(string))
  default     = []
}

variable "placement_group" {
  description = "The Placement Group to start the instance in"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "A list of subnets to assign to EC2. e.g. ['subnet-1a2b3c4d','subnet-1a2b3c4e','subnet-1a2b3c4f']"
  type        = list(string)
  default     = []
}

########## Root Volume Attachment Variables ##########
variable "root_block_device_mappings" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  type        = list(map(string))
  default     = []
}

########## EBS Volume Attachment Variables ##########
variable "ebs_block_device_mappings" {
  description = "Additional EBS block devices to attach to the instance"
  type        = list(any)
  default     = []
}

variable "subnet_by_tag" {
  description = "Tag Name of subnet to get list of subnets."
  type        = string
  default     = null
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where Security Group will be created."
  default     = null
  validation {
    condition     = can(regex("^vpc-", var.vpc_id))
    error_message = "Valid values for variable: must be a valid VPC Id. (ex: vpc-2f09a348)"
  }
}

################################################################################
# Route53 group
################################################################################

variable "create_dns" {
  default     = false
  type        = bool
  description = "A boolean flag to add record to route53"
  validation {
    condition     = contains([true, false], var.create_dns)
    error_message = "Valid values for variable: create_dns are `true`, `false`."
  }
}

variable "record_name" {
  type        = string
  description = "Name of the A record to create"
  default     = null
  validation {
    condition     = var.record_name != null ? can(regex("^[a-zA-Z0-9-]+$", var.record_name)) : true
    error_message = "Valid values for variable: record_name cannot be empty."
  }
}

variable "dns_zone_id" {
  type        = string
  description = "Route53 DNS Zone ID."
  default     = null
  validation {
    condition     = var.dns_zone_id != null ? can(regex("([a-zA-Z0-9\\-])+", var.dns_zone_id)) : true
    error_message = "Valid values for variable: dns_zone_id cannot be empty."
  }
}

variable "dns_zone_ttl" {
  type        = number
  default     = 60
  description = "The TTL of the record."
  validation {
    condition     = var.dns_zone_ttl > 0
    error_message = "Valid values for variable: dns_zone_ttl must be greater than 0."
  }
}

################################################################################
# IAM Role / Instance Profile
################################################################################

variable "create_iam_instance_profile" {
  description = "Determines whether an IAM instance profile is created or to use an existing IAM instance profile"
  type        = bool
  default     = false
}

variable "iam_instance_profile_name" {
  description = "The name of the IAM instance profile to be created (`create_iam_instance_profile` = `true`) or existing (`create_iam_instance_profile` = `false`)"
  type        = string
  default     = null
}

variable "iam_role_path" {
  description = "IAM role path"
  type        = string
  default     = null
}

variable "iam_role_description" {
  description = "Description of the role"
  type        = string
  default     = null
}

variable "iam_role_permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the IAM role"
  type        = string
  default     = null
}

variable "iam_role_policies" {
  description = "IAM policies to attach to the IAM role"
  type        = map(string)
  default     = {}
}

variable "iam_role_tags" {
  description = "A map of additional tags to add to the IAM role created"
  type        = map(string)
  default     = {}
}

variable "custom_policy" {
  type        = string
  default     = null
  description = "The policy document. This is a JSON formatted string."
}

################################################################################
# Common Variables
################################################################################

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "additional_tags" {
  description = "Tags to add to the security group resource."
  type        = map(string)
  default     = {}
}

variable "master_prefix" {
  description = "To specify a key prefix for aws resource"
  type        = string
  default     = "dso"
  validation {
    condition     = can(regex("^[a-zA-Z0-9-]+$", var.master_prefix))
    error_message = "Valid values for variable: master_prefix cannot be empty."
  }
}

variable "aws_region" {
  description = "AWS Region name to deploy resources."
  type        = string
  default     = "ap-southeast-1"
  validation {
    condition     = can(regex("^[a-zA-Z0-9-]+$", var.aws_region))
    error_message = "Valid values for variable: must be valid AWS Region names. (ex: ap-southeast-1)"
  }
}

variable "assume_role" {
  description = "AssumeRole to manage the resources within account that owns"
  type        = string
  default     = null
  validation {
    condition     = var.assume_role != null ? can(regex("^arn:aws:iam::[[:digit:]]{12}:role/.+", var.assume_role)) : true
    error_message = "Valid values for variable: must be a valid AWS IAM role ARN. (ex: arn:aws:iam::111122223333:role/AWSAFTExecution)"
  }
}

################################################################################
# Security Variables
################################################################################
variable "create_security_group" {
  type        = bool
  default     = true
  description = "A boolean flag to determine whether to create Security Group."
  validation {
    condition     = contains([true, false], var.create_security_group)
    error_message = "Valid values for variable: create_security_group are `true`, `false`."
  }
}

variable "security_group_name" {
  description = "Name of the security group."
  type        = string
  default     = null
}

variable "security_groups" {
  description = <<EOF
  The `security_groups` variable is a map of maps, where each map represents an AWS Security Group.
  The key of each entry acts as the Security Group name.
  List of available attributes of each Security Group entry:
  - `rules`: A list of objects representing a Security Group rule. The key of each entry acts as the name of the rule and
      needs to be unique across all rules in the Security Group.
      List of attributes available to define a Security Group rule:
      - `description`: Security Group description.
      - `type`: Specifies if rule will be evaluated on ingress (inbound) or egress (outbound) traffic.
      - `cidr_blocks`: List of CIDR blocks - for ingress, determines the traffic that can reach your instance. For egress
      Determines the traffic that can leave your instance, and where it can go.


  Example:
  ```
  security_groups = {
    mgmt = {
      name = "mgmt"
      rules = {
        all-outbound = {
          description = "Permit All traffic outbound"
          type        = "egress", from_port = "0", to_port = "0", protocol = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
        https-inbound = {
          description = "Permit HTTPS"
          type        = "ingress", from_port = "443", to_port = "443", protocol = "tcp"
          cidr_blocks = ["10.0.0.0/8"]
        }
        http-inbound = {
          description = "Permit HTTPS"
          type        = "ingress", from_port = "80", to_port = "80", protocol = "tcp"
          cidr_blocks = ["10.0.0.0/8"]
        }
        ssh-inbound-eip = {
          description = "Permit SSH"
          type        = "ingress", from_port = "22", to_port = "22", protocol = "tcp"
          cidr_blocks = ["10.0.0.0/8"]
        }
      }
    }
  }
  ```
  EOF

  default = null
  type = map(object({
    name = optional(string)
    rules = map(object({
      from_port   = string
      to_port     = string
      protocol    = string
      type        = string
      cidr_blocks = optional(list(string), null)
      description = optional(string)
      self        = optional(string)
    }))
  }))
}
