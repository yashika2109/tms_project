variable "vpc_id" {
  
  type        = string
}

variable "ingress_cidr_blocks" {
  
  
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "egress_cidr_blocks" {
  
  
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "sg_name" {
 
 
  type        = string
  default     = "private-ec2-sg"
}
