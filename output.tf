output "config" {
  value       = "${data.ignition_config.main.rendered}"
  description = "Rendered ignition configuration. Can be used in a append block, or passed as userdata"
}
