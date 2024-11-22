#variable "pub_subnets" {
# default = ["10.0.1.0/24", "10.0.7.0/24"]

#}

variable "cidr_block" {
  default = "10.0.0.0/16"

}
variable "ami" {
  default = "ami-0ec2d5511252426c6"
}

variable "key" {
  default = "mumbai_pem_key"
  
}

variable "ingress_cidr_blocks" {
  default     = ["0.0.0.0/0"]
}

variable "egress_cidr_blocks" {
  default     = ["0.0.0.0/0"]
}

variable "sg_name" {
  default     = "private-ec2-sg"
}

variable "launch_template_name" {
  default = "asg-01"
  
}
variable "autoscaling_group_name" {
  default = "asg_group"
  
}


variable "instance_tags" {
  default = "hello"
  
}