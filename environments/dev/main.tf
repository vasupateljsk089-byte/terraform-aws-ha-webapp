module "vpc" {
  source = "../../modules/vpc"
  
  project_name = var.project_name
  environment  = var.environment
  common_tags  = local.common_tags
}

module "security_group" {
  source = "../../modules/security-group"

  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
  environment  = var.environment
  common_tags  = local.common_tags
}

module "alb" {
  source = "../../modules/alb"

  alb_name = var.project_name
  environment  = var.environment
  common_tags  = local.common_tags

  vpc_id  = module.vpc.vpc_id
  # ALB security group id
  security_group_id = module.security_group.alb_security_group_id 
  # Public subnets for the ALB
  subnets = module.vpc.public_subnets
}

module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  environment  = var.environment
  common_tags  = local.common_tags
}

module "launch_template" {
  source = "../../modules/launch-template"

  launch_template_name = var.project_name
  environment          = var.environment
  common_tags          = local.common_tags

  ami_name              = var.ami_name
  instance_type         = var.instance_type
  security_group_id     = module.security_group.ec2_security_group_id
  instance_profile_name = module.iam.instance_profile_name
}

module "autoscaling" {
  source = "../../modules/autoscaling"

  asg_name    = var.project_name
  environment = var.environment
  common_tags = local.common_tags

  min_size          = var.asg_min_size
  max_size          = var.asg_max_size
  desired_capacity  = var.asg_desired_capacity
  cpu_target_value  = var.asg_cpu_target_value

  private_subnets = module.vpc.private_subnets

  launch_template_id = module.launch_template.launch_template_id

  target_group_arn = module.alb.target_group_arn
}