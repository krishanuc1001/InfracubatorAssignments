### Prerequisites for Rise of the Containers training

1) Install Kubernetes command line (k8s command line client tool)

```zsh
brew install kubectl
``` 

2) Install Minikube using brew (you need VirtualBox or Hyperkit installed)

(minikube version latest)
```zsh
brew install minikube
```

Start minikube cluster:
```zsh
minikube start --memory=6000m --cpus=4 --driver=docker --kubernetes-version=v1.28.3
```

- In the logs you can see if minikube is using hyperkit driver or virtual box driver.

- If it's the virtual box driver, you can open VirtualBox and see the minikube instance running, and for the first time it can take upto 10-15 min.

- If it’s hyperkit, move on to the next step. You can find out if everything is good at step 3.


3) Install required images inside minikube docker runtime

Connect host CLI to docker runtime inside minikube - need to do it every time on new terminal window
```zsh
eval $(minikube docker-env)
```

Download nginx image
```zsh
docker pull nginx
```

Download another java image
```zsh
docker pull openjdk:alpine
```

Download mongodb image
```zsh
docker pull mongo
```

4) Verify minikube and kubectl working fine using following command

You will see a linux prompt as # or $. This denotes that things are working
```zsh
kubectl run -i --tty busybox --image=busybox -- sh
```

Exit
```zsh
ctrl + d
```

5) To get the IP of minikube cluster

```zsh
minikube ip
```

6) To enter into minikube cluster

```zsh
minikube ssh
```

5) Stop Minikube cluster running on VirtualBox

```zsh
minikube stop
```