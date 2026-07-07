variable "alb_name" {
  type = string
}

variable "internal" {
  type    = bool
  default = false
  description = "Whether the ALB is internal or internet-facing"
}

variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "environment" {
  type = string
}