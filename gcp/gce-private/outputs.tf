output "vm_private_ip" {
  value = google_compute_instance.vm.network_interface.0.network_ip
}
