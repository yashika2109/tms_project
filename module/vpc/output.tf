 output "vpc_id" {
    value = aws_vpc.main_vpc
 }

 output "cidr_block" {
  value = aws_vpc.main_vpc.cidr_block
   
 }
output "private_subnet_ids" {
  value       = { for k, v in aws_subnet.private_subnet : k => v.id }
 }

# Output for availability zones
output "azs" {
  value = [for a in aws_subnet.private_subnet : a.availability_zone]
}


  output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public_subnet[*].id
}

 output "private_route" {
  value       = aws_route_table.private_rt[*].id
 }

# output "azs" {
#     value =  {
#     for idx, az in data.aws_availability_zones.available.names : idx => az
#   }
  
# }