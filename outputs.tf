output "fw_mgmt_public_ip" {
  value = module.vmseries-modules_example_standalone_vmseries_with_metadata_bootstrap.vmseries_public_ips
}
output "fw_mgmt_private_ip" {
  value = module.vmseries-modules_example_standalone_vmseries_with_metadata_bootstrap.vmseries_private_ips
}