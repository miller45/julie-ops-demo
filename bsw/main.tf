terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version =  "1.6.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatejr0ok"
    container_name       = "tfstate"
    key                  = "terraform_dev.tfstate"
  }

}

provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret

  kafka_rest_endpoint = var.kafka_rest_endpoint
  kafka_api_key       = var.kafka_api_key
  kafka_api_secret    = var.kafka_api_secret
}
provider "azurerm" {
  features {}
  subscription_id   = var.az_subscription_id
  tenant_id         = var.az_tenant_id
  client_id         = var.az_client_id
  client_secret     = var.az_client_secret
}

data "confluent_environment" "kafka_environment" {
  display_name = "env_bsw_dev"
}

data "confluent_kafka_cluster" "kafka_cluster"{
  id = var.kafka_cluster_id
  environment{
    id = data.confluent_environment.kafka_environment.id
  }
}

resource "confluent_kafka_topic" "orders" {
  kafka_cluster {
    id = var.kafka_cluster_id
  }
  topic_name    = "orders"
  partitions_count = 1
}

resource "confluent_kafka_acl" "dev-app-producer-write-on-topic" {
  kafka_cluster {
    id = var.kafka_cluster_id
  }
  resource_type = "TOPIC"
  resource_name = confluent_kafka_topic.orders.topic_name
  pattern_type  = "LITERAL"
  principal     = "User:${confluent_service_account.dev-app-producer.id}"
  host          = "*"
  operation     = "WRITE"
  permission    = "ALLOW"
}

resource "confluent_service_account" "dev-app-producer" {
  display_name = "dev-app-producer"
}

resource "confluent_api_key" "dev-app-producer-api-key" {
  display_name = "dev-app-producer-api-key"
  description  = "Kafka API Key that is owned by '*-app-producer' service account"
  owner {
    id          = confluent_service_account.dev-app-producer.id
    api_version = confluent_service_account.dev-app-producer.api_version
    kind        = confluent_service_account.dev-app-producer.kind
  }
  managed_resource {
    id = var.kafka_cluster_id
    api_version = data.confluent_kafka_cluster.kafka_cluster.api_version
    kind = "Cluster"
    environment{
      id =  data.confluent_environment.kafka_environment.id
    }
  }

}
