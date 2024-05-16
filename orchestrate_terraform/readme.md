# Terraform

## Installing Terraform
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
1. Extract to a folder
2. Go to advanced system settings (sysdm.cpl in run window)
3. Edit Path variable
4. Add new path 

## Creating keys
- click windows key
- type env
- system or env var choose env
- click new
- enter name **(AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY)** then value
- save and repeat for other key
## Which region
eu-west-1
## Then instructions
```bash
1. nano main.tf
# See /c/terraform_learning 
2. terraform init # inside terraform folder
3. terraform plan # checks your main.pf
4. terraform apply # makes your instance
```
## Blockers and tips
- Access denied
- If access granted then its a syntax
- No valid credential source - admin access
- **HARD CODING KEYS** Don't hardcode access keys and secret access keys