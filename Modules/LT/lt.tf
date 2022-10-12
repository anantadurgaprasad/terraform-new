resource "aws_launch_template" "lc" {
  name = "basic-lc"
  image_id = "${var.ami-id}"
  instance_type = "${var.instance-type}"
  update_default_version = true
  key_name = "${var.key-pair}"
  block_device_mappings {
    device_name = "/dev/sda1"
     ebs{
    delete_on_termination = "${var.ebs_volume_deletion_on_termination}"
    volume_size = "${var.ebs_volume_size}"
    volume_type = "${var.ebs_volume_type}"
  }
  }
 
  monitoring {
    enabled = true
  }
  iam_instance_profile {
    arn = "${var.iam-arn}"
  }
  vpc_security_group_ids = "${var.sg-ids}"
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.env}-${var.app-name}-web-asg"
    }
  }
  lifecycle {
    create_before_destroy = true
  }

  user_data =  filebase64("${path.module}/userdata.sh") 
}