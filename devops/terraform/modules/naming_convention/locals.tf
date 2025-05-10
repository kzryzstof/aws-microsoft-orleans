locals {
  name       = lower(replace("${var.type}${var.delimiter}${var.name}${var.delimiter}${var.environment}${var.delimiter}${var.instance}", var.regex_replace_chars, ""))
  short_name = lower(replace("${var.type}${var.name}${substr(var.environment, 0, 1)}${var.instance}", var.regex_replace_chars, ""))
}
