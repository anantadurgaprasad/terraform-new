resource "aws_cloudwatch_log_group" "cwg" {
  name = "${var.cloudwatch-group-name}"
  retention_in_days = "${var.cloudwatch-group-retention-days}"


  
}
