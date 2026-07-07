#-------------------------------- VPC----------------------------#
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

# ------------------------- SG ---------------------------------#
output "alb_security_group_id" {
    value = module.security_group.alb_security_group_id
}

output "ec2_security_group_id" {
    value = module.security_group.ec2_security_group_id
}

# ------------------------- ALB ---------------------------------#
output "alb_arn" {
  value = module.alb.alb_arn
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "target_group_arn" {
  value = module.alb.target_group_arn
}

# ------------------------- Launch Template ---------------------------------#
output "ami-id" {
  value = module.launch_template.ami-id
}

output "launch_template_id" {
  value = module.launch_template.launch_template_id
}

# ------------------------- IAM ---------------------------------#
output "instance_profile_name" {
  value = module.iam.instance_profile_name
}

output "instance_profile_arn" {
  value = module.iam.instance_profile_arn
}

output "role_name" {
  value = module.iam.role_name
}

