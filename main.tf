terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 1.6.6"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.aws_region
  # profile = "default" # Opcional
}

variable "aws_region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

variable "input_bucket_name" {
  description = "Nombre del bucket de entrada"
  type        = string
}

variable "output_bucket_name" {
  description = "Nombre del bucket de salida"
  type        = string
}

module "s3" {
  source             = "git::https://github.com/jean-franco660/proyecto_s3.git"
  input_bucket_name  = var.input_bucket_name
  output_bucket_name = var.output_bucket_name
  aws_region         = var.aws_region

  # Si no usas provider alias, puedes eliminar providers = { aws = aws }
  # providers = { aws = aws }
}

module "lambda" {
  source             = "git::https://github.com/jean-franco660/proyecto_lambda.git"
  input_bucket_name  = var.input_bucket_name
  output_bucket_name = var.output_bucket_name
  aws_region         = var.aws_region

  # providers = { aws = aws }

  depends_on = [module.s3]
}
