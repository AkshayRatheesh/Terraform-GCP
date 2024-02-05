
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

  vm_name         = "akshay-vm-instance-terra-dev"
  vm_container    = "nginx"
  vpc_network     = "default"
  vm_zone         = "us-central1-b" 
  vm_tags         = ["http-server", "https-server", "allow-health-check","lb-health-check"] 
  vm_machine_type = "e2-micro"

  boot_disk_size  = 10
  boot_disk_type  = "pd-ssd"

}

module "gce_instance_group" {
  source = "../../modules/mig"

  vm_name = "akshay-vm-instance-terra-dev"
  zone    = "us-central1-b"
  target_size = "1"

  healthcheck_name =  "health-check"

  depends_on = [
        module.gce_instance_template
    ]

}


module "gce_loadbalancer" {
  source = "../../modules/loadbalancer"

  # backend service
  vm_name = "akshay-vm-instance-terra-dev"
  zone    = "us-central1-b"
  region  = "us-central1"
  backend_name = "aksh-backend"
  #health check
  healthcheck_name =  "health-check"
  # load balancer
  vpc_network        = "default"
  ip_cidr_ilb_subnet = "10.0.1.0/24"
  ip_cidr_proxy_subnet = "10.0.0.0/24"
  loadbalancer_name   = "akshay-alb"

  depends_on = [
        module.gce_instance_group
    ]

}

