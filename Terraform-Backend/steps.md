Above terraform scripts has been written such that the state file will be stored in remote s3 container.

## Clone the repo

Clone the below repo using git clone command and navigate to the root folder and perform below steps

```bash
git clone https://github.com/Sumanth484/Terraform.git
```
## Modify Variables

If you want to modify variables, Modify the variable values in .tfvars file.

First execute the main.tf only without backend.tf by commenting the backend.tf code.

## Initialize Terraform:

```bash
terraform init
```
## Plan Terraform code:

```bash
terraform plan
```
## Apply the code:

```bash
terraform apply
```
Check whether the infrastructure is created and state file is generated.

### After creating the resouces and infra now uncomment the backend.tf code and execute the Terraform life cycle again.
