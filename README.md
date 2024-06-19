# Steps to Launch and Configure EC2 Instance with Terraform

## Step 1: Launch an EC2 instance via AWS console

## Step 2: Connect to the instance using SSH or session manager

## Step 3: Install Terraform

Install terraform in EC2 instance by executing below commands:

```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```
Verify Terraform installation by executing the below command:

```bash
terraform -help
```

## Step 4: AWS integration with Terraform

Install AWS CLI using the below commands:

```bash
sudo apt update
sudo apt install awscli -y
```
Verify AWS CLI installation by executing the below command:

```bash
aws --version
```
Run the below command to configure AWS credentials by providing Access key and secret key:

```bash
aws configure
```
You can get the access key and secret key from your AWS console.

## Step 5: Terraform lifecycle

Create main.tf file using below command:

```bash
touch main.tf
```
Initialize Terraform:

```bash
terraform init
```
Plan Terraform code:

```bash
terraform plan
```
Apply the code:

```bash
terraform apply
```
Check whether the infrastructure is created and state file is generated.
