# Multi Conatiner Pods

  when more than one container are running in the pods, they are called multi conatiner pods. Application is dependend on other app to give the input to process the data, for example there application is waiting for file in shared location, so we need a app to ftp the required files on that location. 
  We can have the logging container running with app container to capture the logs, or we need to cache container which is getting the data from DB for application 
  Tightly coupled applications 

## Design-pattern of Multi Container Pod Kuberentes 

  - sidecar pattern 
  - adapter pattern 
  - ambassador pattern 

###  Sidecar Design pattern 
   APP container is running, we need to mointor the log for this app container. We can use the sidecar 
   The web application and a helper container with a responsibility that is vital for your application but is not necessarily a part of the application and might not be needed for the main container to work.

###  Adpater Design pattern 
     The adapter pattern is used to standardize the output by the primary container. Standardizing refers to format the output in a specific manner that fits the standards across your applications.

### Ambassador Design pattern 
    The ambassador design pattern is used to connect containers with the outside world. In this design pattern, the helper container can send network requests on behalf of the main application. It is nothing but a proxy that allows other containers to connect to a port on the localhost
  
  Eg- 
   
    yaml for multicontainer pod = multi-pod.yaml

### init container 
    we can use the init container to setting up the enviroment before starting the main app, we can load required data or check it DB is avaliable or not  before starting the main app, main app will not start until init container is completed successfully

    eg - we are using todo app, we will check if db services are up 
         Yaml file for app - python-todo-app.yaml and for DB service - mysql.yaml 
