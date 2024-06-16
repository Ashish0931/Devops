#!/bin/bash
#this is a scrip to deploy the python code present in the devops folder."

#---------------------------------------------------------------------------

#checking requirements
check_requirements() {

        echo "***********checking for requirements**************"
        docker --version
        kubectl version --client
        minikube status
        echo "----------requirements are available------------"
}

# changing path to working folder
change_path() {

        echo "*********** changing to working directory **************"

        cd /Python-project/backup-docker-project/examples/python-web-app

        echo "---------- path changed! ------------"
}

 #building docker image
 build_image() {

         echo "***********building docker image **************"

        docker build -t pythonapp:V1 .
        echo "---------- build successful ------------"

}

 #starting minikube
 start_minikube() {

         echo "***********starting minikube **************"

        minikube start --force

        echo "----------Minikube started ------------"
}

 #deploying K8 cluster
 deploy_k8() {

         echo "***********deploying K8 deployment Yaml **************"

        kubectl apply -f deployment.yml
        kubectl get deploy
        kubectl get pods

        echo "----------K8 deployment success full ------------"
}

 #deploying K8 service
 service_k8() {

        echo "*********** Deploying k8 service **************"
        kubectl apply -f services.yml

        kubectl get svc

        echo "----------k8 service deployment success full ------------"

}

if ! check_requirements; then
        echo " -----------------requirements failed!------------------- "
        exit 1
fi
if ! change_path; then
        echo "-------------path change failed-------------------"
        exit 1
fi
if ! build_image; then
        echo "-------------building image failed----------------"
        exit 1
fi
if ! start_minikube; then
        echo "-------------minikube failed to start ----------------"
        exit 1
fi
if ! deploy_k8; then
        echo "-------------K8 deployment  failed----------------"
        exit 1
fi
if ! service_k8; then
        echo "-------------k8 service deployment failed----------------"
        exit 1
fi
