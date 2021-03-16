variable "profile" {
  type    = string
  default = ""
}

variable "region" {
  type    = string
  default = "us-east-2"
}

variable "container_port" {
    type = number
}

variable "external_ip" {
  type    = string
  default = "0.0.0.0/0"
}

variable "desired_task_cpu" {
  type        = string
  description = "desired cpu to run your tasks"
  default     = "512"
}

variable "desired_task_memory" {
  type        = string
  description = "desired memory to run your tasks"
  default     = "2048"
}


variable "environment_variables" {
  type        = map(string)
  description = "ecs task environment variables"

  default = {
    KEY = "value"
  }
}

variable "git_repository" {
  type        = map(string)
  description = "git repo owner, name, and branch"

  default = {
    owner  = ""
    name   = ""
    branch = "main"
  }
}

variable "domain_name" {
  type        = string
  description = "Domain name for AWS Route53 hosted zone"
  default = ""
}

variable "prefix" {
  description = "This is the environment where your webapp is deployed. qa, prod, or dev"
}

variable "vpc_cidr" {
  description = "base cidr for vpc created for environment"
}

variable "oauth_token" {
  description = "This is the oauth token used by AWS CodePipeline to access the repo"
}

variable "url" {
  type        = string
  description = "base url to use for the app"
  default = ""
}


