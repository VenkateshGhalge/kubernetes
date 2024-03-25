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
    -> Runs a diagonstic check on container 
    -> per container setting
    -> On failure, the kubelet restart the container
    -> Container Restart Policy 
    -> Give Kubernetes a better understanding of our application 
 