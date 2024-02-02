

# create vpc
resource "google_compute_network" "akshay_vpc" {
    name = "akshay-vpc"
}


data "google_compute_network" "akshay_vpc_details" {
  name = "akshay_vpc"
}

#Create VM

resource "google_compute_instance" "compute_instance" {
    name = "akshay-instance-tester"
    machine_type = "f1-micro"
    zone = "us-central1-a"

    boot_disk {
        initialize_params {
          image = "ubuntu-os-cloud/ubuntu-2004-lts" 
          labels = {
            my_label = "akshay"
          }
        }
    }
    network_interface {
      network = data.google_compute_network.akshay_vpc_details.name
    }
    metadata_startup_script = "sudo apt update -y; sudo apt install nginx -y"
}



# # Bucket to store stuff
# resource "google_storage_bucket" "website" {
#   name = "gcp-terraform-bucket-akshay-pathickal"
#   location = "US"
# }

# # make new objects public
# resource "google_storage_object_access_control" "public_rules" {
#   object = google_storage_bucket_object.static_site_src.name
#   bucket = google_storage_bucket.website.name
#   role = "READER"
#   entity = "allUsers"
# }

# # upload files to this bucket
# resource "google_storage_bucket_object" "static_site_src" {
#   name = "index.html"
#   source = "./webiste/index.html"
#   bucket = google_storage_bucket.website.name
# }


# # reserve external static ip for load balancer
# resource "google_compute_global_address" "website_ip" {
#   name = "website-lb-ip"
# }