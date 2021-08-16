# tf-gcp-CFT-architecture

##  GFT - Terraform-Cloud Foundation Toolkit for creating Landing Zones. (draft)

## Table of Contents

* [Table of Contents](#table-of-contents)

     * [Prerequisites](#prerequisites)
     * [The Deployment Process (Overview)](#the-deployment-process-overview)
     * [Roles and Required Access](#roles-and-access)
     * [0-bootstrap](#0-bootstrap)
     * [1-org](#1-org)
     * [2-environment](#2-environment)
     * [3-network](#3-network)
 
         
 

## Prerequisites
  
  To run the commands described in this document, you need to have the following installed:
  
  The Google Cloud SDK version 319.0.0 or later
  Terraform version 0.13.7.
  An existing project which the user has access to be used by terraform-validator.
      Note: Make sure that you use the same version of Terraform throughout this series. Otherwise, you might experience Terraform state snapshot lock errors.

   Also make sure that you've done the following:

   Set up a Google Cloud organization.
   Set up a Google Cloud billing account.
   Created Cloud Identity or Google Workspace (formerly G Suite) groups for organization and billing admins.
   Added the user who will use Terraform to the group_org_admins group. They must be in this group, or they won't have roles/resourcemanager.projectCreator access.
   For the user who will run the procedures in this document, granted the following roles:
   The roles/resourcemanager.organizationAdmin role on the Google Cloud organization.
   The roles/billing.admin role on the billing account.
   The roles/resourcemanager.folderCreator role.
   If other users need to be able to run these procedures, add them to the group represented by the org_project_creators variable. For more information about the permissions that are required, and the resources that          are created, see the organization bootstrap module documentation.

## The Deployment Process (Overview)

<img width="1018" alt="Screenshot 2021-07-27 at 11 43 57 am" src="https://user-images.githubusercontent.com/80045831/127141366-262007ca-c4a6-48c5-a0bc-b89bdeb694a8.png">

## Roles and Required Access

### User account :
-
-
-
### Service account : 
-
-



## 0-bootstrap
This repo is part of a multi-part guide that shows how to configure and deploy the example.com reference architecture described in Google Cloud security foundations guide (PDF). 

### Instructions: 

	git clone https://github.com/tranquilitybase-io/tf-gcp-CFT-architecture.git
	
	cd ./tf-gcp-CFT-architecture/scripts/bootstrap
	
Edit the file called "terraform.example.tfvars"	
Rename the file "terraform.example.tfvars" to "terraform.tfvars"

	cd ../..
	
	make bootstrap
	
Go to the folder:
	
	tf-gcp-CFT-architecture/bootstrap/terraform-example-foundation/0-bootstrap$

Note the email address of the admin. You need this address in a later procedure. under which folder?

	 terraform output terraform_service_account

## 1-org

This repo is part of a multi-part guide that shows how to configure and deploy the example.com reference architecture described in Google Cloud security foundations guide (PDF). 

### Instructions: 

    cd ./tf-gcp-CFT-architecture/scripts/bootstrap
	
Edit the file called "terraform.example.tfvars"	 with your project information

Rename the file "terraform.example.tfvars" to "terraform.tfvars"

    mv terraform.example.tfvars terraform.tfvars

Edit the file called "env-variables-example.sh" and rename the file "env-variables-example.sh" to env-variables.sh 

In "export CLOUD_BUILD_PROJECT_ID=<project_id>"
Use the project id of the CI/CD ex (prj-b-cicd-xxxx)

   	mv env-variables-example.sh env-variables.sh
	
Run org.sh

	cd ../..
	make org



