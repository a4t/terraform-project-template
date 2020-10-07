module "common" {
  source      = "../../common"
  environment = basename(abspath(path.root))
}
