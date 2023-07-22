# AWS EC2 Module

Terraform module which creates EC2 resources on AWS provided by Terraform AWS provider.

## Usage
```hcl
module "ec2" {
  source         = "git@github.com:examplae/ec2.git"
  aws_region     = "ap-southeast-1"
  master_prefix  = "dev"
  assume_role    = "arn:aws:iam::111222333444:role/AWSAFTExecution"
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
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.custom_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.custom_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.ec2_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_subnets.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | The AMI to use for the instance. | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Key name of the Key Pair to use for the instance. | `string` | n/a | yes |
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | Tags to add to the security group resource. | `map(string)` | `{}` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Associate a public IP address with the instance | `bool` | `false` | no |
| <a name="input_assume_role"></a> [assume\_role](#input\_assume\_role) | AssumeRole to manage the resources within account that owns | `string` | `null` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | AZ to start the instance in | `string` | `null` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region name to deploy resources. | `string` | `"ap-southeast-1"` | no |
| <a name="input_bootstrap_options"></a> [bootstrap\_options](#input\_bootstrap\_options) | Bootstrap options to put into userdata | `list(string)` | `[]` | no |
| <a name="input_cpu_core_count"></a> [cpu\_core\_count](#input\_cpu\_core\_count) | Sets the number of CPU cores for an instance. | `number` | `null` | no |
| <a name="input_cpu_threads_per_core"></a> [cpu\_threads\_per\_core](#input\_cpu\_threads\_per\_core) | Sets the number of CPU threads per core for an instance (has no effect unless cpu\_core\_count is also set). | `number` | `null` | no |
| <a name="input_create_dns"></a> [create\_dns](#input\_create\_dns) | A boolean flag to add record to route53 | `bool` | `false` | no |
| <a name="input_create_ec2"></a> [create\_ec2](#input\_create\_ec2) | A boolean flag to create EC2 instance | `bool` | `true` | no |
| <a name="input_create_iam_instance_profile"></a> [create\_iam\_instance\_profile](#input\_create\_iam\_instance\_profile) | Determines whether an IAM instance profile is created or to use an existing IAM instance profile | `bool` | `false` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | A boolean flag to determine whether to create Security Group. | `bool` | `true` | no |
| <a name="input_custom_policy"></a> [custom\_policy](#input\_custom\_policy) | The policy document. This is a JSON formatted string. | `string` | `null` | no |
| <a name="input_disable_api_termination"></a> [disable\_api\_termination](#input\_disable\_api\_termination) | If true, enables EC2 Instance Termination Protection | `bool` | `null` | no |
| <a name="input_dns_zone_id"></a> [dns\_zone\_id](#input\_dns\_zone\_id) | Route53 DNS Zone ID. | `string` | `null` | no |
| <a name="input_dns_zone_ttl"></a> [dns\_zone\_ttl](#input\_dns\_zone\_ttl) | The TTL of the record. | `number` | `60` | no |
| <a name="input_ebs_block_device_mappings"></a> [ebs\_block\_device\_mappings](#input\_ebs\_block\_device\_mappings) | Additional EBS block devices to attach to the instance | `list(any)` | `[]` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | If true, the launched EC2 instance will be EBS-optimized | `bool` | `null` | no |
| <a name="input_enclave_options_enabled"></a> [enclave\_options\_enabled](#input\_enclave\_options\_enabled) | Whether Nitro Enclaves will be enabled on the instance. Defaults to `false` | `bool` | `null` | no |
| <a name="input_ephemeral_block_device"></a> [ephemeral\_block\_device](#input\_ephemeral\_block\_device) | Customize Ephemeral (also known as Instance Store) volumes on the instance | `list(map(string))` | `[]` | no |
| <a name="input_get_password_data"></a> [get\_password\_data](#input\_get\_password\_data) | If true, wait for password data to become available and retrieve it. | `bool` | `null` | no |
| <a name="input_hibernation"></a> [hibernation](#input\_hibernation) | If true, the launched EC2 instance will support hibernation | `bool` | `null` | no |
| <a name="input_iam_instance_profile_name"></a> [iam\_instance\_profile\_name](#input\_iam\_instance\_profile\_name) | The name of the IAM instance profile to be created (`create_iam_instance_profile` = `true`) or existing (`create_iam_instance_profile` = `false`) | `string` | `null` | no |
| <a name="input_iam_role_description"></a> [iam\_role\_description](#input\_iam\_role\_description) | Description of the role | `string` | `null` | no |
| <a name="input_iam_role_path"></a> [iam\_role\_path](#input\_iam\_role\_path) | IAM role path | `string` | `null` | no |
| <a name="input_iam_role_permissions_boundary"></a> [iam\_role\_permissions\_boundary](#input\_iam\_role\_permissions\_boundary) | ARN of the policy that is used to set the permissions boundary for the IAM role | `string` | `null` | no |
| <a name="input_iam_role_policies"></a> [iam\_role\_policies](#input\_iam\_role\_policies) | IAM policies to attach to the IAM role | `map(string)` | `{}` | no |
| <a name="input_iam_role_tags"></a> [iam\_role\_tags](#input\_iam\_role\_tags) | A map of additional tags to add to the IAM role created | `map(string)` | `{}` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of instance to deploy | `number` | `1` | no |
| <a name="input_instance_initiated_shutdown_behavior"></a> [instance\_initiated\_shutdown\_behavior](#input\_instance\_initiated\_shutdown\_behavior) | Shutdown behavior for the instance. Amazon defaults this to stop for EBS-backed instances and terminate for instance-store instances. Cannot be set on instance-store instance | `string` | `null` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name to be used on EC2 instance created | `string` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of instance to start | `string` | `"t4g.micro"` | no |
| <a name="input_launch_template"></a> [launch\_template](#input\_launch\_template) | Specifies a Launch Template to configure the instance. Parameters configured on this resource will override the corresponding parameters in the Launch Template | `map(string)` | `null` | no |
| <a name="input_master_prefix"></a> [master\_prefix](#input\_master\_prefix) | To specify a key prefix for aws resource | `string` | `"dso"` | no |
| <a name="input_metadata_options"></a> [metadata\_options](#input\_metadata\_options) | Customize the metadata options of the instance | `map(string)` | `{}` | no |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | If true, the launched EC2 instance will have detailed monitoring enabled | `bool` | `false` | no |
| <a name="input_network_interface"></a> [network\_interface](#input\_network\_interface) | Customize network interfaces to be attached at instance boot time | `list(map(string))` | `[]` | no |
| <a name="input_placement_group"></a> [placement\_group](#input\_placement\_group) | The Placement Group to start the instance in | `string` | `null` | no |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | Private IP address to associate with the instance in the VPC | `list(string)` | `[]` | no |
| <a name="input_record_name"></a> [record\_name](#input\_record\_name) | Name of the A record to create | `string` | `null` | no |
| <a name="input_root_block_device_mappings"></a> [root\_block\_device\_mappings](#input\_root\_block\_device\_mappings) | Customize details about the root block device of the instance. See Block Devices below for details | `list(map(string))` | `[]` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of the security group. | `string` | `null` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | The `security_groups` variable is a map of maps, where each map represents an AWS Security Group.<br>  The key of each entry acts as the Security Group name.<br>  List of available attributes of each Security Group entry:<br>  - `rules`: A list of objects representing a Security Group rule. The key of each entry acts as the name of the rule and<br>      needs to be unique across all rules in the Security Group.<br>      List of attributes available to define a Security Group rule:<br>      - `description`: Security Group description.<br>      - `type`: Specifies if rule will be evaluated on ingress (inbound) or egress (outbound) traffic.<br>      - `cidr_blocks`: List of CIDR blocks - for ingress, determines the traffic that can reach your instance. For egress<br>      Determines the traffic that can leave your instance, and where it can go.<br><br><br>  Example:<pre>security_groups = {<br>    mgmt = {<br>      name = "mgmt"<br>      rules = {<br>        all-outbound = {<br>          description = "Permit All traffic outbound"<br>          type        = "egress", from_port = "0", to_port = "0", protocol = "-1"<br>          cidr_blocks = ["0.0.0.0/0"]<br>        }<br>        https-inbound = {<br>          description = "Permit HTTPS"<br>          type        = "ingress", from_port = "443", to_port = "443", protocol = "tcp"<br>          cidr_blocks = ["10.0.0.0/8"]<br>        }<br>        http-inbound = {<br>          description = "Permit HTTPS"<br>          type        = "ingress", from_port = "80", to_port = "80", protocol = "tcp"<br>          cidr_blocks = ["10.0.0.0/8"]<br>        }<br>        ssh-inbound-eip = {<br>          description = "Permit SSH"<br>          type        = "ingress", from_port = "22", to_port = "22", protocol = "tcp"<br>          cidr_blocks = ["10.0.0.0/8"]<br>        }<br>      }<br>    }<br>  }</pre> | <pre>map(object({<br>    name = optional(string)<br>    rules = map(object({<br>      from_port   = string<br>      to_port     = string<br>      protocol    = string<br>      type        = string<br>      cidr_blocks = optional(list(string), null)<br>      description = optional(string)<br>      self        = optional(string)<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_subnet_by_tag"></a> [subnet\_by\_tag](#input\_subnet\_by\_tag) | Tag Name of subnet to get list of subnets. | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnets to assign to EC2. e.g. ['subnet-1a2b3c4d','subnet-1a2b3c4e','subnet-1a2b3c4f'] | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Define maximum timeout for creating, updating, and deleting EC2 instance resources | <pre>object({<br>    create = optional(string, "10m")<br>    update = optional(string, "10m")<br>    delete = optional(string, "10m")<br>  })</pre> | `{}` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Can be used instead of `user_data` to pass base64-encoded binary data directly. Use this instead of `user_data` whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption | `string` | `null` | no |
| <a name="input_user_data_base64"></a> [user\_data\_base64](#input\_user\_data\_base64) | Can be used instead of `user_data` to pass base64-encoded binary data directly. Use this instead of `user_data` whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where Security Group will be created. | `string` | `null` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | Additional security group IDs to apply to the cluster, in addition to the provisioned default security group with ingress traffic from existing CIDR blocks and existing security groups | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_instance_profile_id"></a> [iam\_instance\_profile\_id](#output\_iam\_instance\_profile\_id) | Instance profile's ID |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM role |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | The name of the IAM role |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | List IDs of instances |
| <a name="output_instance_subnet_id"></a> [instance\_subnet\_id](#output\_instance\_subnet\_id) | List VPC subnets Ids of instances |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | List of private IP addresses assigned to the instances |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | List of public IP addresses assigned to the instances, if applicable |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the security group |
