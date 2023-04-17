output "resource-ids" {
  value = <<-EOT
  ${confluent_service_account.dev-app-producer.display_name}:                    ${confluent_service_account.dev-app-producer.id}
  ${confluent_service_account.dev-app-producer.display_name}'s Kafka API Key:    "${confluent_api_key.dev-app-producer-api-key.id}"
  ${confluent_service_account.dev-app-producer.display_name}'s Kafka API Secret: "${confluent_api_key.dev-app-producer-api-key.secret}"

  EOT

  sensitive = true
}
