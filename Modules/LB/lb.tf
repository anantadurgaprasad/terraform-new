resource "aws_lb" "load_balancer" {
  name               = "${var.lb-name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = "${var.lb-sg}"
  subnets            = "${var.lb-subnets}"



  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "test" {
  name     = "${var.tg-name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc-id}"
}

resource "aws_lb_listener" "test" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}