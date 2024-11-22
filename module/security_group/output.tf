output "sg_id" {
 
  value       = aws_security_group.private_ec2_sg.id
}




output "security_group_id" {
  value = aws_security_group.asg.id
}


