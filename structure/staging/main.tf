terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-south-2" #aws region code
}



# #m1-----------------------------------------------------------------------------------------
 module "instance_module" {
   source = "../modules/cloudfront"

#   ami_id                = "ami-0d8d9a2de1bcdb066"
#   instance_type         = "t3.micro"
#   availability_zone     = "ap-south-2a"
#   instance_count        = "1"
#   network_insterface_id = module.network_module.network_insterface_id #dynamic
 }
