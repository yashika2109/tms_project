

resource "aws_lb" "alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.sg_id  # Ensure sg_id is passed correctly as a variable

  # Use the variable to reference public subnets
  subnets            = var.subnets  # Reference the subnets variable

  enable_deletion_protection = false

  tags = {
    Name = "my-alb"
  }
}


# Target Group
resource "aws_lb_target_group" "tg" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "my-target-group"
  }
}

# Attach EC2 instances to the Target Group
# resource "aws_lb_target_group_attachment" "ec2_attach" {
#   #count         = length(var.tg_attach) > 2 ? 2 : length(var.tg_attach)  
#   target_group_arn = aws_lb_target_group.tg.arn
#  # target_id        = var.lb_tg_id[count.index]  
#  target_id =         
#   port             = 80                       
# }








# ALB Listener
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
