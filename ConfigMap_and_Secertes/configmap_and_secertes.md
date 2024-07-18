# ConfigMap and Secertes 

we can decouple the configuration from pod using externally configuraion 

congfiguring application in POD by 
1. command line arguments 
2. Environment Variable 
3. ConfigMap

kubernetes ConfigMap is a build in kubernetes API object that is used to store your application non-sensitive key-value config data. ConfigMap hlep to keep data separate from your code and container image. Vlaues are stored in string or BASE64-encoded binary data 

ones data is stored in the configMap we can use the data in kubernetes cluster. Pod can consume the configMap data as environment variable, command line arguments or filesystem volume. 

#### eg for configMap 

apiVersion: v1
kind: ConfigMap 
metadata: 
  name: demo-config
data:
  database_host: "192.168.0.1"
  debug_mode: "1"
  log_level: "verbose"


- mounting configMap into pods as enviroment variable 

apiVersion: v1
kind: pod
metadata: 
  name: demo-pod
spec:
  containers:
    - name: app
      command: ["/bin/sh","-c","printenv"]
      image: busybox:latest
      envFrom:
        - configMapRef:
            name: demo-config

- mounting configMaps into Pods as commandline arguments 

apiVersion: v1
kind: Pod
metadata:
  name: demo-pod
spec:
  containers:
    - name: app
      command: ["demo-app","--database-host","$(DATABASE_HOST)" ]
      image: demo-app:latest
      env: 
        - name: DATABASE_HOST
          valueFrom:
            configMapKeyRef:
              name: demo-config
              key: database_host

- mounting configMap into pods as volumes

apiVersion: v1
kind: Pod
metadata:
  name: demo-pod
spec:
  containers:
    - name: app
      command: ["ls","/etc/app-config" ]
      image: demo-app:latest
      volumeMounts:
        - name: config
          mountPath: "/etc/app-config"
          readOnly: true
  volumes:
    - name: config
      configMap: 
        name: demo-config
          