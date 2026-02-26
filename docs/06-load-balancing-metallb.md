# Phase 6: Bare-Metal Load Balancing with MetalLB

This document details the configuration for providing dedicated, routable IP addresses to Kubernetes services using MetalLB, bridging the gap between bare-metal clusters and cloud-provider LoadBalancer implementations.

## Architecture

* **MetalLB Deployment:** Deployed via ArgoCD using the official Helm chart.
* **Mode:** Layer 2 (ARP) mode is used to broadcast IP ownership to the local network router.
* **IP Address Pool:** MetalLB is assigned a dedicated block of IPs (`192.168.1.240-192.168.1.250`) that are strictly excluded from the local router's DHCP scope to prevent network collisions.

## Configuration via GitOps

1. **`metallb.yaml`**: The ArgoCD application that provisions the MetalLB controller and speaker pods.
2. **`metallb-config.yaml`**: Contains the `IPAddressPool` and `L2Advertisement` Custom Resources defining the network behavior.
3. **Ingress Integration:** The `ingress-controller.yaml` is configured to use `type: LoadBalancer`. MetalLB intercepts this request and permanently assigns the first available IP from its pool (e.g., `192.168.1.240`) to the Ingress NGINX service.

All external traffic bound for cluster applications is now securely routed through this single, highly available virtual IP.
