variable "aws_region" {
  type        = string
  description = "Primary AWS region in which resources should be created."
  default     = "us-east-2"
}

variable "github_repository" {
  type        = string
  description = "The [OWNER]/[REPO] string that identifies this GitHub repository"
}
