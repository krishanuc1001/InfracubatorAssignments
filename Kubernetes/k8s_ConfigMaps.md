### Purpose of ConfigMaps:

- `ConfigMaps` in Kubernetes are used to manage configuration data in the form of key-value pairs.

- They help centralize configuration, avoiding hardcoding environment variables directly in pod definition files.

- `ConfigMaps` allow you to pass configuration data as environment variables or files into pods.


```configMap
APP_COLOR=blue
APP_MODE=prod
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
spec:
    containers:
    - name: simple-webapp-color
      image: simple-webapp-color
      ports:
        - containerPort: 8080
      envFrom:
        - configMapRef:
            name: app-config
```


### Phases of ConfigMap Configuration:

- `Phase 1`: Create the ConfigMap.

- `Phase 2`: Inject the ConfigMap into the pod.

### Creating a ConfigMap:

Two methods to create `ConfigMaps`:

1. Imperative Method (without a ConfigMap file):

- Use `kubectl create configmap` to create a `ConfigMap` directly from the command line.

Example:

```bash
kubectl create configmap app-config --from-literal=app_color=blue
```

For multiple key-value pairs, repeat the `--from-literal` option. This gets complicated when there are too many configuration items.

- Another way to input configuration data is through a file. Use the `--from-file` option to specify a path to the file that contains the required data.

The data from this file is read and stored under the name of the file.

```bash
kubectl create configmap app-config --from-file=app.properties
```

2. Declarative Method (using a ConfigMap definition file):

- Create a YAML file with the following structure:

`configMap.yaml`

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  APP_COLOR: blue
  APP_MODE: prod
```

Use below command to create the `ConfigMap` from the file. 

```bash
kubectl create -f configMap.yaml
```

### Viewing ConfigMaps:

- Use `kubectl get configmaps` to list `ConfigMaps`.
- Use `kubectl describe configmaps` to view the details and key-value pairs within the ConfigMap.

### Injecting ConfigMaps into Pods:

- To inject a ConfigMap as an environment variable in a pod, use the `envFrom` property in the pod definition.

Example:

```yaml
envFrom:
- configMapRef:
    name: app-config
```
This injects all key-value pairs from the specified ConfigMap into the pod's container.

### Other Methods of Using ConfigMaps:

- `ConfigMaps` can also be injected into a pod as a `single environment variable` or mounted as files using `volumes`.

- To inject a `single environment variable`, use the `env` property in the pod definition.

Example:

```yaml
env:
- name: APP_COLOR
  valueFrom:
    configMapKeyRef:
      name: app-config
      key: APP_COLOR
```

- To mount a `ConfigMap` as a file, use the `volumes` property in the pod definition.

Example:

```yaml
volumes:
- name: app-config-volume
  configMap:
    name: app-config
```