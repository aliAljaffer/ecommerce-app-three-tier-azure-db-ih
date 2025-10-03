locals {
  fe_app_name = "${var.my_name}-fe-app"
  be_app_name = "${var.my_name}-be-app"
}

resource "azurerm_linux_web_app" "fe_app" {
  name                      = local.fe_app_name
  location                  = var.rg_location
  resource_group_name       = var.rg_name
  service_plan_id           = azurerm_service_plan.b1plan_fe.id
  virtual_network_subnet_id = var.fe_subnet_id

  site_config {

    always_on = true
    application_stack {
      docker_image_name = "${var.fe_image_name}:${var.fe_image_tag}"
      # alialjaffer/project2-fe:latest
      docker_registry_url = "https://index.docker.io"
    }

    health_check_path                 = "/"
    health_check_eviction_time_in_min = 5
  }

  app_settings = {
    REACT_APP_API_URL = "https://${local.be_app_name}.azurewebsites.net/api"
  }
}

resource "azurerm_linux_web_app" "be_app" {
  name                      = local.be_app_name
  location                  = var.rg_location
  resource_group_name       = var.rg_name
  service_plan_id           = azurerm_service_plan.b1plan_be.id
  virtual_network_subnet_id = var.be_subnet_id
  site_config {
    always_on = true
    cors {
      allowed_origins = ["https://${local.fe_app_name}.azurewebsites.net"]
    }
    application_stack {
      docker_image_name   = "${var.be_image_name}:${var.be_image_tag}"
      docker_registry_url = "https://index.docker.io"

    }

    health_check_path                 = "/health"
    health_check_eviction_time_in_min = 5
  }

  app_settings = {
    # Server Configuration
    PORT     = 3001
    NODE_ENV = "development"

    # Azure SQL Database Configuration
    DB_SERVER                   = var.db_server
    DB_NAME                     = var.db_name
    DB_USER                     = var.db_user
    DB_PASSWORD                 = var.db_password
    DB_ENCRYPT                  = true
    DB_TRUST_SERVER_CERTIFICATE = false
    DB_CONNECTION_TIMEOUT       = 30000

    # JWT Configuration
    JWT_SECRET     = "your-sup-${uuid()}"
    JWT_EXPIRES_IN = "7d"


    # CORS Configuration
    CORS_ORIGIN = "https://${local.fe_app_name}.azurewebsites.net"


    # Rate Limiting
    RATE_LIMIT_WINDOW_MS    = 900000
    RATE_LIMIT_MAX_REQUESTS = 100
  }
}



resource "azurerm_service_plan" "b1plan_fe" {
  name                = "b1"
  location            = var.rg_location
  resource_group_name = var.rg_name
  os_type             = "Linux"
  sku_name            = "B1"
}
resource "azurerm_service_plan" "b1plan_be" {
  name                = "b1"
  location            = var.rg_location
  resource_group_name = var.rg_name
  os_type             = "Linux"
  sku_name            = "B1"
}
