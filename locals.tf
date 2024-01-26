locals {
  bucket_name = "jacobr-tf-state"
  table_name  = "tf-state-lock"

  ecr_repo_name = "transcription-project-ecr-repo"

  transcription_project_cluster_name = "transcription-project-cluster"
  availability_zones                 = ["us-east-2a", "us-east-2b", "us-east-2c"]
  transcription_project_task_family  = "transcription-project-task"
  container_port                     = 8080
  transcription_project_task_name    = "transcription-project-task"
  ecs_task_execution_role_name       = "transcription-project-task-execution-role"

  application_load_balancer_name = "cc-transcription-project-app-alb"
  target_group_name              = "cc-transcription-project-alb-tg"

  transcription_project_service_name = "cc-transcription-project-service"
}