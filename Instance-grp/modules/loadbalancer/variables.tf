
# backend service variables
variable "vm_name" {}
variable "zone" {}
variable "region" {}
variable "backend_name" {}
variable "healthcheck_name" {}

# load balancer variables
variable "vpc_network" {}
variable "loadbalancer_name" {}
variable "ip_cidr_ilb_subnet" {}
variable "ip_cidr_proxy_subnet" {}
