# Launch Template
resource "aws_launch_template" "asg_template" {
  name           = var.launch_template_name
  image_id       = var.ami
  instance_type  = "t2.micro"
  key_name = var.key  # Ensure this instance type is supported

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.security_group_id]
  }

  # Add IAM instance profile for SSM
  iam_instance_profile {
    name = aws_iam_instance_profile.ssm_instance_profile.name
  }

  # Add a non-empty tags block
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = var.launch_template_name
      Environment = "production"  # Example tag
    }
  }
}

# Autoscaling Group
resource "aws_autoscaling_group" "asg" {
  name                      = var.autoscaling_group_name
  max_size                  = 3
  min_size                  = 1
  desired_capacity          = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"

  launch_template {
    id = aws_launch_template.asg_template.id
  }

  target_group_arns = [var.tg_output]

  # Use only the supported availability zones
  vpc_zone_identifier = [var.subnet_ids[0], var.subnet_ids[1]]
  
    # ap-south-1a, ap-south-1b
}

# IAM Role for SSM
resource "aws_iam_role" "ssm_role" {
  name = "${var.environment}-SSM-EC2-Role-v2"  # Updated name to avoid conflict

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# SSM IAM Policy
resource "aws_iam_policy" "ssm_policy" {
  name = "${var.environment}-SSM-Policy-v2"  # Updated name to avoid conflict

  description = "Policy to allow SSM access"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:PutMetricData",
          "ds:CreateComputer",
          "ds:DescribeDirectories",
          "ec2:DescribeInstanceStatus",
          "logs:*",
          "ssm:*",
          "ec2messages:*"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ]
        Resource = "*"
      }
    ]
  })
}

# IAM Role Policy Attachment
resource "aws_iam_role_policy_attachment" "ssm_role_policy_attachment" {
  policy_arn = aws_iam_policy.ssm_policy.arn
  role       = aws_iam_role.ssm_role.name
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "${var.environment}-SSM-EC2-Instance-Profile-v2"  # Updated name
  role = aws_iam_role.ssm_role.name
}
