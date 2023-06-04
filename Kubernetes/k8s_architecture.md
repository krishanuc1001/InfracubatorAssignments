### k8s Master node (k8s Control Plane) Components

<img width="945" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/d19083c8-5fd3-420c-bfd5-06831a0f7c24">

1. `POD`: Our ultimate aim with using Kubernetes is to deploy our application in the form of containers on a set of machines that are configured as worker nodes in a cluster.
However, kubernetes does not deploy containers directly on the worker nodes. The containers are encapsulated into a Kubernetes object known as PODs.
A POD is a single instance of an application. A POD is the smallest object, that you can create in kubernetes.

2. `Nodes`: A node is a machine – physical or virtual – on which kubernetes is installed. A node is a worker machine and this is were containers will be launched by kubernetes.


3. `Cluster`: A cluster is a set of nodes grouped together. This way even if one node fails you have your application still accessible from the other nodes. Moreover having multiple nodes helps in sharing load as well.

```
Cluster => Nodes => PODs => Containers 
```

4. `kube-APIServer`: This is the face/ front-end of the k8s Master/ Control Plane. Every communication happens via APIServer. The Users, Management devices, Command line interfaces all talk to the API server to interact with the kubernetes cluster.
Exposes the REST API interface to interact with k8s.


5. `Scheduler`: This is responsible for scheduling and distributing the new requests or workloads to the specific Worker nodes. 
It looks for newly created containers and assigns them to Nodes, continuously keeps watching for new POD requests. 
There are various options to choose from, e.g. `affinity`


6. `Control Manager or Controller`: The job of the Control Manager is to look at the request which is our desired state and look at the actual state, and act accordingly to make sure all the necessary things
that are required to do, are done. The controllers are the brain behind orchestration. They are responsible for noticing and responding when nodes, containers or endpoints goes down. 
The controllers make decisions to bring up new containers in such cases.


7. `etcd`: etcd is a distributed reliable key-value database used by k8s to store all data used to manage the cluster. It is the only stateful component in whole k8s architecture and it is the `Source Of Truth`.
Think of it this way, when you have multiple nodes and multiple masters in your cluster, etcd stores all that information on all the nodes in the cluster in a distributed manner.
etcd is responsible for implementing locks within the cluster to ensure there are no conflicts between the Masters.


### k8s Worker/ Slave node Components

<img width="943" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/403eec1c-a711-42e0-ac1a-0a0788a4d095">

1. `kubelet`: Its job is to get the request from Master and fulfill them. kubelet is the main agent that runs on each node in the cluster. 
The agent is responsible for making sure that the containers are running on the nodes as expected and keeps watching the `kube-APIServer` for work.


2. `Container Runtime`: The container runtime is the underlying software that is used to run containers. In our case it happens to be `Docker`.


3. `kube-proxy`: This manages networking within the worker nodes and provide the layer for communication between all the applications. It assigns IP to each POD with the help of CNI (Container Network Interface) provider.
It is also helps to primarily resolve the service abstractions and all the IP table rules are updated by it.



### Working of k8s components

<img width="1767" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/ca4d39de-9fb7-4ebb-80ea-2ea1a6564cfe">

- Let's say `Client` sends a request to the `kube-APIServer` that it wants an application to be deployed to the k8s cluster. The request is received by the `kube-APIServer` and it is stored in `etcd`.


- Now the `Controller` keeps looking at the requests that are present in `etcd`. It looks at - what is the current state and then decides what needs to be done to reach the desired state.


- Once, the decision has been made by `etcd` that a certain number of PODS has to be spawned up, the `scheduler` comes into the picture. The `scheduler` looks at the requests, such as 3 POD requests. 
Then it looks at what is the state of the worker nodes and based on the state it assigns the actual POD onto the worker nodes. 


- Now `kubelet` which is part of the Worker nodes, keeps listening to the requests via `kube-APIServer` of the Master node. If there is a new request which is assigned to the Worker node, `kubelet` is going to pick up that request.
Then it is going to use `Container Runtime (docker)` to spin up new PODS and eventually containers. 


- If there is a requirement of networking of the new PODS that are spin up, new IPs to be assigned and make sure everybody is aware of those IPs and routes to be defined - 
these are taken care of by `kube-proxy`. It keeps listening to any of the state changes and then works accordingly to set up the IP table rules so that the POD to POD communication
can happen easily. 


### How to connect and communicate with Kubernetes Cluster?

- We use `k8s command line tool (kubectl)`. It enables communication over RESTful API interface of the Master node's `kube-APIServer` with Cluster.

<img width="988" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/73cda81c-c01a-4979-a7ba-66f2bcfe01db">

```
kubectl [command] [type]    [name] [flags] 
         get      pods             -o wide
         patch    services
         delete   jobs
```

- `kubeconfig`: All the information related to which cluster to connect is stored in the `kubeconfig`
It has `contexts` that help `kubectl` to connect to `k8s Cluster`.

`Conxtexts` consists of:
- Cluster information
- User information
- Namespace


- Default location of `kubeconfig` file: `$HOME/.kube/config`.
To override the default location, use `KUBECONFIG` environment variable. 