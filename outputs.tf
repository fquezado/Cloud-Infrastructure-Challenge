output "ec2_private_ip" {
  description = "The private IP of the EC2 instance"
  value       = aws_instance.ec2_instance.private_ip
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.alb.dns_name
}

output "alb_https_url" {
  description = "HTTPS URL for the application"
  value       = "https://${aws_lb.alb.dns_name}"
}
