### Setting Environment Variables:

- Use the env property in the pod definition file to set environment variables.
- `env` is an array, and each item in the array specifies:
- `name`: The name of the environment variable.
- `value`: The value of the environment variable.

Example:

```bash
docker run -e APP_COLOR=pink simple-webapp-color
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
      env:
        - name: APP_COLOR
          value: pink
````


### Alternative Methods:

- You can also set environment variables using `ConfigMaps` or `Secrets` instead of directly specifying a value.

In this case, use `valueFrom` to refer to a `ConfigMap` or `Secret`.

Example:

```yaml
env:
- name: ENV_VAR_NAME
  valueFrom:
    configMapKeyRef:
        name: configmap-name
        key: config-key
```

`OR`

```yaml
env:
- name: ENV_VAR_NAME
  valueFrom:
    secretKeyRef:
        name: secret-name
        key: secret-key
```

### ConfigMaps and Secrets:

- `ConfigMaps` and `Secrets` provide more secure or centralized ways to manage environment variables.