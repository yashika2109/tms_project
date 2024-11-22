variable "launch_template_name" {
  description = "Name of the launch template"
  type        = string
}

variable "ami" {
  description = "AMI ID for the instances"
  type        = string
}
# variable "instance_ids" {
#     type = string
  variable "key" {
    
  }
# }


variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address"
  type        = bool
  default     = true
}



variable "autoscaling_group_name" {
  description = "Name of the autoscaling group"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the instances"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the autoscaling group"
#    type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for the autoscaling group"
  type        = string
}
 variable "tg_output" {
  
 }


variable "environment" {
  type    = string
  default = "dev"  # Set based on your environment
}