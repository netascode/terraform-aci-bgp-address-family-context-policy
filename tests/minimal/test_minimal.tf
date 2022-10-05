terraform {
  required_version = ">= 1.3.0"

  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
}
resource "aci_rest_managed" "fvTenant" {
  dn         = "uni/tn-TF"
  class_name = "fvTenant"
}


module "main" {
  source = "../.."

  name   = "TEST_MINIMAL"
  tenant = aci_rest_managed.fvTenant.content.name
}

# data "aci_rest_managed" "bgpCtxAfPol" {
#   dn = "uni/tn-${aci_rest_managed.fvTenant.content.name}/BD-${module.main.name}/bgpCtxAfP-TEST_MINIMAL"

#   depends_on = [module.main]
# }

# resource "test_assertions" "bgpCtxAfPol" {
#   component = "bgpCtxAfPol"

#   equal "name" {
#     description = "name"
#     got         = data.aci_rest_managed.bgpCtxAfPol.content.name
#     want        = "TEST_MINIMAL"
#   }

#   equal "descr" {
#     description = "descr"
#     got         = data.aci_rest_managed.bgpCtxAfPol.content.descr
#     want        = ""
#   }
# }
