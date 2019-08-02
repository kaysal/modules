resource "google_container_cluster" "cluster" {
  provider = google-beta
  project  = var.project

  name            = var.name
  description     = var.description
  resource_labels = var.cluster_labels
  location        = var.location
  network         = var.network
  subnetwork      = var.subnetwork

  logging_service    = var.logging_service
  monitoring_service = var.monitoring_service
  min_master_version = var.min_master_version != null ? var.min_master_version : local.kubernetes_version

  remove_default_node_pool = true
  initial_node_count       = 1

  default_max_pods_per_node   = var.default_max_pods_per_node
  enable_binary_authorization = var.enable_binary_authorization

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_range_name
    services_secondary_range_name = var.services_range_name
  }

  private_cluster_config {
    enable_private_endpoint = var.disable_public_endpoint
    enable_private_nodes    = var.enable_private_nodes
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  dynamic "master_authorized_networks_config" {
    for_each = var.master_authorized_networks_config
    content {
      dynamic "cidr_blocks" {
        for_each = lookup(master_authorized_networks_config.value, "cidr_blocks", [])
        content {
          cidr_block   = cidr_blocks.value.cidr_block
          display_name = lookup(cidr_blocks.value, "display_name", null)
        }
      }
    }
  }

  addons_config {
    http_load_balancing {
      disabled = ! var.http_load_balancing
    }

    horizontal_pod_autoscaling {
      disabled = ! var.horizontal_pod_autoscaling
    }

    kubernetes_dashboard {
      disabled = ! var.enable_kubernetes_dashboard
    }

    network_policy_config {
      disabled = ! var.enable_network_policy
    }

    istio_config {
      disabled = ! var.enable_istio_config
      #auth = "AUTH_MUTUAL_TLS"
    }
  }

  network_policy {
    provider = "CALICO"
    enabled  = var.enable_network_policy
  }

  master_auth {
    username = var.basic_auth_username
    password = var.basic_auth_password

    client_certificate_config {
      issue_client_certificate = var.enable_kubernetes_dashboard
    }
  }

  timeouts {
    update = "20m"
    delete = "20m"
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = var.maintenance_start_time
    }
  }
}

# Prepare locals to keep the code cleaner

locals {
  latest_version     = data.google_container_engine_versions.location.latest_node_version
  kubernetes_version = var.kubernetes_version != "latest" ? var.kubernetes_version : local.latest_version
}

# Pull in data
# Get available master versions in our location to determine the latest version

data "google_container_engine_versions" "location" {
  location = var.location
  project  = var.project
}
