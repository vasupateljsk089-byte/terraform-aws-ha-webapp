data "aws_ami" "app" {
  most_recent = true

  owners = ["self"]

  filter {
    name   = "name"
    values = ["${var.ami_name}"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}
