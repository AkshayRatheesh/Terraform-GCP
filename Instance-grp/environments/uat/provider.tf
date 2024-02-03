provider "google" {
  credentials = file(var.gcp_sa)
  project = var.gcp_project
  region = var.gcp_region
}