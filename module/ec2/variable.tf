variable "ami" {
 type        = string
}

variable "private_subnets" {
  type        = map(string)
}

variable "vpc_id" {
  type        = string
}
variable "sg_id" {
  
}
# variable "region" {
#   type        = string
  
# }

variable "user_data" {
  description = "User data script to be passed to EC2 instances"
  type        = string
  default     = <<-EOF
    #!/bin/bash
    sudo apt-get update -y && sudo apt-get upgrade -y
    sudo apt-get install -y nginx
    echo "<html><head><title>Hello</title></head><body><h1>Hello World</h1></body></html>" > /var/www/html/index.html
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF
}
variable "environment" {
  type    = string
  default = "dev"  # Set based on your environment
}
