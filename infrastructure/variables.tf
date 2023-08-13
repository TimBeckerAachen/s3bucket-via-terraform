variable "aws_region" {
  description = "AWS region to create resources"
  default     = "eu-west-1"
}

variable "project_id" {
  description = "project_id"
  default = "s3-via-terraform"
}

variable "bucket_name" {
  description = "name of s3_bucket"
  default = "bucket"
}

variable "owner" {
  description = "name of who maintains the project"
  default = "Tim"
}