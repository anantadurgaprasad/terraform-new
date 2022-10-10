resource "aws_autoscaling_group" "asg" {
#  name = "${var.env}-${var.app-name}-asg"
  desired_capacity   = "${var.desired-capacity}"
  max_size           = "${var.max-size}"
  min_size           = "${var.min-size}"
  vpc_zone_identifier = "${var.asg-subnets}"
  load_balancers = []
  launch_template {
    id      = "${var.lc-id}"
   
  }
  
  health_check_type = "ELB"
  lifecycle {
    ignore_changes=[target_group_arns]
  }
  
}
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn                    = "${var.tg-arn}"
}