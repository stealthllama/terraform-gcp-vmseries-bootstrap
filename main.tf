# provider "google" {
#   project = "cloud-management-294622"
#   region  = "us-central1"
#   zone    = "us-central1-c"
# }

module "vmseries-modules_example_standalone_vmseries_with_metadata_bootstrap" {
  source  = "PaloAltoNetworks/vmseries-modules/google//examples/standalone_vmseries_with_metadata_bootstrap"
  version = "1.2.6"
  name              = "gcp-fw"
  project           = "cloud-management-294622"
  region            = "us-central1"
  allowed_sources   = {"0.0.0.0"}
  vmseries_image    = "vmseries-flex-byol-1110"
  ssh_keys          = var.ssh_keys
  bootstrap_options = {
      panorama-server     = "cloud"
      dgname              = "Test-Folder"
      dns-primary         = "8.8.8.8"
      dns-secondary       = "8.8.4.4"
      op-command-modes    = "mgmt-interface-swap,jumbo-frame"
      plugin-op-commands  = "advance-routing:enable"
      vm-series-auto-registration-pin-id    = var.cert-pin-id
      vm-series-auto-registration-pin-value = var.cert-pin-value
      authcodes           = var.authcodes
      }
}
