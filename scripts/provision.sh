#!/usr/bin/env bash

[ -d /vagrant ] && cd /vagrant

which docker &>/dev/null || {
  export VERSION=18.06 && curl -sSL get.docker.com | sh
  usermod -a -G docker vagrant
}

which minikube &>/dev/null || {
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
sudo cp minikube /usr/local/bin/
rm minikube
}

which kubectl &>/dev/null || {
  curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
  chmod +x kubectl
  sudo cp kubectl /usr/local/bin/
  rm kubectl
}

export MINIKUBE_WANTUPDATENOTIFICATION=false
export MINIKUBE_WANTREPORTERRORPROMPT=false
export MINIKUBE_HOME=$HOME
export CHANGE_MINIKUBE_NONE_USER=true
mkdir -p $HOME/.kube
mkdir -p $HOME/.minikube
touch $HOME/.kube/config

export KUBECONFIG=$HOME/.kube/config
minikube start --vm-driver=none --apiserver-ips 127.0.0.1 --apiserver-name localhost

# this for loop waits until kubectl can access the api server that Minikube has created
for i in {1..150}; do # timeout for 5 minutes
  kubectl get po &> /dev/null
  if [ $? -ne 1 ]; then
    break
  fi
  sleep 2
done

# enable addons
minikube addons enable ingress

# configure proxy
cp conf/kubectlproxy.service /lib/systemd/system
systemctl daemon-reload
systemctl enable kubectlproxy.service
systemctl start kubectlproxy.service

echo "minikube up and running"
