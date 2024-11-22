output alb_output {
    value = aws_lb.alb
  
}
output "tg-group-output" {
 value =  aws_lb_target_group.tg.arn
}