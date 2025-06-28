output "input_bucket_name" {
  description = "Nombre del bucket de entrada"
  value       = var.input_bucket_name
}

output "output_bucket_name" {
  description = "Nombre del bucket de salida"
  value       = var.output_bucket_name
}

output "aws_region" {
  description = "Región AWS"
  value       = var.aws_region
}
