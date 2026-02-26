# Phase 3: Distributed Storage and Databases

This phase transforms the raw, unformatted 100GB disks attached to our 5 worker nodes into a highly available Ceph storage cluster.

## Rook-Ceph Deployment

We utilize the Rook Operator to manage the Ceph lifecycle within Kubernetes. 

1. **Install the Operator:** Apply the CRDs, common roles, and operator manifests from the official Rook repository.
2. **Create the CephCluster:** The `CephCluster` custom resource is configured with `useAllNodes: true` and `useAllDevices: true`. Rook automatically discovers the empty 100GB VHDX drives and provisions Object Storage Daemons (OSDs) on them.
3. **Configure StorageClass:** We define a `CephBlockPool` with a replication factor of 3 (`size: 3`) to ensure high availability. We set `rook-ceph-block` as the default Kubernetes StorageClass.

## Database Deployment (CloudNativePG)

With dynamic storage provisioning enabled, we deploy a PostgreSQL cluster.

1. **Install the Operator:** Deploy the CloudNativePG operator.
2. **Deploy the Cluster:** We define a 5-node PostgreSQL cluster. The operator requests 5 Persistent Volume Claims (PVCs), which Ceph instantly fulfills.
3. **High Availability:** The operator automatically manages leader election. If a primary node fails, a read-only replica is immediately promoted to primary.
