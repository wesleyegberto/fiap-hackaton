# Create Artifact Registry Repository for Docker containers
resource "google_artifact_registry_repository" "spotmusic-repo-back" {
  provider = google-beta

  location = "us-central1"
  repository_id = "spotmusic-back"
  description = "Imagens Docker to SpotMusic BackEnd"
  format = "DOCKER"
}

resource "google_artifact_registry_repository" "spotmusic-repo-front" {
  provider = google-beta

  location = "us-central1"
  repository_id = "spotmusic-front"
  description = "Imagens Docker to SpotMusic FrontEnd"
  format = "DOCKER"
}

resource "google_sql_database" "database" {
  name     = "playlist"
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_database_instance" "instance" {
  name             = "spotmusic-db-instance"
  region           = "us-central1"
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_user" "users" {
  name     = "spotmusic"
  host     = "%"
  instance = google_sql_database_instance.instance.name
}