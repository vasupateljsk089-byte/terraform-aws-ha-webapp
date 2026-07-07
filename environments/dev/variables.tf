variable "project_name" {
  description = "Name used as a prefix for all resources in this project"
  type        = string
  default     = "project-2"
}

variable "environment" {
  description = "Deployment environment (dev, stage, prod). Drives resource naming and sizing."
  type        = string

  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "environment must be one of: dev, stage, prod."
  }
}

variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "ap-south-1"
}

# ------------------------- Launch Template / AMI ---------------------------------#

variable "ami_name" {
  description = "Name (prefix, matched with a wildcard) of the golden-image AMI to launch instances from"
  type        = string
  default     = "Goldan image"
}

variable "instance_type" {
  description = "EC2 instance type for the launch template"
  type        = string
  default     = "t3.micro"
}

# ------------------------- Autoscaling Group ---------------------------------#

variable "asg_min_size" {
  description = "Minimum number of instances in the ASG"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum number of instances in the ASG"
  type        = number
  default     = 3
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in the ASG"
  type        = number
  default     = 2
}

variable "asg_cpu_target_value" {
  description = "Target average CPU utilization (%) for the ASG target-tracking scaling policy"
  type        = number
  default     = 60
}
