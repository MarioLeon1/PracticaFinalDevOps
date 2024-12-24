module "network" {
  source = "../network"
  
  project_name = var.project_name
  environment  = var.environment
}

module "ecs" {
  source = "../ecs"
  
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.network.vpc_id
  subnet_ids   = module.network.private_subnet_ids
}

module "monitoring" {
  source = "../monitoring"
  
  project_name = var.project_name
  environment  = var.environment
}