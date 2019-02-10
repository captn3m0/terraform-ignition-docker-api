// Certs
resource "ignition_file" "ca-cert" {
  path = "/etc/docker/ca.pem"
  mode = 420

  content {
    content = "${tls_locally_signed_cert.ca-cert.cert_pem}"
  }
}

resource "ignition_file" "server-cert" {
  path = "/etc/docker/server.pem"
  mode = 420

  content {
    content = "${tls_locally_signed_cert.server-cert.cert_pem}"
  }
}

resource "ignition_file" "server-key" {
  path = "/etc/docker/server-key.pem"

  // Decimal 384 = Octal 600
  mode = 384

  content {
    content = "${tls_private_key.server-key.private_key_pem}"
  }
}

// Service Configuration
data "ignition_systemd_unit" "docker-tls-tcp-socket" {
  name = "docker-tls-tcp.socket"

  content = <<EOF
[Unit]
Description=Docker Secured Socket for the API

[Socket]
ListenStream=2376
BindIPv6Only=both
Service=docker.service

[Install]
WantedBy=sockets.target
EOF
}

data "ignition_systemd_unit" "docker-api" {
  name = "docker.service"

  dropins = {
    name = "20-clct-docker.conf"

    content = <<EOF
[Service]
Environment="DOCKER_OPTS=--tlsverify --tlscacert=/etc/docker/ca.pem --tlscert=/etc/docker/server.pem --tlskey=/etc/docker/server-key.pem"
EOF
  }
}

// Final Config
data "ignition_config" "main" {
  systemd = [
    "${data.ignition_systemd_unit.docker-api.id}",
    "${data.ignition_systemd_unit.docker-tls-tcp-socket.id}",
  ]

  files = [
    "${data.ignition_file.ca-cert.id}",
    "${data.ignition_file.server-cert.id}",
    "${data.ignition_file.server-key.id}",
  ]
}
