# Фиксируем версию провайдера AWS, чтобы гарантировать совместимость
# и стабильную работу написанной конфигурации
terraform {
  required_providers {
    aws = {
      # Используем локальное зеркало Облака КРОК как источник загрузки провайдера.
      # Провайдер из зеркала полностью идентичен провайдеру из оригинального 
      # репозитория и позволит избежать трудностей при установке.
      source  = "hc-registry.website.cloud.croc.ru/hashicorp/aws"
      version = "~> 3.63.0"
    }
  }
}

# Подключаем и настраиваем провайдера для работы
# со всеми сервисами Облака КРОК, кроме объектного хранилища
provider "aws" {
  endpoints {
    ec2 = "https://api.cloud.croc.ru"
  }

  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_region_validation      = true

  insecure   = false
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "croc"
}

# Подключаем и настраиваем провайдера
# для работы с объектным хранилищем облака
provider "aws" {
  alias = "noregion"
  endpoints {
    s3 = "https://storage.cloud.croc.ru"
  }

  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_region_validation      = true

  insecure   = false
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "us-east-1"
}
