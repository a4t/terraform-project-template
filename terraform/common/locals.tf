locals {
  common_tags = {
    ServiceStack       = "project-template"
    ServiceName        = "project-template"
    ServiceEnvironment = var.environment
    ServiceDocument    = "http://github.com/"

    AccessUser = "Operation"
    UseData    = "InternalUseOnly"

    AccessIpLimit           = "false"
    AccessAuthIdAndPassword = "true"
    AccessAuthMFA           = "true"

    OtherContact        = "a4t"
    OtherExpirationDate = "2038-01-01"
  }
}
