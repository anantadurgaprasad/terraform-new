resource "aws_autoscaling_group" "bar" {
 lifecycle { create_before_destroy = true }
  desired_capacity   = "${var.desired-capacity}"
  max_size           = "${var.max-size}"
  min_size           = "${var.min-size}"

  launch_template {
    id      = "${var.lc-id}"
    version = "$Latest"
  }
  
  health_check_type = "ELB"
}
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.bar.id
  lb_target_group_arn                    = "${var.tg-arn}"
}