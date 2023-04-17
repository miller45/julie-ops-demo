output "resource-ids" {
  value = <<-EOT

  ${confluent_service_account.prd-app-producer.display_name}:                    ${confluent_service_account.prd-app-producer.id}
  ${confluent_service_account.prd-app-producer.display_name}'s Kafka API Key:    "${confluent_api_key.prd-app-producer-api-key.id}"
  ${confluent_service_account.prd-app-producer.display_name}'s Kafka API Secret: "${confluent_api_key.prd-app-producer-api-key.secret}"

  EOT

  sensitive = true
}
