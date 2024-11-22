variable "sg_id" {
  
}

variable "vpc_id" {
  
}
# variable "instance_id" {
#     type = map(string)
  
# }
variable "subnets" {
  description = "List of public subnet IDs for the Load Balancer"
  type        = list(string)
}
# variable "instance_ids" {
#     type=  list(string)
  
# }

variable "tg_attach" {
  
}
variable "lb_tg_id" {
  
}