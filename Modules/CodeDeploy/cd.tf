resource "aws_codedeploy_app" "application" {
  compute_platform = "Server"
  name             = "${var.application-name}"
}

resource "aws_codedeploy_deployment_group" "cdg" {
  app_name              = aws_codedeploy_app.application.name
  deployment_group_name = "${var.deploy-group-name}"
  service_role_arn      = "${var.iam-role-arn}"
autoscaling_groups = "${var.asg-list}"
  deployment_style {
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
    deployment_type = "IN_PLACE"
  }
    
  }

  
