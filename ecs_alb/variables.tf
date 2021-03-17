variable "cluster_name" {
  description = "The cluster_name"
}

variable "container_name" {
  description = "Container name"
}

variable "container_port" {
  description = "ALB target port"
}

variable "container_subnets" {
    type = list(string)
    description = "private subnets for containers"
}

variable "desired_task_cpu" {
  description = "Task CPU Limit"
}

variable "desired_task_memory" {
  description = "Task Memory Limit"
}

variable "desired_tasks" {
  description = "Number of containers desired to run the application task"
}

variable "domain_name" {
    description = "root domain for route53 hosted zone"
    default = ""
}

variable "ecr_repo_name" {
    description = "Name of the ecr repo to use"
}

variable "environment_variables" {
  type        = map(string)
  description = "ecs task environment variables"
}

variable "external_ip" {
  type    = string
  default = "0.0.0.0/0"
}

variable "health_check_path" {
  description = ""
  default     = "/"
}

variable "region" {
    type = string
    default = "us-east-2"
}

variable "subnets" {
  type        = list(string)
  description = "subnets to use"
}

variable "url" {
    type = string
    description = "domain name to be used for the alb"
    default = ""
}

variable "vpc_id" {
  description = "The VPC id"
}

