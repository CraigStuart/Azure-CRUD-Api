variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(any)
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "sql_connection_string" {
  type = string
}
