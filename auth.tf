// resources written to disk

resource "local_file" "ca" {
  filename = "${var.cert_path}/ca.pem"
  content  = "${tls_self_signed_cert.ca-cert.cert_pem}"
}

resource "local_file" "cert" {
  filename = "${var.cert_path}/cert.pem"
  content  = "${tls_locally_signed_cert.client-cert.cert_pem}"
}

resource "local_file" "key" {
  filename = "${var.cert_path}/key.pem"
  content  = "${tls_private_key.client-key.private_key_pem}"
}
