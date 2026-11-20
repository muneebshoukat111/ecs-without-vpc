# ECS Modules - Commands

Run from inside the `ecs-modules` folder.

## Setup
```bash
aws configure
aws sts get-caller-identity
aws ec2 create-default-vpc --region us-east-1   # only if you have no default VPC
terraform init
terraform validate
```

## Create everything
```bash
terraform plan
terraform apply
terraform output
```

## Create one module at a time
```bash
terraform apply -target=module.cluster

terraform apply -target=module.web_alb
terraform apply -target=module.web_service

terraform apply -target=module.api_alb
terraform apply -target=module.api_service

terraform apply        # final check, creates outputs
```

## Test
```bash
terraform output web_url
terraform output api_url
```

## Check ECS
```bash
terraform state list

aws ecs list-services --cluster demo-cluster --region us-east-1

aws ecs describe-services --cluster demo-cluster \
  --services demo-web-service demo-api-service --region us-east-1 \
  --query "services[*].{name:serviceName,running:runningCount,desired:desiredCount}"
```

## Change settings
```bash
terraform apply -var="desired_count=1"
terraform apply -var="api_image=nginx:latest"
terraform apply -var="name=test"
```

## Delete one service (its modules)
```bash
terraform destroy -target=module.api_service
terraform destroy -target=module.api_alb
```

## Delete everything
```bash
terraform destroy
```
(The default VPC is never touched.)

## Troubleshooting
| Problem | Fix |
|---|---|
| No valid credential sources | `aws configure` |
| No default VPC | `aws ec2 create-default-vpc` |
| 503 in browser | wait 2-3 minutes for healthy tasks |
| Name already exists | `terraform apply -var="name=demo2"` |
