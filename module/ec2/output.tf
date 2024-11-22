# output "instance_ids" {
#   value = [for instance in aws_instance.ec2_private_instance : instance.id]
# }

# output "private_ips" {
#   value = [for instance in aws_instance.ec2_private_instance : instance.private_ip]
# }
# output "instance_ids" {
#   description = "List of EC2 instance IDs"
#   value       = aws_instance.ec2_private_instance[*].id  # Adjust this according to how you name your EC2 instances
# }
