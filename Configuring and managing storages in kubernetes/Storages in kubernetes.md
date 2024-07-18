# Storage in Kubernetes

Kubernetes the most basic storage is non-persistent also known as ephemeral. Each container has ephemeral storage by default, this storage are temporary directory on the machin and ones pod is restarted data will be lost so it is not durable. 
Kubernetes support the persistent storage, there are mulitple type of storage like file, block or object storage services on cloud, storage devices on local 

  - CSI (Container Storage Interface )

      Kuberenetes add this services to overcome storage issue, CSI provides an extensible pulgin architecture 

  - Volume
      Volume is basic entities in kubernetes used to provide storage to container. A volume can support all type of storage, including network file storage (NFS), local storage devices and cloud based storage services.

  - Persistent Storage 
      Kubernetes also support a varity of persistent storage models, including files, block storage, object storage and cloud services. Storage can be referenced directly within a pods

## Storage API object in kubernetes 

    1. Persistent Volume 
    2. Persistent Volume Claim 
    3. Storage Class  

### Persistent Volume 

    A PV is a storage resources located in the cluster. Administrators can manually provision PVs, and Kubernetes can use storage can use storage classes to dynamically provision PVs. PVs are plugins, but there lifecycle is indepenedent of the pods lifecycle 

####    eg -  creating the basic yaml file for PV 

    kind: PersistentVolume
    apiVersion: v1
    metadata:
      name: pv_sip
    spec:
      capacity:
        storage: 10Gi
      accessModes:
      - ReadWriteMany
      storageClassName: defult 
      hostPath:
        path: "/mnt/data"

   - Administrator define storage in cluster 
   - implementation detail is for your cluster 
   - LifeCycle independent of the pods lifecycle 
   - PV is managed by kubelet 
   - PV is maps the storage to node 
   - Exposes PV as mount inside the container

   Type of Persistent Volumes 
   - Network - NFS, azureFile 
   - Block - Fiber channel, iSCSI
   - Cloud - awsElasticBlockStorage, azureDisk 

### Persistent Volume Claims (PVC)
   When Pod needs the storage we can request the Storage using PVC, PVC will consume PV resources.Pods we use the storage using PVC.

#### eg - creating the basic yaml file for PVC 

   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: persistent-volume-claim
   spec:
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: 5Gi
  

#### Flow of Volume Claim

     persistentVolume ---> persistentVolumeClaim ---> Volume ---> volumeMount ---> mountPath

if we delete the pod and PVC the status of PV is released and new PVC will not be able to attach to this PV. It is due to RECLAIM POLICY which is retain so we/Admin have to take a call to delete the PV as storage may have some important data 

kubectl delete pod pod[name]
kubectl delete PersistentVolumeClaim pvc-nfs-data


## Dynamic Provisioning 
  
  - StorageClass is used for Dynamic provisioning 
  - Define tiers/Classes of storage 
  - Enable Dynamic Provisioning 
  - define infrastucture specific parameter 
  - Reclaim Policy 

#### eg for storageClass 


  apiVersion: storage.k8s.io/v1
  kind: StorageClass
  metadata:
    name: slow 
  provisioner: kubernetes.io/gce-pd
  parameters:
    type: pd-standard

  apiVersion: storage.k8s.io/v1
  kind: StorageClass
  metadata:
    name: fast 
  provisioner: Kubernetes.io/gce-pd
  parameters:
    type: pd-ssd


using the storageclass in PVC 

  apiVersion: v1
  kind: PersistentVolumeClaim
  metadata: 
    name: claim1
  spec: 
    accessModes:
      - ReadWriteOnce
    storageClassName: fast
    resources:
      requests:
        storage: 30Gi 