# Cloud Infrastructure Challenge

Terraform configuration that deploys:

- A VPC (10.0.0.0/16) with two public and two private subnets across two availability zones (us-east-1a, us-east-1b)
- An internet-facing Application Load Balancer
- A private EC2 instance running Nginx
- Security groups restricting EC2 web traffic to the ALB
- HTTP-to-HTTPS redirection using a self-signed certificate
- NAT gateways so the private subnets can reach package repositories at boot

## Requirements

- Terraform >= 1.5.0
- AWS credentials with permission to create the required resources
- AWS CLI configured for `us-east-1`

## Deployment

```bash
terraform init
terraform validate
terraform plan -var-file="dv.tfvars"
terraform apply -var-file="dv.tfvars"
```

## Live Demo

The application is available at:

```text
https://ec2-alb-713210429.us-east-1.elb.amazonaws.com
```

This is running in my personal AWS account and will stay up through Saturday, September 5, 2026.

The certificate is self-signed, so browsers will show a warning. That's expected.

## Verification

Retrieve the ALB hostname:

```bash
terraform output -raw alb_dns_name
```

Confirm that HTTP redirects to HTTPS:

```bash
curl -I "http://ec2-alb-713210429.us-east-1.elb.amazonaws.com"
```

Verify the Nginx page over HTTPS:

```bash
curl -k "https://ec2-alb-713210429.us-east-1.elb.amazonaws.com"
```

The `-k` flag lets `curl` connect despite the self-signed certificate.

## Assumptions and decisions

- **Region.** Everything is in `us-east-1` with the AZs hardcoded. For anything reusable I'd pull them from the `aws_availability_zones` data source instead.

- **Two NAT gateways, one per AZ**, so an AZ failure doesn't take out the other private subnet's outbound access and traffic doesn't cross zones. It costs roughly double a single gateway — one would be fine for non-prod.

- **No key pair on the instance.** It's in a private subnet with no public IP, so there's no SSH path from outside the VPC anyway. The security group rule allowing SSH from the VPC CIDR covers the requirement. For actual shell access I'd use SSM Session Manager rather than handing out keys.

- **The ALB's egress is scoped to the VPC CIDR on port 80** rather than referencing the EC2 security group directly. Two security groups referencing each other inline creates a dependency cycle in Terraform, so I used a VPC CIDR instead.

- **Applied with a dedicated IAM user**, not the account root. From CI I'd use OIDC rather than long-lived keys.

## Cleanup

MAKE SURE TO DESTROY THE RESOURCES WHEN YOU'RE DONE TO AVOID UNEXPECTED COSTS.

```bash
terraform destroy -var-file="dv.tfvars"
```
