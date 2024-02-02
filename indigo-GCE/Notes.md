

#Create Service Account
    - name: terra-sa
    - role: basic/editor
    - generate json key


#Terraform Filestructure
    - provider.tf  (gcp provider configurations)
    - main.tf

    terraform init
    terraform plan
    terraform apply
