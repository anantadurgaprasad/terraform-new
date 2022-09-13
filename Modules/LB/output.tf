output "lb-arn" {
    value = aws_lb.load_balancer.arn
  
}
output "tg-arn" {
    value = aws_lb_target_group.test.arn
  
}
output "lb-id" {
  value = aws_lb.load_balancer.id
}