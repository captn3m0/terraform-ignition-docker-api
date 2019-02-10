output "config" {
  value       = "${data.ignition_config.main.rendered}"
  description = "Rendered ignition configuration. Can be used in a append block, or passed as userdata"
}

output "ca-cert" {
  value       = "${tls_self_signed_cert.ca-cert.cert_pem}"
  description = "PEM encoded CA Certificate, used for signing both the server and the client certs"
}

output "client-cert" {
  value       = "${tls_locally_signed_cert.client-cert.cert_pem}"
  description = "PEM encoded client certificate, used to authenticate to the server"
}

output "client-key" {
  value       = "${tls_private_key.client-key.private_key_pem}"
  description = "PEM encoded client key, used to authenticate to the server"
}
