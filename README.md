# Overveiw of the Program

This program is very simple, it connects to a MySQL database based on the following env vars:
* MYSQL_HOST
* MYSQL_USER
* MYSQL_PASS
* MYSQL_PORT

And exposes itself on port 9090:
* On `/healthcheck` it returns an OK message, 
* On GET it returns all recorded rows.
* On POST it creates a new row.
* On PATCH it updates the creation date of the row with the same ID as the one specified in query parameter `id`# instaBug

## what is the purpose of the task:
- Fix bugs in code
- Dockerizing App
- Compose the API image & Mysql
- CI/CD Jenkins Pipeline
- Kubernetes + packaging it using helm & kustomization file
- ArgoCD for GitOps
- Horizontal Pod Autoscaler

## Notes:
- The .env file is used to store the required environment variables for the application. Ensure that you provide the correct values for MYSQL_HOST, MYSQL_USER, MYSQL_PASS, and MYSQL_PORT.
- it shoud be in  instabug-intern-challenge/ dir.

## Run Api Locally Using Golang and mysql-server:
    git clone https://github.com/Elheity/instaBug.git
    cd instabug
    go build -o main .
    ./main
## Fix bug in the code 
 
![Screenshot from 2023-06-10 23-20-48](https://github.com/Elheity/instaBug/blob/main/assets/WhatsApp%20Image%202023-06-15%20at%2015.02.20%20(2).jpeg)

![Screenshot from 2023-06-10 23-20-48](https://github.com/Elheity/instaBug/blob/main/assets/WhatsApp%20Image%202023-06-15%20at%2015.02.20.jpeg)


## Build Docker Image:
    sudo docker build -t internship .
- Dockerfile Built in the way that make it as lightweight as possible with all layers of security.

## Run API And It's Database Using Docker-Compose:
    docker-compose up 
- In Docker-compose The Api Will Start Only After Mysql DB Be Healthy, So i add Healthcheck for my compose file 

## Screenshot From Running API Localy With Docker-compose:
![Screenshot from 2023-06-15 12-35-51](https://github.com/Elheity/instaBug/blob/main/assets/WhatsApp%20Image%202023-06-15%20at%2015.02.19.jpeg)

![Screenshot from 2023-06-15 13-29-54](https://github.com/Elheity/instaBug/blob/main/assets/WhatsApp%20Image%202023-06-15%20at%2015.02.20%20(1).jpeg)

## Minikube Cluster Setup:
    # Start the Minikube cluster using the Docker driver by running the command: 

     minikube start --driver docker

    # Verify the status of the Minikube cluster using the command:

     minikube status

    Ensure that the control plane components, including the host, kubelet, apiserver, and kubeconfig, are running and properly configured.
## Install API Using Kubectl:
    kubectl apply -f kubernetes//app-deployment.yaml 
    kubectl apply -f kubernetes//app-service.yaml 
    kubectl apply -f kubernetes//db-deployment.yaml 
    kubectl apply -f kubernetes//db-service.yaml 
    kubectl apply -f kubernetes//app-config.yaml 

![Screenshot from 2023-06-13 15-43-45](https://github.com/Elheity/instaBug/blob/main/assets/IMG_20230615_144045.jpg)



## Install API Using Helm:
    helm install mywebapp-release helminsta/ --namespace default --set fullnameOverride=mywebapp-release --set releaseNamespace=default
![Screenshot from 2023-06-10 23-20-48](https://github.com/Elheity/instaBug/blob/main/assets/IMG_20230615_143852.jpg)

![Screenshot from 2023-06-10 23-20-48](https://github.com/Elheity/instaBug/blob/main/assets/IMG_20230615_143916.jpg)



## ArgoCD SETUP:
    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    
## Enable Sync Between Github & K8s ArgoCD Cluster By:
 Install API By Using Helm Charts Command OR By Run Application.yaml K8s File And It Will Sync Automatically.
and it also point to helm package.
#
    kubectl apply -f helminsta/templates/application.yaml 
#



