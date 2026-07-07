variable "asg_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "target_group_arn" {
  type = string
}

variable "launch_template_id" {
  type = string
}

variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "min_size" {
  type    = number
  default = 1
}

variable "max_size" {
  type    = number
  default = 3
}

variable "desired_capacity" {
  type    = number
  default = 2
}

variable "cpu_target_value" {
  description = "Target average CPU utilization (%) for the target-tracking scaling policy"
  type        = number
  default     = 60
}