/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

output "project_id" {
  description = "The Project-ID"
  value       = google_compute_vpn_gateway.vpn_gateway.project
}

output "name" {
  description = "The name of the Gateway"
  value       = google_compute_vpn_gateway.vpn_gateway.name
}

output "network" {
  description = "The name of the VPC"
  value       = google_compute_vpn_gateway.vpn_gateway.network
}

output "gateway_ip" {
  description = "The VPN Gateway Public IP"
  value       = google_compute_forwarding_rule.vpn_esp.ip_address
}

output "vpn_tunnels_names" {
  description = "The VPN tunnel name is"
  value       = google_compute_vpn_tunnel.tunnel.*.name
}

output "ipsec_secret" {
  description = "The secret"
  value       = google_compute_vpn_tunnel.tunnel.*.shared_secret
}
