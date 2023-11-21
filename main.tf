module "vmseries-modules_example_standalone_vmseries_with_metadata_bootstrap" {
  source  = "PaloAltoNetworks/vmseries-modules/google//examples/standalone_vmseries_with_metadata_bootstrap"
  version = "1.2.6"
  name              = var.name
  project           = var.project
  region            = var.region
  allowed_sources   = ["0.0.0.0"]
  vmseries_image    = "vmseries-flex-byol-1110"
  ssh_keys          = var.ssh_keys
  bootstrap_options = {
      type                = "dhcp-client"
      panorama-server     = "cloud"
      dgname              = var.folder
      dns-primary         = "8.8.8.8"
      dns-secondary       = "8.8.4.4"
      # op-command-modes    = "mgmt-interface-swap"
      plugin-op-commands  = "advance-routing:enable"
      vm-series-auto-registration-pin-id    = var.cert-pin-id
      vm-series-auto-registration-pin-value = var.cert-pin-value
      authcodes           = var.authcodes
      }
}
