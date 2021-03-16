resource "aws_ecr_repository" "ecr_webapp" {
  name = var.ecr_repo_name
}
