resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = module.ec2-iam-role.iam-name
}
module "launch-template" {
  source = "./Modules/LT"
  env = "${var.env}"
  app-name = "${var.app-name}"
  ami-id = "${var.ami-id}"
  instance-type = "${var.instance-type}"
  key-pair = "${var.ec2-key-name}"
  sg-ids = [module.new_vpc.private-sg-id]
  iam-arn = aws_iam_instance_profile.ec2_profile.arn
  ebs_volume_size = "${var.ebs-volume-size}"
  ebs_volume_type = "${var.ebs-volume-type}"
  ebs_volume_deletion_on_termination = "${var.ebs-volume-delete-on-termination}"
}