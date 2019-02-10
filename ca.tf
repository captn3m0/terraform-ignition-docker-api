resource "tls_private_key" "ca-key" {
  algorithm = "ECDSA"
}

resource "tls_self_signed_cert" "ca-cert" {
  key_algorithm   = "RSA"
  private_key_pem = "${tls_private_key.ca-key.private_key_pem}"

  subject = "${var.ca_subject}"

  validity_period_hours = "${var.validity * 24}"
  is_ca_certificate     = true

  allowed_uses = [
    "key_encipherment",
    "cert_signing",
  ]
}
