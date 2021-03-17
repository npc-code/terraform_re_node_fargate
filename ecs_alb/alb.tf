resource "aws_alb" "app_alb" {
  name            = "${var.cluster_name}-alb"
  subnets         = var.subnets
  security_groups = [aws_security_group.alb_sg.id]

  tags = {
    Name        = "${var.cluster_name}-alb"
    Environment = var.cluster_name
  }
}

resource "aws_alb_target_group" "api_target_group" {
  name_prefix = substr(var.cluster_name, 0, 6)
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    path = var.health_check_path
    port = var.container_port
    timeout = 29
  }

  depends_on = [aws_alb.app_alb]
}

resource "aws_alb_listener" "http_forward" {
  load_balancer_arn = aws_alb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "web_app_https" {
  load_balancer_arn = aws_alb.app_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn = aws_acm_certificate.cert_request.arn
  ssl_policy = "ELBSecurityPolicy-2016-08"
  depends_on        = [aws_alb_target_group.api_target_group]

  lifecycle {
    create_before_destroy = true
  }

  default_action {
    target_group_arn = aws_alb_target_group.api_target_group.arn
    type             = "forward"
  }
}
