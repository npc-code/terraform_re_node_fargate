variable "cluster_name" {
  description = "The cluster_name"
}

variable "container_name" {
  description = "Container name"
}

variable "container_port" {
  description = "ALB target port"
}

variable "desired_task_cpu" {
  description = "Task CPU Limit"
}

variable "desired_task_memory" {
  description = "Task Memory Limit"
}

variable "environment_variables" {
  type        = map(string)
  description = "ecs task environment variables"
}

variable "alb_port" {
  description = "ALB listener port"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "external_ip" {
  type    = string
  default = "74.69.167.125/32"
}

variable "region" {
    type = string
    default = "us-east-2"
}

variable "subnets" {
  type        = list(string)
  description = "subnets to use"
}

variable "container_subnets" {
    type = list(string)
    description = "private subnets for containers"
}

variable "health_check_path" {
  description = ""
  default     = "/"
}

variable "desired_tasks" {
  description = "Number of containers desired to run the application task"
}

variable "ecr_repo_name" {
    description = "Name of the ecr repo to use"
}

variable "domain_name" {
    description = "root domain for route53 hosted zone"
    default = ""
}

#variable "use_domain" {
##    type = bool
#    description = "true/false as to our use of a route53 domain. requires domain name.  if set to false, will use the dns of the alb"
#}

variable "url" {
    type = string
    description = "domain name to be used for the alb"
    default = ""
}


