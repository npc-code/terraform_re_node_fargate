data "aws_route53_zone" "main_zone" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "alb_endpoint" {
  zone_id = data.aws_route53_zone.main_zone.id  
  name    = var.url
  type    = "A"

  alias {
    name                   = aws_alb.app_alb.dns_name
    zone_id                = aws_alb.app_alb.zone_id
    evaluate_target_health = true
  }
}

#going to add in all the route53 stuff here, including ACM stuff.
resource "aws_acm_certificate" "cert_request" {
  domain_name               = var.url
  validation_method         = "DNS"

  tags = {
    Name : "alb endpoint"
  }

  lifecycle {
    create_before_destroy = true
  }
  depends_on = [aws_alb.app_alb]
}

resource "aws_route53_record" "validation_record" {
  #depends_on = [aws_alb.app_alb, aws_acm_certificate.cert_request]
  for_each = {
    for dvo in aws_acm_certificate.cert_request.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } 
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main_zone.id
#  zone_id = aws_alb.app_alb.zone_id
}