resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.private_subnet[0].id // Using one of two private subnets created.

  tags = {
    Name = "EC2Instance"
  }
}
