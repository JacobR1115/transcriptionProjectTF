terraform {
  required_version = "~> 1.3"

  backend "s3" {
    bucket         = "jacobr-tf-state"
    key            = "tf-infra/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "tf-state-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

module "tf-state" {
  source      = "./modules/tf-state"
  bucket_name = local.bucket_name
  table_name  = local.table_name
}

module "ecr-repo" {
  source = "./modules/ecr"

  ecr_repo_name = local.ecr_repo_name
}

module "ecs-cluster" {
  source = "./modules/ecs"

  transcription_project_cluster_name = local.transcription_project_cluster_name
  availability_zones                 = local.availability_zones

  transcription_project_task_family = local.transcription_project_task_family
  ecr_repo_url                      = module.ecr-repo.repository_url
  container_port                    = local.container_port
  transcription_project_task_name   = local.transcription_project_task_name
  ecs_task_execution_role_name      = local.ecs_task_execution_role_name

  application_load_balancer_name     = local.application_load_balancer_name
  target_group_name                  = local.target_group_name
  transcription_project_service_name = local.transcription_project_service_name
}