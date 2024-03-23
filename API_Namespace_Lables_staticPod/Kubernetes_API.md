API in kubernetes

kubectl is using the API for interacting with kubernetes cluster, for interaction with node API is used 

API GROUP - there are 2 type of API group 
1. Core API group (Legacy group)
2. Name API Group - eg -Storage API group 

Core API Group
 they are main resources of kubernetes cluster
 1. POD
 2. NODE
 3. Namespace
 4. PersistentVolume
 5. PersistentVolumeClaim

Name API Group
 1. apps - Deployment
 2. storage.k8.io - storage class
 3. rbac.authorization.k8s.io - Role

# for checking the avaliable API resources 

kubectl api-resources | more 

# if you what specifice resources 

kubectl api-resources | grep namespace


Flow of API Request from client to server

Client request ---> connection --->Authentication ---> Authorization ---> Admission control ---> server response 