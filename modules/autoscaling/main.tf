resource "aws_autoscaling_group" "asg" {
  name = "${var.asg_name}-asg-${var.environment}"

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  # where the instances will be launched
  vpc_zone_identifier = var.private_subnets

  # the target group to attach to the ASG
  target_group_arns = [
    var.target_group_arn
  ]

  # first we need to specify the launch template to use for the instances in the ASG
  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  health_check_type          = "ELB"

  # After launching a new EC2 instance, wait 60 seconds before checking if it's healthy.
  health_check_grace_period  = 60

  # Roll instances automatically when the launch template changes
  # (new AMI, new instance type, etc.)
  instance_refresh {
    strategy = "Rolling" # one by one not at all
    preferences {
      min_healthy_percentage = 90 # at least 90% must be healthy before moving to the next instance
      instance_warmup        = 60 # wait 60 seconds before checking if the new instance is healthy
    }
  }

  tag {
    key                 = "Name"
    value               = "${var.asg_name}-asg-${var.environment}"
    propagate_at_launch =  false #apply this tag to every instance launched by this ASG
  }

  # Propagate all common tags (Project, Environment, ManagedBy, ...) to every
  # instance launched by this ASG.
  dynamic "tag" {
    for_each = var.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = false
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Target-tracking scaling policy on average CPU utilization.
resource "aws_autoscaling_policy" "cpu_target_tracking" {
  name                   = "${var.asg_name}-cpu-target-tracking-${var.environment}"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.cpu_target_value
  }
}
