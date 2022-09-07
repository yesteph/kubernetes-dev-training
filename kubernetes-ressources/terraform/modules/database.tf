resource "google_sql_database_instance" "training" {
  name             = var.MOD_PROJECT
  database_version = "POSTGRES_14"
  region           = var.MOD_REGION

  deletion_protection = false

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name  = "Internet"
        value = "0.0.0.0/0"
      }
    }
  }
}

resource "random_password" "training" {
  length  = 16
  special = false
}

resource "google_sql_user" "training" {
  name     = "training"
  instance = google_sql_database_instance.training.name
  password = random_password.training.result
}

resource "google_secret_manager_secret" "database_credentials" {
  secret_id = "training-database-credentials"

  replication {
    automatic = true
  }
}


resource "google_secret_manager_secret_version" "database_credentials" {
  secret = google_secret_manager_secret.database_credentials.id

  secret_data = <<EOT
ip = ${google_sql_database_instance.training.public_ip_address}
username = ${google_sql_user.training.name}
password = ${google_sql_user.training.password}
EOT
}
