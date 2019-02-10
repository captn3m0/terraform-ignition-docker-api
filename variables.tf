variable "validity" {
  description = "certificate validity in days, defaults to 365"
  default     = 365
}

variable "ca_subject" {
  description = "The subject block for the CA certificate. See https://www.terraform.io/docs/providers/tls/r/cert_request.html#subject for details"
  type        = "map"
}

variable "server_subject" {
  description = "The subject block for the server certificate. This should be the hostname of the server. See https://www.terraform.io/docs/providers/tls/r/cert_request.html#subject for details"
  type        = "map"
}

variable "client_subject" {
  description = "The subject block for the Client certificate. See https://www.terraform.io/docs/providers/tls/r/cert_request.html#subject for details"
  type        = "map"
}
