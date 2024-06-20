# Terraform-Workspaces

It is impossible to maintain a single state file for all three environments.
So one approach is to create a separate folder for each environment and execute the terraform scripts individually.
But this approach makes it difficult to maintain.
Terraform-Workspace resolves this issue by creating a separate folder for each state file.

### After installing Terraform and configuring your AWS account, create `main.tf` and `terraform.tfvars` as mentioned in the repo.

## To create Terraform workspaces, execute the following commands:

```bash
terraform workspace new dev
terraform workspace new stage
terraform workspace new prod
```
## After creating workspaces, you can switch to any workspace using the following command:

```bash
terraform workspace select stage
```

## After switching to the desired workspace, run the Terraform lifecycle commands:

```bash
terraform init
```
```bash
terraform plan
```
```bash
terraform apply
```

### The code automatically reads the workspace you selected and, based on that, Terraform looks up the instance type set in the code and creates the infrastructure.
