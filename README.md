# terraform-ignition-docker-api

Terraform Configuration using the Ignition Provider to setup a Docker API endpoint.

This generates the certs, and returns them as output. This is based on the official
[CoreOS documentation][docs]:

[docs]: https://coreos.com/os/docs/latest/customizing-docker.html#enable-the-remote-api-with-tls-authentication

## Required Inputs

The following input variables are required:

### ca\_subject

Description: The subject block for the CA certificate. See https://www.terraform.io/docs/providers/tls/r/cert_request.html#subject for details

Type: `map`

### client\_subject

Description: The subject block for the Client certificate. See https://www.terraform.io/docs/providers/tls/r/cert_request.html#subject for details

Type: `map`

### server\_subject

Description: The subject block for the server certificate. This should be the hostname of the server. See https://www.terraform.io/docs/providers/tls/r/cert_request.html#subject for details

Type: `map`

## Optional Inputs

The following input variables are optional (have default values):

### cert\_path

Description: path to write the client config to

Type: `string`

Default: `"/dev/null"`

### validity

Description: certificate validity in days, defaults to 365

Type: `string`

Default: `"365"`

## Outputs

The following outputs are exported:

### ca-cert

Description: PEM encoded CA Certificate, used for signing both the server and the client certs

### client-cert

Description: PEM encoded client certificate, used to authenticate to the server

### client-key

Description: PEM encoded client key, used to authenticate to the server

### config

Description: Rendered ignition configuration. Can be used in a append block, or passed as userdata

