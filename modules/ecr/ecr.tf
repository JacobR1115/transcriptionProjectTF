resource "aws_ecr_repository" "transcription_project_ecr_repo" {
  name = var.ecr_repo_name
}