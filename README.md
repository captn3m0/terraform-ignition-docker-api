# terraform-ignition-docker-api ![](https://img.shields.io/badge/license-MIT-blue.svg) ![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/captn3m0/terraform-ignition-docker-api.svg) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

Terraform Configuration using the Ignition Provider to setup a Docker API endpoint.

This generates the certs, and returns them as output. This is based on the official
[CoreOS documentation][docs].

You can see the inputs and outputs at the [Terraform Registry](https://registry.terraform.io/modules/captn3m0/docker-api/ignition/) or [MODULE.md](MODULE.md).

## Usage

```hcl
module "ignition" {
  source  = "captn3m0/docker-api/ignition"
  version = "1.0.4"

  ca_subject = {
    common_name = "ca.docker"
  }

  client_subject = {
    common_name = "client.docker"
  }

  server_subject = {
    common_name = "docker-server"
  }
}

// The return value from this is a userdata blob, so you can either
// upload it to S3 and then append the S3 URL to your userdata, like:
resource "aws_s3_bucket_object" "s3" {
    key     = "docker.json"
    bucket  = "ignition-bucket"
    content = "${module.ignition.config}"
}

data "ignition_config" {
    // Rest of your config goes here
    systemd = []
    // Append these users to the config
    append {
        source       = "s3://${aws_s3_bucket_object.bucket}/${aws_s3_bucket_object.key}"
        verification = "${module.ignition.verification}"
    }
}

// Or alternatively, you may use the source/verification outputs:
// This uses a data-uri
data "ignition_config" {
    // Rest of your config goes here
    systemd = []
    // Append these users to the config
    append {
        source       = "${module.ignition.source}"
        verification = "${module.ignition.verification}"
    }
}
```

## License

Licensed under the [MIT License](https://nemo.mit-license.org/). See LICENSE file for details.
