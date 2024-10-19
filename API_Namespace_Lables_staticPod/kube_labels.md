Labels 
Used to organise resources -pods,nodes and more 
Label selector are used to select/query object 

Labels and selector 
they are used to connect kubernetes services with kubernetes pod, labels are key value pairs which is used to identifiy the pod

### in pod.yaml we have mentioned the labels in metadata 
## we can check what labels are given to pods 

kubectl get pods --namespace dev --show-labels

## adding labels from cmd 

kubectl label pod nginx --namespace dev tier=PORD


## Query the pods using label and selector

kubectl get pods --namespace dev --show-labels

kubectl get pods --namespace dev --selector tier=PROD

Kubectl get pods -n dev -l 'tier in (PROD,QA)'

## delete the pods using the labels

kubectl delete pod -n dev -l tier=PROD


## we can add the labels to node, which can help to deploy pod to secific node 

kubectl label node <node_name> SERVER=BATCH 

kubectl label node  minikube-m02 server=Batch 

## we can deploy the pod to this node by using nodeselector in yaml file 

eg - pod.yaml

apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    env: test
spec:
  containers:
  - name: nginx
    image: nginx
  nodeSelector:
    server: Batch

## apply this file using kubectl 

kubectl apply -f pod.yaml

kubectl get pods -o wide 


