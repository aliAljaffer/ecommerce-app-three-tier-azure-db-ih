locals {
  my_name = "devops-ali"
}

module "app_service" {
  source        = "./azure/appservice"
  rg_location   = module.rg.rg_location
  rg_name       = module.rg.rg_name
  my_name       = local.my_name
  db_name       = module.db.db_name
  db_user       = module.db.db_user
  db_server     = module.db.db_server
  db_password   = module.db.db_password
  fe_subnet_id  = module.vnet.fe_subnet_id
  be_subnet_id  = module.vnet.be_subnet_id
  fe_image_name = var.fe_image_name
  fe_image_tag  = var.fe_image_tag
  be_image_name = var.be_image_name
  be_image_tag  = var.be_image_tag
}

module "db" {
  source       = "./azure/db"
  rg_location  = module.rg.rg_location
  rg_name      = module.rg.rg_name
  my_name      = local.my_name
  fe_subnet_id = module.vnet.fe_subnet_id
  be_subnet_id = module.vnet.be_subnet_id
  vnet_id      = module.vnet.vnet_id
  vnet_name    = module.vnet.vnet_name
}

module "rg" {
  source  = "./azure/resourcegroup"
  my_name = local.my_name
}

module "vnet" {
  source      = "./azure/vnet"
  rg_location = module.rg.rg_location
  rg_name     = module.rg.rg_name
  my_name     = local.my_name
}

module "nsg" {
  source       = "./azure/nsg"
  rg_location  = module.rg.rg_location
  rg_name      = module.rg.rg_name
  fe_subnet_id = module.vnet.fe_subnet_id
  be_subnet_id = module.vnet.be_subnet_id
}
