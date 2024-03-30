# Controller Mananger 

kube-controller-Manger is responsible for to running core controller, keeping the central plane in desired state 

there is reprate controlle plan for cloud called as cloud-controller-manager 

controllers
 - Pods Controller 
   1. ReplicaSet
   2. Deployment 
   3. DeamonSet
   4. StatefulSet
   5. Job
   6. CronJob

- other controller
  1. Node
  2. Service
  3. Endpoint

how POD file is different from deployment file 
one pod file is deployed, after that controll plan will not monitor on that pod, if is failed or not 
where as for Deployment there is a controller which making shower, all pod are up as per given replicas in deployment file, if pod is failed due to some issue controller will start the other pod to match the replica given in deployment file 
  
we will work with deployment controller, we are going the deploy simple hello world yaml file, after that we will update the container image to new version and apply the deployment.

 1. we will deploy hello-world.yaml file first, using below command
    kubectl apply -f hello-world.yaml
    we can check the status of deployment 

      kubectl get pods 

 2. now we will update the the app image to 2.0 
    image = gcr.io/google-samples/hello-app:2.0 in same file 

      kubectl apply -f hello-world 

    to check the status of new rollout, we can use this command 

      kubectl rollout status deployment hello-world

   below is the out image for rollout command

   ![alt text](image.png)
    
  Both replicasets remain, that will become very useful when we need to rollback. replicaset for app version 1 and 2 

    kubectl get replicaset 

### Deployment strategies 
   - Recreating 
   - Rolling 
   - Blue/Green

   Kubernetes by deafult uses Rolling deployment strategy

   - Recreating Deployment 
     Recreating deployment will terminate all the pod and replace them with new version. It can be usefull when old and new apps cannot run at same time 

     ![alt text](image-1.png)

   - Rolling Deployment 
     Rolling deployment is default strategy for kubernetes.
     rolling deployment will triggered when something changed in pod spec, such as pod image, labels or environment are updated in pod 
     we can update the image of the pod using below command 
     kubectl set image 

     The spec: -> strategy: section of the manifest file can be used to refine the deployment by making use of two optional parameters — maxSurge and maxUnavailable. Both can be specified using a percentage or absolute number. A percentage figure should be used when Horizontal Pod Autoscaling is used.

      - MaxSurge specifies the maximum number of pods the Deployment is allowed to create at one time.
      - MaxUnavailable specifies the maximum number of pods that are allowed to be unavailable during the rollout.  
        
        ![alt text](image-2.png)

   - Blue/Green Deployment 
     This involves deploying the new application version (green) along side current version running on Blue. Ones new version is test and passed successfully then they will move the traffice to new version (Green), if there is any issue they will move back to current running version. After deployment is completed successfully Green will become blue and blue will become green 

  We can pause the Deployment if we there is some issue with the deployment, by using below command 

     kubectl rollout pause deployment my-deployment

  we can resume the deployment
 
     kubectl rollout resume my-deployment 

  If we need to Rollback to old version we can use the, below command 

     kubectl rollout history deployment hello-world

     kunectl rollout history deployment hello-world --reivison=1

  Restart Deployment 
  Effective restart all the pods, But no pods are ever "recreated"
  New Replicaset with same spec 
  If you what to restart the Deployment with below command 

     kubectl rollout restart deployment hello-world

  undo the deployment to specifie version 

      kubectl rollout undo deployment hello-world --to-revision=2

## DeamonSet 

  Deamonset object are designed to ensure that single pod is running on all nodes or selected nodes, we cann't scale up the Deamonset pods in a node. Due to some reason deamonset pod gets deleted, Demaonset controller will create the pod again. lets take example, if we what a deamonset pod to run on nodes on which DB pod are running. We can deploy the deamon set on selected nodes using nodeSelector, nodeAffinity, Taints and Tolerations 

  were can we use the Deamonset 
   1. cluster Log Collected:Running a log collector on every node to centralize  Eg- fluentd, logstash

   2. Cluster Monitoring : Deploy monitoring agent, such as Prometheus Node, on each node in the cluster to collect and expose the node level metrics 

   3. Security and Compliances: Running CIS Benchmark on evey node using tools like kube-bench. Also deploy the security agent, such as intrusion detection system or vulnearability scanners, on specific node 

  example : daemonset-example.yaml file for cluster logging 
       
       kubectl apply -f daemonset-example.yaml

    to check the daemonset deployed

      kubectl get daemonset

## Job LifeCycle 

  They are short term running pod, they will run till given task is completed. Ones task is completed pods will get terminated, if task is failed it will re-try to run again. Job may create one or more pods are per-requirement ones task is completed they will terminated.

  - Type of kubernetes Jobs
     1. Non-paralle Jobs
     2. Multiple parallel Jobs 
     3. Parallel Jobs with Fixed Number of completions 
     
      