resource "tls_cert_request" "server-csr" {
  key_algorithm   = "RSA"
  private_key_pem = "${tls_private_key.server-key.private_key_pem}"

  subject = ["${var.server_subject}"]

  ip_addresses = [
    "127.0.0.1",
  ]

  dns_names = ["${lookup(var.server_subject, "common_name")}"]
}

resource "tls_private_key" "server-key" {
  algorithm = "RSA"
}

resource "tls_locally_signed_cert" "server-cert" {
  cert_request_pem   = "${tls_cert_request.server-csr.cert_request_pem}"
  ca_key_algorithm   = "RSA"
  ca_private_key_pem = "${tls_private_key.ca-key.private_key_pem}"
  ca_cert_pem        = "${tls_self_signed_cert.ca-cert.cert_pem}"

  validity_period_hours = "${var.validity * 24}"

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth",
  ]
}
