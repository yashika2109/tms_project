resource "aws_security_group" "private_ec2_sg" {
  vpc_id = var.vpc_id

  # Allow HTTP traffic (Ingress rule)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks
    description = "Allow HTTP traffic from allowed CIDR blocks"
  }

  # Allow all outbound traffic (Egress rule)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allows all protocols
    cidr_blocks = var.egress_cidr_blocks
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = var.sg_name
  }
}





# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-security-group"
  }
}
 



 # Security Group for ALB
resource "aws_security_group" "asg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-autoscaling"
  }
}
