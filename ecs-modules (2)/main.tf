# ---------- Shared: cluster + IAM role ----------
module "cluster" {
  source = "./modules/cluster"

  name = var.name
}

# ---------- WEB service (own load balancer) ----------
module "web_alb" {
  source = "./modules/alb"

  name           = "${var.name}-web"
  vpc_id         = data.aws_vpc.default.id
  subnet_ids     = data.aws_subnets.default.ids
  container_port = var.container_port
}

module "web_service" {
  source = "./modules/service"

  name                  = "${var.name}-web"
  cluster_id            = module.cluster.cluster_id
  execution_role_arn    = module.cluster.execution_role_arn
  vpc_id                = data.aws_vpc.default.id
  subnet_ids            = data.aws_subnets.default.ids
  alb_security_group_id = module.web_alb.security_group_id
  target_group_arn      = module.web_alb.target_group_arn
  image                 = var.web_image
  container_port        = var.container_port
  cpu                   = var.cpu
  memory                = var.memory
  desired_count         = var.desired_count

  depends_on = [module.web_alb]
}

# ---------- API service (own load balancer) ----------
module "api_alb" {
  source = "./modules/alb"

  name           = "${var.name}-api"
  vpc_id         = data.aws_vpc.default.id
  subnet_ids     = data.aws_subnets.default.ids
  container_port = var.container_port
}

module "api_service" {
  source = "./modules/service"

  name                  = "${var.name}-api"
  cluster_id            = module.cluster.cluster_id
  execution_role_arn    = module.cluster.execution_role_arn
  vpc_id                = data.aws_vpc.default.id
  subnet_ids            = data.aws_subnets.default.ids
  alb_security_group_id = module.api_alb.security_group_id
  target_group_arn      = module.api_alb.target_group_arn
  image                 = var.api_image
  container_port        = var.container_port
  cpu                   = var.cpu
  memory                = var.memory
  desired_count         = var.desired_count

  depends_on = [module.api_alb]
}
