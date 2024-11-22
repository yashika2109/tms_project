output "autoscaling_group_name" {
  description = "Name of the autoscaling group"
  value       = aws_autoscaling_group.asg.name
}

output "launch_template_id" {
  description = "ID of the launch template"
  value       = aws_launch_template.asg_template.id
}


