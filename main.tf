provider "google" {
  project = "cloud-management-294622"
  region  = "us-central1"
  zone    = "us-central1-c"
}

module "vmseries-modules_vmseries" {
  source  = "PaloAltoNetworks/vmseries-modules/google//modules/vmseries"
  version = "1.2.6"
  # insert the 3 required variables here
  name             = "fw-vmseries-01"
  zone             = "us-central1-c"
  network_interfaces = [
      {
        subnetwork       = "fw-untrust-sub"
        private_ip       = "10.10.11.2"
        create_public_ip = true
      },
      {
        subnetwork       = "fw-mgmt-sub"
        private_ip       = "10.10.10.2"
        create_public_ip = true
      },
      {
        subnetwork = "fw-trust-sub"
        private_ip = "10.10.12.2"
      }
  ]
  vmseries_image   = "vmseries-flex-byol-1110"
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
