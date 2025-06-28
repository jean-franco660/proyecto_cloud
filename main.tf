terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 1.6.6"
    }
  }
  required_version = ">= 1.3.0"
}

# 📦 Módulo S3: crea los buckets de entrada/salida
module "s3" {
  source             = "git::https://github.com/jean-franco660/proyecto_s3.git"
  input_bucket_name  = var.input_bucket_name
  output_bucket_name = var.output_bucket_name
  aws_region         = var.aws_region
}

# 🧠 Módulo Lambda: depende de los buckets del módulo S3
module "lambda" {
  source             = "git::https://github.com/jean-franco660/proyecto_lambda.git"
  input_bucket_name  = var.input_bucket_name
  output_bucket_name = var.output_bucket_name

  providers = {
    aws = aws
  }

  depends_on = [module.s3]
}
