project_name = "webapp"
environment  = "dev"
aws_region   = "ap-south-1"

ami_name      = "Goldan image"
instance_type = "t3.micro"

asg_min_size         = 1
asg_max_size         = 3
asg_desired_capacity = 2
asg_cpu_target_value = 60
