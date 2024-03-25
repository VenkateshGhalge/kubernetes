# Pods
pods are smallest unit of deployment which can be created and managed in the Kubernetes 
pod can have one or more container, which share the resources from the host on which kubernetes is installed 

In kubernetes pods are used in 2 ways 

1. Pod run with single container :- one container per pod it is most common case of running the pod

2. Pods run with mutiple container :- in case of app container need of other dependent container , we couple the container in single pod they are tightly coupled 


## Pod Lifecycle 
Pod go though phase when we are creating the pods in the cluster 

1. Pending - pod is accepted by kubernetes cluter, there are one or more container waiting for starting resources, like waiting for container image to downloaded over network 
2. Running - pods has been bound to node and all container are created, at least one container is running. 
3. Succeeded - All container in pods have terminated in success and will not be restarted. 
4. Failed - All containers in the Pod have terminated, and at least one container has terminated in failure.

## Defining Pod Health 
A Pod is Considered Ready When all Container are Ready, if we like understand little more about our application, we can add additional intelligences to our Pod's state and health 

 1. Liveness Probes
    - Runs a diagonstic check on container 
    - per container setting
    - On failure, the kubelet restart the container
    - Container Restart Policy 
    - Give Kubernetes a better understanding of our application 
 2. Readness Probes
     - Run a diagonstic check on the container 
     - if any issue in readness probes, then this pod will not recesive traffice from a services 
     - on failure, pod is removed from the load balancer 
 3. Startup Probes 
    - run a diagnostic check on apps running in the container

Type of diagonstic checks for probs 
   - exec      - process exit check 
   - tcpsocket - successfully open a port 
   - httpGet   - return code 200 => and < 400 

### Example 1. static file servers (Nginx)

   - Do we need liveness Probs ?
    the application is starting up quickly and it will exit if any error, so we don't need the liveness prob 
   - Do we need Readness Probs ?
    Nginx is handling the incoming network traffic, so we need the readness probe 
   eg-
    Yaml files - static_file_servers_nginx.yaml 

### Example 2. 

 