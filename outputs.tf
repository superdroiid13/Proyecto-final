output "bucket_name" {
  description = "Nombre del bucket"
  value       = aws_s3_bucket.main.id
}

output "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB"
  value       = aws_dynamodb_table.usuarios.name
}

output "sqs_queue_url" {
  description = "URL de la cola SQS"
  value       = aws_sqs_queue.web_queue.id
}
