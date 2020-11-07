provider "azurerm"{
    version = "2.5.0"
    features{}
}

terraform {
    backend "azurerm"{
        subscription_id         = "fdc7ca00-0892-48b6-a411-cf66b3774c76"
        resource_group_name     = "rg_storage"
        storage_account_name    = "terraformstorageac"
        container_name          = "homecontainer"
        key                     = "root.terraform.tfstate"
    }    
}
variable "imagebuild" {
  type        = string
  description = "Latest Image Build"
}

resource "azurerm_resource_group" "tf_test" {
    name        = "tfmainrg"
    location    = "South India"
}

resource "azurerm_container_group" "tfcg_test" {
    name                    = "weatherapi"
    location                = azurerm_resource_group.tf_test.location
    resource_group_name     = azurerm_resource_group.tf_test.name
    ip_address_type         = "public"
    dns_name_label          = "e880613"
    os_type                 = "Linux"

    container {
        name    = "weatherapi"
        image   = "e880613/weatherapi:${var.imagebuild}"
        cpu     = "1"
        memory  = "1"

        ports{
            port = 80
            protocol = "TCP"
        }

    }

}