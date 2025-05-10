locals {
  service_name = "aws-orleans"
  product_name = "Prototypes"
  
  tags = {
    "service": local.service_name
    "environment": var.environment_name,
    "product": local.product_name
  }
}