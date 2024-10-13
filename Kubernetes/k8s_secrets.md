### Purpose of Secrets:

- Secrets are used to store sensitive information like `passwords`, `tokens`, and `keys` securely in Kubernetes.
- Unlike `ConfigMaps`, `Secrets` are encoded (base64) to protect sensitive data.
- They are essential for storing confidential data that should not be stored in plain text, like passwords or API keys.

### Creating Secrets:

Two ways to create Secrets:

1. `Imperative Method` (without a Secret definition file):

Use kubectl create secret generic to create Secrets directly from the command line.

Example:

```bash
kubectl create secret generic app-secret --from-literal=DB_Host=mysql
```
You can add more key-value pairs by specifying `--from-literal` multiple times. This gets complicated when there are too many secrets to pass in.

- Another way to input secret data is through a file. Use the `--from-file` option to specify a path to the file that contains the required data.

The data from this file is read and stored under the name of the file.

```bash
kubectl create secret generic app-config --from-file=secret.properties
```

`secret.properties` file:

```secret.properties
DB_HOST=mysql
DB_USER=root
DB_PASSWORD=passw0rd
```

2. `Declarative Method` (using a Secret definition file):

Create a YAML file similar to a ConfigMap, with the following structure:

`secret.yaml`

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
data:
  DB_HOST: mysql
  DB_USER: root
  DB_PASSWORD: passw0rd
```

Use `kubectl create -f <file_name>` to create the Secret from the file.

Important: All sensitive data must be encoded in `base64 format` for storage in the Secret. Above we have used plain text for demonstration purposes. 

In a real-world scenario, you should encode the data in base64 format.

### Encoding and Decoding Data:

To encode data to base64, run:

```bash
echo -n 'mysql' | base64
```

```bash
echo -n 'root' | base64
```

```bash
echo -n 'passw0rd' | base64
```

The data is encoded in base64 format. Copy the encoded values and replace the plain text values in the Secret definition file.

```yaml
data:
    DB_HOST: bXlzcWw=
    DB_USER: cm9vdA==
    DB_PASSWORD: cGFzc3cwcmQ=
```

To decode base64 data, run:

```bash
echo -n 'bXlzcWw=' | base64 --decode
```

### Viewing Secrets:

- Use `kubectl get secrets` to list Secrets.

- Use `kubectl describe secrets` to view more details of the newly created Secrets. This shows the attributes of the Secret, but hides the actual values.

To view the encoded values as well, use:

```bash
kubectl get secret <secret_name> -o yaml
```

### Configuring or Injecting Secrets into Pods:

Secrets can be injected into pods in two main ways:

- As environment variables:

In the pod definition, use the envFrom property:

`pod-definition.yaml`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
  labels:
    name: simple-webapp-color
spec:
    containers:
    - name: simple-webapp-color
      image: kodekloud/webapp-color
      envFrom:
        - secretRef:
            name: app-secret
```

`secret.yaml`

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
data:
    DB_HOST: bXlzcWw=
    DB_USER: cm9vdA==
    DB_PASSWORD: cGFzc3cwcmQ=
```

- As Single environment variables:

In the pod definition, use the env property:

`pod-definition.yaml`

```yaml
env:
  - name: DB_PASSWORD
    valueFrom:
      secretKeyRef:
        name: app-secret
        key: DB_PASSWORD
```

- As files in volumes:

Secrets can also be mounted as files, where each Secret key corresponds to a file, and the Secret value is the file content.

If you were to mount the Secret as a Volume in the Pod, each attribute in the Secret is created as a file with the value of the secret as its content.

`pod-definition.yaml`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
  labels:
    name: simple-webapp-color
spec:
    containers:
    - name: simple-webapp-color
      image: kodekloud/webapp-color
      volumeMounts:
        - name: app-secret-volume
          mountPath: /opt/secrets
          readOnly: true
    volumes:
      - name: app-secret-volume
        secret:
          secretName: app-secret
```


### Security Considerations:

- Secrets are `only encoded`, `not encrypted`, so anyone with access can decode them.
- Do not check-in Secret definition files into version control systems like GitHub, as they can be easily decoded by others.
- ETCD stores Secrets in an unencrypted format by default. You should consider `enabling encryption at REST` in ETCD using an `EncryptionConfiguration` file and passing it to the kube-apiserver.
- `Role-based access control (RBAC)` should be configured to restrict access to Secrets, as anyone who can create pods in the same namespace can potentially access those Secrets.
- Consider using third-party Secret management solutions like `AWS Secrets Manager`, `Azure Key Vault`, `GCP Secret Manager`, or `HashiCorp Vault` for better security, as these solutions store Secrets externally and manage their security.

### Important points about Kubernetes Secrets

Remember that secrets encode data in base64 format. Anyone with the base64 encoded secret can easily decode it. As such the secrets can be considered as not very safe.

The concept of safety of the Secrets is a bit confusing in Kubernetes. The [kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/secret) page and a lot of blogs out there refer to secrets as a "safer option" to store sensitive data. They are safer than storing in plain text as they reduce the risk of accidentally exposing passwords and other sensitive data. In my opinion it's not the secret itself that is safe, it is the practices around it.

Secrets are not encrypted, so it is not safer in that sense. However, some best practices around using secrets make it safer. As in best practices like:

- Not checking-in secret object definition files to source code repositories.

- [Enabling Encryption at Rest](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/) for Secrets so they are stored encrypted in ETCD.


Also, the way kubernetes handles secrets. Such as:

- A secret is only sent to a node if a pod on that node requires it.

- Kubelet stores the secret into a tmpfs so that the secret is not written to disk storage.

- Once the Pod that depends on the secret is deleted, kubelet will delete its local copy of the secret data as well.

Read about the [protections](https://kubernetes.io/docs/concepts/configuration/secret/#protections) and [risks](https://kubernetes.io/docs/concepts/configuration/secret/#risks) of using secrets [here](https://kubernetes.io/docs/concepts/configuration/secret/#risks).

Having said that, there are other better ways of handling sensitive data like passwords in Kubernetes, such as using tools like Helm Secrets, [HashiCorp Vault](https://www.vaultproject.io/).

