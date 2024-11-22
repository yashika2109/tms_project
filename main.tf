provider "aws" {
  region = "ap-south-1"

}


module "vpc" {
  source            = "./module/vpc"
  cidr_block        = var.cidr_block
}

  module "ec2" {
    source = "./module/ec2"
    ami = var.ami
    vpc_id  =  module.vpc.vpc_id.id
    private_subnets = module.vpc.private_subnet_ids
    sg_id = [module.security_group.sg_id]
}

  module "security_group" {
    source = "./module/security_group"
    vpc_id =module.vpc.vpc_id.id
    ingress_cidr_blocks =var.ingress_cidr_blocks
    egress_cidr_blocks=var.egress_cidr_blocks 
    sg_name =var.sg_name
}

  module "load_balancer" {
    source = "./module/load_balancer"
    vpc_id= module.vpc.vpc_id.id
    subnets    = module.vpc.public_subnet_ids # Reference public subnet IDs from the VPC module
    # instance_id = module.ec2.instance_ids
    sg_id=[module.security_group.sg_id]
    # instance_ids = module.ec2.instance_ids
    tg_attach = "2"
    lb_tg_id = module.autoscaling.launch_template_id
 }

module "autoscaling" {
  source                  = "./module/autoscaling"
  vpc_id                  = module.vpc.vpc_id.id
  security_group_id      = module.security_group.security_group_id 
  tg_output   =          module.load_balancer.tg-group-output
 ami                     = var.ami
  launch_template_name    = var.launch_template_name
  subnet_ids              = module.vpc.private_subnet_ids
  autoscaling_group_name  = "hello"
  key=var.key

}

module "peering"{
  source = "./module/peering"
  vpc_id = module.vpc.vpc_id.id
  main_route_table_id = module.vpc.private_route
  cidr_block = module.vpc.cidr_block
  
}

terraform {
  backend "s3" {
    bucket         = "tms-bucket-11"                 # S3 bucket name
    key            = "terraform.tfstate"                # Path to the state file within the bucket
    region         = "ap-south-1"                   # AWS region of the S3 bucket
   # dynamodb_table = "dynamodb"         # DynamoDB table name for state locking (if you have one)
    encrypt        = true                           # Enable encryption for state f
  }
}


output "prisnet" {
  value = module.vpc.private_subnet_ids
}
