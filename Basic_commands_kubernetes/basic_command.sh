# commands which are used to run to CLI

#Working with nodes 
#to Check the nodes avaliable in kuberents cluster
kubectl get nodes

#to view more information about nodes we can use the -o wide 

kubectl get nodes -o wide

#for detailed information about the node we can describe the node 

kubeclt describe no node-name

#to check the pods on the cluster it will the pods in the default name space  

kubectl get pods 

# for more information about the pods we can use the -o wide 

kubectl get pods -o wide 

# we can us po instead of pods

kubectl get po 
kubectl get po -o wide 

#to check the pods in other namespace 

kubectl get po -n namespace-name

kubeclt get po -A

#for detail information about pods 

kubectl describe po pod-name

#we can edit the pods which are running cluster form CLI 
kubectl edit po pod-name 

#to check deployment in the cluter

kubectl get deployment 

kubectl get deploy -o wide 

#to check the deployment in other namepace 

kubectl get deploy -n namespace-name

kubectl get deploy -A

# we can check the service which are in the cluster 
# we can use svc instead of service
kubectl get service 

kubectl get svc

kubectl get svc -o wide 

#for detailed information we can describe the service

kubectl describe svc svc-name

# for apply thing on the cluster like deployment, pods file, services 

kubectl apply -f /path/to/yaml/file.ymal






