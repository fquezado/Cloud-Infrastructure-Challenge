variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t3.micro"
}

//variable "key_name" {
//description = "The name of the key pair for SSH access" NOT NEEDED ATM
//type        = string
//}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones (I am staying on east coast)"
  type        = list(string)
}
