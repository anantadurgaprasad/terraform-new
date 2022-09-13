resource "aws_launch_template" "lc" {
  name = "basic-lc"
  image_id = "${var.ami-id}"
  instance_type = "${var.inst-type}"
  key_name = "${var.key-pair}"
  monitoring {
    enabled = true
  }
  network_interfaces {
    associate_public_ip_address = false
    security_groups = "${var.sg-ids}"
    subnet_id = "${var.subnet-id}"
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "instance-by-asg"
    }
  }

  user_data =  filebase64("${path.module}/userdata.sh"
) 
}