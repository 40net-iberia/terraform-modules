# Deployment LoadBalancers for a Fortigate Cluster deployment on the Azure with Terraform
## Introduction

This module IaC is a part of a full deployment of a Fortigate cluster in a sandwich configuration. This terraform code will deploy 

## Requirements
* [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) >= 0.12.0
* Terraform Provider AzureRM >= 2.24.0
* Terraform Provider Template >= 2.2.0
* Terraform Provider Random >= 3.1.0


## Deployment overview
Terraform deploys the following components:
   - IMPORTANT: for this deployment be suscceful, it is necesary IP and IDs of Fortigate cluster network interfaces. Deploy first fortigate cluster with module fgt-ha.


## Deployment considerations:
      - Create file terraform.tfvars using terraform.tfvars.example as template 
      - Update variables in var.tf with fortigate cluster deployment
      - You will be charged for this deployment

## Deployment
To deploy the FortiGate-VM to Azure:
1. Create module with source `source = "github.com/jmvigueras/modules/azure/xlb`
2. Customize variables in the `terraform.tfvars.example` and `vars.tf` file as needed.  And rename `terraform.tfvars.example` to `terraform.tfvars`.
3. Initialize the providers and modules:
   ```sh
   $ cd XXXXX
   $ terraform init
    ```
4. Submit the Terraform plan:
   ```sh
   $ terraform plan
   ```
5. Verify output.
6. Confirm and apply the plan:
   ```sh
   $ terraform apply
   ```
7. If output is satisfactory, type `yes`.

Output will include the information necessary:
```sh
Outputs:

ilb_private-ip          = <ILB private IP>
elb_public-ip           = <ELB public IP>
gwlb_frontip_config_id  = <GWLB front-end configuration id>
```

## Destroy the deployment
To destroy the instance, use the command:
```sh
$ terraform destroy
```

# Support
This a personal repository with goal of testing and demo Fortinet solutions on the Cloud. No support is provided and must be used by your own responsability. Cloud Providers will charge for this deployments, please take it in count before proceed.

## License
Based on Fortinet repositories with original [License](https://github.com/fortinet/fortigate-terraform-deploy/blob/master/LICENSE) © Fortinet Technologies. All rights reserved.

