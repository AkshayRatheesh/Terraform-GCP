gcloud beta compute instance-templates create-with-container
 instance-template-1 --project=akshay-412311 --machine-type=e2-micro 
 --network-interface=network=default,network-tier=PREMIUM 
 --instance-template-region=projects/akshay-412311/regions/us-central1 
 --maintenance-policy=MIGRATE --provisioning-model=STANDARD 
 --service-account=670345183702-compute@developer.gserviceaccount.com 
 --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append 
 --container-image=nginx:latest --container-restart-policy=always 
 --create-disk=auto-delete=yes,boot=yes,device-name=instance-template-1,image=projects/cos-cloud/global/images/cos-stable-109-17800-66-65,mode=rw,size=10,type=pd-balanced 
 --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=container-vm=cos-stable-109-17800-66-65


gcloud compute instance-templates create instance-template-1 
--project=akshay-412311 
--machine-type=e2-medium --network-interface=network=default,network-tier=PREMIUM 
--maintenance-policy=MIGRATE --provisioning-model=STANDARD 
--service-account=670345183702-compute@developer.gserviceaccount.com 
--scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append 
--create-disk=auto-delete=yes,boot=yes,device-name=instance-template-1,image=projects/debian-cloud/global/images/debian-12-bookworm-v20240110,mode=rw,size=10,type=pd-balanced 
--no-shielded-secure-boot 
--shielded-vtpm 
--shielded-integrity-monitoring 
--reservation-affinity=any