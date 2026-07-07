output "ami-id" {
  value = data.aws_ami.app.id
}

output "launch_template_id" {
  value = aws_launch_template.project2_launch_template.id
}