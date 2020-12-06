# Terraform Samples

This repository contains various usages and examples of usage of Terraform and providers.

Each sample has it's own README so read those for their usage.

* **SETUP** - This contains some basic setup templates that might be required for other items and are not core 'terraform' code.

## Setup

The `SETUP/` folder contains the base CloudFormation templates to start working with Terraform in AWS.  While there are many methods to handle a green-field setup, this seemed like a logical place to start as the Cloudformation does the first setup and rarely will need updated.

When working with the templates, not all of them are configured to use the ECR pipeline and are provided in a way can be used without.  To run it locally without a configured S3 Backend, simply commount out the entire `backend "s3" {}` in the `main.tf` file(s) and Terraform will default to your local machine.  

## Notes

Whiles these templates are for testing/learning/experimentation, it would be wise to create a new repo for each folder/tempalte you want to experiment with as as the buildspec included with that configuration assumes it is the root during build time.  If you attempt to simply clone this repo and run directly against it, it _will_ fail as the Buildspec files assumes each of them are their own repo.  it is possible to run this off the single repo clone, but modifications would be required.

## Warning about Terraform

In newer versions of Terraform, unused variables must start with `TF_VAR_`.  During experimentation and usage of these examples, if you opt to remove a section or module but don't want to delete the variable, simple append an empty variable with that prefix.


## To Do

- [ ] Ensure all templates are consistant and can easily be swapped between local or remote-state for testing.