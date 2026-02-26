# Phase 5: Ingress and Certificate Management

This document outlines the configuration for exposing cluster services to external traffic using Ingress-NGINX and securing them with automated TLS certificates via cert-manager.

## Architecture Overview

Instead of relying on `NodePort` services for external access, this cluster utilizes an Ingress Controller to route HTTP and HTTPS traffic based on domain names.

* **Ingress Controller:** Ingress-NGINX deployed as a `DaemonSet` to bind directly to worker node host ports.
* **Certificate Management:** `cert-manager` automates the provisioning and lifecycle of TLS certificates.
* **Deployment Method:** Both tools are deployed strictly via ArgoCD GitOps using upstream Helm charts.

## GitOps Deployment Structure

The ingress infrastructure is declared in the `/kubernetes` directory and automatically synchronized by ArgoCD.

1. **Ingress-NGINX Application:** Defined in `ingress-controller.yaml`, this pulls the official NGINX Helm chart and configures it to run on all worker nodes.
2. **cert-manager Application:** Defined in `cert-manager.yaml`, pulling the Jetstack Helm chart with Custom Resource Definitions (CRDs) enabled.
3. **ClusterIssuer:** A self-signed issuer (`cluster-issuer.yaml`) is configured globally for local network testing.
4. **Application Routing:** The web workload (`web-deployment.yaml`) includes an `Ingress` resource that maps the `webapp.local` domain to the backend Nginx service while automatically requesting a TLS certificate from cert-manager.

## Local Verification and Testing

Because `webapp.local` is a private, non-routable domain, local DNS resolution must be simulated on the host machine.

1. Open the Windows `hosts` file as an Administrator (located at `C:\Windows\System32\drivers\etc\hosts`).
2. Add a DNS entry pointing the domain to the IP address of any worker node:
   `192.168.1.21    webapp.local`
3. Save the file and navigate to `https://webapp.local` in a web browser.
4. Bypass the expected self-signed certificate warning to view the securely routed application.
