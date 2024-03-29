
#Compute Engine Module-----------------------------------------------------------------------------------------
# module "gce_compute_vm" {
#   source = "../../modules/compute"

#   vm_name                = "akshay-vm-instance-terra"
#   vm_container           = "nginx"
#   vm_zone                = "us-central1-a"
#   vm_tags                = ["http-server", "https-server"] 

# }


#Compute Instance Template-----------------------------------------------------------------------------------------
module "gce_instance_template" {
  source = "../../modules/instance_template"

  vm_name         = "akshay-vm-instance-terra"
  vm_container    = "nginx"
  vpc_network     = "default"
  vm_zone         = "us-central1-a"
  vm_tags         = ["http-server", "https-server", "allow-health-check"] 
  vm_machine_type = "e2-micro"

  boot_disk_size  = 10
  boot_disk_type  = "pd-ssd"

}

module "gce_instance_group" {
  source = "../../modules/mig"

  vm_name = "akshay-vm-instance-terra"
  zone    = "us-central1-a"
  target_size = "1"
}


module "gce_loadbalancer" {
  source = "../../modules/loadbalancer"

  vm_name = "akshay-vm-instance-terra"
  zone    = "us-central1-a"
}


# #m1-----------------------------------------------------------------------------------------
# module "instance_module" {
#   source = "../modules/instance"

#   ami_id                = "ami-0d8d9a2de1bcdb066"
#   instance_type         = "t3.micro"
#   availability_zone     = "ap-south-2a"
#   instance_count        = "1"
#   network_insterface_id = module.network_module.network_insterface_id #dynamic
# }


# #m2-----------------------------------------------------------------------------------------
# module "network_module" {
#   source = "../modules/network"

#   env_name       = "development"
#   vpc_id         = module.network_module.vpc_id #dynamic
#   vpc_name       = "terraform_vpc"
#   vpc_cidr_block = "10.0.0.0/16"
#   subnet_name    = "terraform_subnet_a"
#   #subnet_az_b_name      = "terraform_subnet_b"
#   subnet_id = module.network_module.subnet_id #dynamic
#   #subnet_az_b_id        = ""                                   #dynamic
#   subnet_cidr_block = "10.0.1.0/24"
#   subnet_az         = "ap-south-2a"
#   #subnet_az_b           = "ap-south-2b"
#   ig_name               = "terraform_ig"
#   internet_gateway_id   = module.network_module.internet_gateway_id   #dynamic
#   internet_gateway_data = module.network_module.internet_gateway_data #dynamic
#   route_table_name      = "terraform_route_table"
#   route_table_id        = module.network_module.route_table_id #dynamic
#   private_ips           = "10.0.1.50"
#   network_insterface_id = module.network_module.network_insterface_id #dynamic
#   security_groups_id    = module.secutity_module.security_groups_id   #dynamic
# }


# #m3-----------------------------------------------------------------------------------------
# module "secutity_module" {
#   source = "../modules/security"

#   env_name           = "development"
#   vpc_id             = module.network_module.vpc_id #dynamic
#   sg_name            = "terraform_sg"
#   sg_tag_name        = "terraform_sg"
#   security_groups_id = module.secutity_module.security_groups_id #dynamic
# }


# #m4-----------------------------------------------------------------------------------------


# module "asg_module" {
#   source = "../modules/autoscalling"
#   ami_id = "ami-0d8d9a2de1bcdb066"
#   vpc_id             = module.network_module.vpc_id
#   subnet_id = module.network_module.subnet_id 
# }




#m5-----------------------------------------------------------------------------------------


# module "s3_module" {
#   source         = "../modules/s3bucket"
#   s3_bucket_name = "thisisbucketterraform123"
#   s3_tag_name    = "s3_terraform"
#   env_name       = "development"
# }

#m6-----------------------------------------------------------------------------------------


# module "lambda_module" {
#   source = "../modules/lambda"
#   # s3_bucket_name = "thisisbucketterraform123"
#   # s3_tag_name    = "s3_terraform"
#   # env_name       = "development"
# }

