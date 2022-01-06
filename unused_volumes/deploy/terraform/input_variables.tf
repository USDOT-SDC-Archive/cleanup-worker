#
# Items with defaults
#


#
# Items without defaults
#
variable "log4sdc_layer" {
  type    = string
}

variable "log_level" {
  type    = string
}


#
# locals to be provided globally
#
locals {
  account_number        = "${data.aws_ssm_parameter.account_number.value}"
  environment        = "${data.aws_ssm_parameter.environment.value}"
  log4sdc_layer        = var.log4sdc_layer
  log_level        = var.log_level

  global_tags = {
    "SourceRepo"  = "cleanup-worker"
    "Project"     = "SDC-Platform"
    "Team"        = "sdc-platform"
    "Environment" = "${data.aws_ssm_parameter.environment.value}"
    "Owner"       = "SDC support team"
  }
}
