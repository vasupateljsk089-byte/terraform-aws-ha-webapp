variable "ami_name" {
  type = string
}

variable "launch_template_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "instance_profile_name" {
  type = string
}