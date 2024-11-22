# # Create private EC2 instances using 'count' instead of 'for_each'
# # resource "aws_instance" "ec2_private_instance" {
# #   count                        = length(var.private_subnets) > 2 ? 2 : length(var.private_subnets)
# #   ami                          = var.ami
# #   instance_type                = "t2.micro"
# #   subnet_id                    = var.private_subnets[count.index]
# #   associate_public_ip_address  = false
# #   vpc_security_group_ids       = var.sg_id

# #   tags = {
# #     Name = "Private-Instance-${count.index}"
# #   }

# #   user_data = var.user_data
# # }

# # SSM Role
# # 




# # # SSM IAM Role
# # resource "aws_iam_role" "ssm_role" {
# #   name = "${var.environment}-SSM-EC2-Role"

# #   assume_role_policy = jsonencode({
# #     Version = "2012-10-17"
# #     Statement = [
# #       {
# #         Effect = "Allow"
# #         Principal = {
# #           Service = "ec2.amazonaws.com"
# #         }
# #         Action = "sts:AssumeRole"
# #       }
# #     ]
# #   })
# # }

# # # SSM IAM Policy
# # resource "aws_iam_policy" "ssm_policy" {
# #   name        = "${var.environment}-SSM-Policy"
# #   description = "Policy to allow SSM access"
# #   policy = jsonencode({
# #     Version = "2012-10-17"
# #     Statement = [
# #       {
# #         Effect = "Allow"
# #         Action = [
# #           "ssm:SendCommand",
# #           "ssm:DescribeInstanceInformation",
# #           "ssm:GetCommandInvocation",
# #           "ssm:ListCommandInvocations",
# #           "ssmmessages:CreateControlChannel",
# #           "ssmmessages:CreateDataChannel",
# #           "ssmmessages:OpenControlChannel",
# #           "ssmmessages:OpenDataChannel",
# #           "cloudwatch:PutMetricData",
# #           "logs:CreateLogStream",
# #           "logs:PutLogEvents",
# #           "ec2messages:*"
# #         ]
# #         Resource = "*"
# #       }
# #     ]
# #   })
# # }

# # # Attach Policy to Role
# # resource "aws_iam_role_policy_attachment" "ssm_role_policy_attachment" {
# #   policy_arn = aws_iam_policy.ssm_policy.arn
# #   role       = aws_iam_role.ssm_role.name
# # }

# # # IAM Instance Profile
# # resource "aws_iam_instance_profile" "ssm_instance_profile" {
# #   name = "${var.environment}-SSM-EC2-Instance-Profile"
# #   role = aws_iam_role.ssm_role.name
# # }

# # SSM IAM Role
# resource "aws_iam_role" "ssm_role" {
#   name = "${var.environment}-SSM-EC2-Role-v2"  # Updated name to avoid conflict

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# # SSM IAM Policy
# resource "aws_iam_policy" "ssm_policy" {
#   name = "${var.environment}-SSM-Policy-v2"  # Updated name to avoid conflict

#   description = "Policy to allow SSM access"
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "cloudwatch:PutMetricData",
#           "ds:CreateComputer",
#           "ds:DescribeDirectories",
#           "ec2:DescribeInstanceStatus",
#           "logs:*",
#           "ssm:*",
#           "ec2messages:*"
#         ]
#         Resource = "*"
#       },
#       {
#         Effect = "Allow"
#         Action = [
#           "ssmmessages:CreateControlChannel",
#           "ssmmessages:CreateDataChannel",
#           "ssmmessages:OpenControlChannel",
#           "ssmmessages:OpenDataChannel"
#         ]
#         Resource = "*"
#       }
#     ]
#   })
# }

# # IAM Role Policy Attachment
# resource "aws_iam_role_policy_attachment" "ssm_role_policy_attachment" {
#   policy_arn = aws_iam_policy.ssm_policy.arn
#   role       = aws_iam_role.ssm_role.name
# }

# # IAM Instance Profile
# resource "aws_iam_instance_profile" "ssm_instance_profile" {
#   name = "${var.environment}-SSM-EC2-Instance-Profile-v2"  # Updated name
#   role = aws_iam_role.ssm_role.name
# }
