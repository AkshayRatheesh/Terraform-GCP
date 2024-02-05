variable "vm_name" {
  default = "instance-1"
}
variable "vm_container" {
  default = "nginx"
}
variable "vpc_subnetwork" {
  default = "projects/akshay-412311/regions/us-central1/subnetworks/default"
}
variable "vpc_network"{
    default = "default"
}
variable "vm_zone" {
  default = "asia-south1-a"
}
variable "vm_tags" {
  default = ["http-server", "https-server"]
}


variable "boot_disk_size" {
  default = 10
}

variable "boot_disk_type" {
  default = "pd-ssd"
}

variable "vm_machine_type" {
  default = "e2-medium"
}