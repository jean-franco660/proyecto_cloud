variable "aws_region" {
  default = "us-east-1"
}

variable "input_bucket_name" {
  default = "archivo-csv-entrada"
}

variable "output_bucket_name" {
  default = "archivo-csv-salida"
}

variable "lambda_code_bucket" {
  default = "lambda-code-bucket-2025"
}
