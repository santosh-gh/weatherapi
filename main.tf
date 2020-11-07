provider "azurerm"{
    version = "2.5.0"
    features{}
}

terraform {
    backend "azurerm"{
        resource_group_name     = "rg_storage"
        storage_account_name    = "terraformstorageac"
        container_name          = "terraformstatefile"
        key                     = "terraform.tfstate"

    }    
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
        image   = "e880613/weatherapi:v1"
        cpu     = "1"
        memory  = "1"

        ports{
            port = 80
            protocol = "TCP"
        }

    }

}