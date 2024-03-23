In Kubernetes namespace provides way to group the resources in the cluster, like dev environment, stage environment and production environment or we can goup the resources on the basises of different applications 
Note - there are few resources they are not in a namespace like (storage class, node, PersistentVloume)

there are 4 namespace when you create the new cluter 

1. default 
  it is for user to start creating the resources in the cluster, without need of creating the cluster 

2. kube-node-lease
  in this namespace for each node there is lease object, which is stored in this namespace 
  node lease allows kubelet to send hearbeats, so control plane can detect node failure.

3. kube-public 
  This namespace is mostly reserved for cluster usage, in case that some resources should be visible and readable publicly throughout the whole cluster.

4. kube-system
  The namespace for objects created by the Kubernetes system

# creating the nampespace using CLI

kubectl create namespace dev

# checking all namespace is cluster 

kubectl get namespace 

# Creating pod in namespace using cmd 

kubectl run nginx --image=nginx --namespace dev

# checking pod is created or not 

kubectl get pods --namespace dev 

# if you have not mentioned namespace in the yaml file then you can mention it on CLI

kubectl apply -f pod.yaml --namespace=dev 

# deleteing the pod

kubectl delete pods nginx --namespace dev


