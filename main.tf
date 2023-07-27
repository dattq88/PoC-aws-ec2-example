resource "aws_instance" "ec2_instance" {
  count                                = local.create ? var.instance_count : 0
  ami                                  = var.image_id
  iam_instance_profile                 = local.iam_instance_profile_name
  instance_type                        = var.instance_type
  key_name                             = var.key_name
  associate_public_ip_address          = var.associate_public_ip_address
  private_ip                           = length(var.private_ip) == var.instance_count ? var.private_ip[count.index] : null
  availability_zone                    = var.availability_zone
  subnet_id                            = length(var.subnet_ids) > 0 ? tolist(var.subnet_ids)[count.index] : ""
  user_data                            = var.user_data != null ? var.user_data : local.user_data
  vpc_security_group_ids               = compact(concat(var.vpc_security_group_ids, [for k, v in aws_security_group.security_group : v.id]))
  disable_api_termination              = var.disable_api_termination
  user_data_base64                     = var.user_data_base64
  ebs_optimized                        = var.ebs_optimized
  get_password_data                    = var.get_password_data
  monitoring                           = var.monitoring
  hibernation                          = var.hibernation
  cpu_core_count                       = var.cpu_core_count
  cpu_threads_per_core                 = var.cpu_threads_per_core
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  placement_group                      = var.placement_group

  tags = merge(
    var.additional_tags,
    {
      Name = format("%s-%s-%s", var.master_prefix, var.instance_name, count.index + 1)
    }
  )

  dynamic "root_block_device" {
    for_each = var.root_block_device_mappings
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(root_block_device.value, "encrypted", true)
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
      throughput            = lookup(root_block_device.value, "throughput", null)
      tags = merge(
        var.additional_tags,
        {
          Name = format("%s-%s-%s", var.master_prefix, var.instance_name, count.index + 1)
        }
      )
    }
  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device_mappings
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
      throughput            = lookup(ebs_block_device.value, "throughput", null)
      tags = merge(
        var.additional_tags,
        {
          Name = format("%s-%s-%s-Volume-%s", var.master_prefix, var.instance_name, count.index + 1, ebs_block_device.key + 1)
        }
      )
    }
  }

  dynamic "ephemeral_block_device" {
    for_each = var.ephemeral_block_device
    content {
      device_name  = ephemeral_block_device.value.device_name
      no_device    = lookup(ephemeral_block_device.value, "no_device", null)
      virtual_name = lookup(ephemeral_block_device.value, "virtual_name", null)
    }
  }

  dynamic "metadata_options" {
    for_each = var.metadata_options != null ? [var.metadata_options] : []
    content {
      http_endpoint               = lookup(metadata_options.value, "http_endpoint", "enabled")
      http_tokens                 = lookup(metadata_options.value, "http_tokens", "optional")
      http_put_response_hop_limit = lookup(metadata_options.value, "http_put_response_hop_limit", "1")
      instance_metadata_tags      = lookup(metadata_options.value, "instance_metadata_tags", null)
    }
  }

  dynamic "network_interface" {
    for_each = var.network_interface

    content {
      device_index          = network_interface.value.device_index
      network_interface_id  = lookup(network_interface.value, "network_interface_id", null)
      delete_on_termination = lookup(network_interface.value, "delete_on_termination", false)
    }
  }

  dynamic "launch_template" {
    for_each = var.launch_template != null ? [var.launch_template] : []
    content {
      id      = lookup(var.launch_template, "id", null)
      name    = lookup(var.launch_template, "name", null)
      version = lookup(var.launch_template, "version", null)
    }
  }

  enclave_options {
    enabled = var.enclave_options_enabled
  }

  timeouts {
    create = var.timeouts.create
    update = var.timeouts.update
    delete = var.timeouts.delete
  }

}
