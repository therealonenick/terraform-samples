# aws-terraform-testing

Cloudformation Templates to get started with Terraform in AWS.

## Setup

1. For a brand new deployment, run the CloudFormation to get the basics configured in AWS.
    1. `cloudformation-terraform.yaml` - Setup Pipline and ECR to build the Terraform Image
        * Reads the `Dockerfile` from the target repo.
    2. `pipeline-read-ecr` - Sets up a pipeline to build off a repo that utilizes the ECR image containing Terraform
        * In theory this one is only needed once as you could build additional pipelines directly from Terraform
