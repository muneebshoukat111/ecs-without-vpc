# ---------- Load balancer for the WEB service ----------

resource "aws_security_group" "web_alb" {
  name   = "${var.name}-web-alb-sg"
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

resource "aws_lb" "web" {
  name               = "${var.name}-web-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_alb.id]
  subnets            = local.subnet_ids
}

resource "aws_lb_target_group" "web" {
  name        = "${var.name}-web-tg"
  port        = var.web_port
  protocol    = "HTTP"
  vpc_id      = local.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}
