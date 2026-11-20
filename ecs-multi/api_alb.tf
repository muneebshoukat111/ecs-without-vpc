# ---------- Load balancer for the API service ----------

resource "aws_security_group" "api_alb" {
  name   = "${var.name}-api-alb-sg"
  vpc_id = local.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "api" {
  name               = "${var.name}-api-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.api_alb.id]
  subnets            = local.subnet_ids
}

resource "aws_lb_target_group" "api" {
  name        = "${var.name}-api-tg"
  port        = var.api_port
  protocol    = "HTTP"
  vpc_id      = local.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "api" {
  load_balancer_arn = aws_lb.api.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }
}
