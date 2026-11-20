# ECS Multi - Commands

Run from inside the `ecs-multi` folder.

## Setup
```bash
aws configure
aws sts get-caller-identity
terraform init
terraform validate
```

## Default VPC
This project uses your account's default VPC automatically.
If you don't have one:
```bash
aws ec2 create-default-vpc --region us-east-1
aws ec2 describe-vpcs --filters "Name=isDefault,Values=true" --query "Vpcs[*].VpcId"
```

## Create everything
```bash
terraform plan
terraform apply
terraform output
```

## Create one by one

```bash
# Shared
terraform apply -target=aws_ecs_cluster.this
terraform apply -target=aws_iam_role.exec
terraform apply -target=aws_iam_role_policy_attachment.exec

# WEB service (own load balancer)
terraform apply -target=aws_security_group.web_alb
terraform apply -target=aws_lb.web
terraform apply -target=aws_lb_target_group.web
terraform apply -target=aws_lb_listener.web
terraform apply -target=aws_security_group.web_task
terraform apply -target=aws_ecs_task_definition.web
terraform apply -target=aws_ecs_service.web

# API service (own load balancer)
terraform apply -target=aws_security_group.api_alb
terraform apply -target=aws_lb.api
terraform apply -target=aws_lb_target_group.api
terraform apply -target=aws_lb_listener.api
terraform apply -target=aws_security_group.api_task
terraform apply -target=aws_ecs_task_definition.api
terraform apply -target=aws_ecs_service.api

# Final check
terraform apply
```

## Create only one service
```bash
terraform apply -target=aws_ecs_service.web
terraform apply -target=aws_ecs_service.api
```

## Test
```bash
terraform output web_url
terraform output api_url
```

## Check ECS
```bash
aws ecs list-services --cluster multi-cluster --region us-east-1

aws ecs describe-services --cluster multi-cluster \
  --services multi-web-service multi-api-service --region us-east-1 \
  --query "services[*].{name:serviceName,running:runningCount,desired:desiredCount}"
```

## Change settings
```bash
terraform apply -var="web_desired_count=1"
terraform apply -var="api_image=nginx:latest"
terraform apply -var="name=test"
```

## Delete one service only
```bash
terraform destroy -target=aws_ecs_service.api
terraform destroy -target=aws_ecs_task_definition.api
terraform destroy -target=aws_lb_listener.api
terraform destroy -target=aws_lb_target_group.api
terraform destroy -target=aws_lb.api
terraform destroy -target=aws_security_group.api_task
terraform destroy -target=aws_security_group.api_alb
```

## Delete everything
```bash
terraform destroy
```
(The default VPC and its subnets are not touched; Terraform does not manage them.)
