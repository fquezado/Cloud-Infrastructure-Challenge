# Cloud Infrastructure Challenge

Terraform configuration that deploys:

- A VPC (10.0.0.0/16) with two public and two private subnets across two availability zones
  - us-east-1a and us-east-1b
- An internet-facing Application Load Balancer
- A private EC2 instance running Nginx
- Security groups restricting EC2 web traffic to the ALB
- HTTP-to-HTTPS redirection using a self-signed certificate (TLS)
- NAT gateways for outbound access from the private subnets in order to download packages and updates

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

The deployment will remain available through Saturday, September 5, 2026, due to me this on my private AWS account.

Because the exercise uses a self-signed certificate, browsers will display a certificate warning!!

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

The `-k` option allows `curl` to connect using the self-signed certificate.

## Assumptions

- Resources are deployed in `us-east-1`.
- Two NAT gateways provide outbound access from each private subnet.
- A single EC2 instance is used as required by the exercise and deployed on ONE of the private subnets.
- SSH is restricted to the VPC CIDR, and no public SSH access is configured.
- Terraform state is stored locally and MUST NOT be committed to Git for security reasons.

## Cleanup

```bash
terraform destroy -var-file="dv.tfvars"
```
