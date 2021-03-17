provider "aws" {
  profile = var.profile
  region  = var.region
  alias   = "main-account"
}

#created and managed in separate terraform project.
#data "aws_route53_zone" "main_zone" {
#  name         = var.domain_name
#  provider     = aws.main-account
#  private_zone = false
#}

module "network" {
  source = "./network"
  profile   = var.profile
  region    = var.region
  base_cidr = "${var.vpc_cidr}"

  providers = {
    aws = aws.main-account
  }
}

module "ecs" {
  source                = "./ecs_alb"
  cluster_name          = "${var.prefix}-cluster"
  container_name        = "${var.prefix}-container"
  container_port        = var.container_port
  environment_variables = var.environment_variables
  desired_task_cpu      = var.desired_task_cpu
  desired_task_memory   = var.desired_task_memory
  desired_tasks         = 2
  external_ip           = var.external_ip
  vpc_id                = module.network.vpc_id
  region                = var.region
  ecr_repo_name         = "${var.prefix}-ecr-repo"
  subnets               = module.network.public_subnets
  container_subnets     = module.network.private_subnets
  domain_name           = var.domain_name
  url                   = var.url

  providers = {
    aws = aws.main-account
  }
}

module "pipeline" {
  source = "./codepipeline"
  region = var.region

  cluster_name   = "${var.prefix}-cluster"
  repository_url = module.ecs.ecr_webapp_repository_url
  container_name = "${var.prefix}-container"

  vpc_id = module.network.vpc_id

  app_repository_name = module.ecs.ecr_webapp_repository_name
  app_service_name    = "${var.prefix}-cluster"
  pipeline_name       = "${var.prefix}-container-pipeline"

  bucket_name    = "${var.prefix}-build-bucket-"
  project_name   = "${var.prefix}-codebuild-project-"
  git_repository = var.git_repository
  oauth_token    = var.oauth_token


  providers = {
    aws = aws.main-account
  }
}

