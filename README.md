         ___        ______     ____ _                 _  ___  
        / \ \      / / ___|   / ___| | ___  _   _  __| |/ _ \ 
       / _ \ \ /\ / /\___ \  | |   | |/ _ \| | | |/ _` | (_) |
      / ___ \ V  V /  ___) | | |___| | (_) | |_| | (_| |\__, |
     /_/   \_\_/\_/  |____/   \____|_|\___/ \__,_|\__,_|  /_/ 
 ----------------------------------------------------------------- 

# Vacation Spot
 This is a web application which lists some of the popular vacation destination in the world. You can search for your favorite vacation place.

## Project Overview
The goal of this project is to delpoy a containerised web application using docker on Kubernetes cluster by automating CICD pipline. CICD pipline includes linting stage to lint application code, buliding stage that builds docker image, security scan to scan docker image vulnerability, push stage to push image to amazon ECR and deploy stage to deploy application to Kubernetes cluster performing rolling updates. For deployment, I created cloudformation templates to create K8s cluster (k8s-cluster.yml), worker node (cluster-workers.yml), roles for worker node (aws-auth-cm.yml), network (network.yml)required for deploying cluster, and ECR registry (container-registry.yml) to run container image. 

## Files included
#### * Cloudformation-AWS:
* `network.yml`: Cloudformation template to provision network components such as vpc, subnets.
* `network-params.json`: Parameter file for `network.yml` file.
* `k8s-cluster.yml`: Cloudformation template to create kubernetes cluster.
* `cluster-params.json`: Parameter file for `k8s-cluster.yml` file.
* `cluster-workers.yml`: Cloudformation template to create k8s workers node.
* `workers-params.json`: Parameter file for `cluster-workers.yml` file.
* `aws-auth-cm.yml`: Role for workers node.
* `container-registry.yml`: Cloudformation template to define ECR.
* `registry-params.json` : Parameter file for `container-registry.yml` file.
* `create_stack.sh` : Shell script to create cloudformation stack.
* `update_stack.sh` : Shell script to update cloudformation stack.
* `delete_stack.sh` : Shell script to delete cloudformation stack.

#### * Cloudformation-Kubernetes:
* `deployment.yml` : Cloudformation template to peform rolling update.
* `service.yml` : Cloudformation template to provision load balancer.

#### * Application_Code: 
Folder that includes application code

#### * Dockerfile:
To create dockerfile image

#### * Jenkinsfile:
Contains jobs to create CICD pipline

#### * Screenshots:
Screenshots of steps involved

## Pre-requisites:
* AWS account
* AWS CLI
* Kubectl installed in your machine


## Steps
* Create EC2 instances(Ubuntu 18.04 LTS amd64)
* Install Jenkins on Ubuntu. Install Jenkins dependencies such as tidy, aquamicroscanner and docker.
* Create a CICD pipline by configuring jenkins to github url `https://github.com/SamikshyaAd/Vacation_Spot.git` 
* Create kubernetes cluster and deploy the application with rolling updates:
    * Deploy `network.yml` to create network components. Run `./create_stack.sh network.yml network-params.json`
    * Deploy `k8s-cluster.yml` to create kubernetes cluster. Run `./create_stack.sh k8s-cluster.yml cluster-params.json`
    * Deploy `cluster-workers.yml` to enable nodes in the cluster where the pods get deployed. Run `./create_stack.sh cluster-workers.yml workers-params.json`
    * Run `kubectl apply -f aws-auth-cm.yaml` to grant permissions to the nodes to join the cluster.
    * Run `kubectl get svc` which shows the kubernetes services and `kubectl get nodes` which shows the state of worker nodes.
    * Run `./create_stack.sh container-registry.yml registry-params.json` to run container image.
    * Jenkinsfile `Kubernetes Deploy` stage performs rolling update with `deployment.yml` and `service.yml` file.



