resource "aws_launch_template" "project2_launch_template" {
  name = "${var.launch_template_name}-template-${var.environment}"

  image_id      = data.aws_ami.app.id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    var.security_group_id
  ]

  iam_instance_profile {
    name = var.instance_profile_name
  }

  # Enforce IMDSv2 (SSRF hardening)
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  user_data = base64encode(file("${path.module}/userdata.sh"))

  # Tags on the launch template resource itself (does NOT reach instances/volumes)
  tags = var.common_tags

  # Tags that actually reach the instances and volumes launched from this template
  tag_specifications {
    resource_type = "instance"
    tags = merge(var.common_tags, {
      Name = "${var.launch_template_name}-ec2-${var.environment}"
    })
  }

  tag_specifications {
    resource_type = "volume"
    tags = merge(var.common_tags, {
      Name = "${var.launch_template_name}-${var.environment}-volume"
    })
  }

  lifecycle {
    create_before_destroy = true
  }
}
