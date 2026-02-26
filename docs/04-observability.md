# Phase 4: Observability

To maintain cluster health, we deploy a comprehensive monitoring stack using `kube-prometheus-stack` via Helm.

## Deployment Steps

1. Add the Prometheus Community Helm repository:
   ```bash
   helm repo add prometheus-community [https://prometheus-community.github.io/helm-charts](https://prometheus-community.github.io/helm-charts)
