module "vmseries-modules_example_standalone_vmseries_with_metadata_bootstrap" {
  source  = "PaloAltoNetworks/vmseries-modules/google//examples/standalone_vmseries_with_metadata_bootstrap"
  version = "1.3.3"
  name              = var.name
  project           = var.project

  vmseries = {
    "vmseries-fw" = {
      name             = var.name
      project          = var.project
      zone             = "us-central1-b"
      vmseries_image   = "vmseries-flex-byol-1112"
      ssh_keys         = var.ssh_keys
      machine_type     = "n2-standard-4"
      min_cpu_platform = "Intel Cascade Lake"
      scopes = [
        "https://www.googleapis.com/auth/compute.readonly",
        "https://www.googleapis.com/auth/cloud.useraccounts.readonly",
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring.write",
      ]
      bootstrap_options = {
        type                                  = dhcp-client
        dhcp-accept-server-domain             = yes
        panorama-server                       = cloud
        dgname                                = var.folder
        plugin-op-commands                    = "advance-routing:enable"
        vm-series-auto-registration-pin-id    = var.cert-pin-id
        vm-series-auto-registration-pin-value = var.cert-pin-value
        authcodes                             = var.authcodes
      }
      network_interfaces = [
        {
          vpc_network_key  = "vmseries-vpc"
          subnetwork_key   = "vmseries-subnet"
          create_public_ip = true
        }
      ]
    }
  }
  networks = {
  "vmseries-vpc" = {
    vpc_name                        = "firewall-vpc"
    create_network                  = true
    delete_default_routes_on_create = "false"
    mtu                             = "1460"
    routing_mode                    = "REGIONAL"
    subnetworks = {
      "vmseries-sub" = {
        name              = "vmseries-subnet"
        create_subnetwork = true
        #ip_cidr_range     = "172.21.21.0/24"
        region            = "us-central1"
      }
    }
    firewall_rules = {
      "allow-vmseries-ingress" = {
        name             = "vmseries-mgmt"
        source_ranges    = ["0.0.0.0/0"]
        priority         = "1000"
        allowed_protocol = "all"
        allowed_ports    = []
      }
    }
  }
}
