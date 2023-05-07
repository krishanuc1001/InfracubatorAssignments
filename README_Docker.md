# Infracubator Assignments (Docker)

## Assignment-1

1. Start an nginx container.
2. Port forward to local and check.
3. Check logs.
4. Go inside the container.
5. Stop the container.

![img](https://user-images.githubusercontent.com/40739038/236662769-dd7eddd1-2db0-47ce-ba5a-854d28a6338e.png)

![img_1](https://user-images.githubusercontent.com/40739038/236662991-b819b1cb-96eb-4baa-936b-6e24950851b4.png)

![img_2](https://user-images.githubusercontent.com/40739038/236662992-0708d11d-bfbd-46ea-b9c9-54d9d1092820.png)

![img_3](https://user-images.githubusercontent.com/40739038/236662994-a81ad07d-7056-4b03-be67-9f02d4dffb27.png)

![img_4](https://user-images.githubusercontent.com/40739038/236662996-1a6b6afc-dbc5-4268-a0b7-b7b87e8fb560.png)

![img_5](https://user-images.githubusercontent.com/40739038/236662999-496e281f-0766-470d-ac67-a5af745e08fa.png)


## Assignment-2

Given that you have instructions to run the go-app (in pre-requisites)
1. Try to create a docker image out of it with the base image of golang:alpine
2. Run a container with that image and do a curl a request and make sure you are able to see the output.
3. Tag the docker image with v1.
4. Run docker history, observe and understand the output.
5. Push the docker image to your dockerhub.

![img_6](https://user-images.githubusercontent.com/40739038/236663194-2d44d809-9149-4b56-b894-09d07da3bcda.png)

![img_7](https://user-images.githubusercontent.com/40739038/236663196-067bdf4a-1a40-4b4c-8c8d-cf231e2a93da.png)

![img_8](https://user-images.githubusercontent.com/40739038/236663198-cedde402-2256-456a-bfd7-ddb3e0ec0d82.png)

![img_9](https://user-images.githubusercontent.com/40739038/236663199-e5d89693-32af-42ed-b0fb-8b337ce577ac.png)

![img_10](https://user-images.githubusercontent.com/40739038/236663200-438ccfcc-7d7e-42db-abc5-5dfd61cff1de.png)

![img_11](https://user-images.githubusercontent.com/40739038/236663201-8dcd218f-fd00-4837-81b4-4865acae28c3.png)

![img_12](https://user-images.githubusercontent.com/40739038/236663203-d6e39326-7c15-4dfc-b61a-50a1977b794e.png)

![img_13](https://user-images.githubusercontent.com/40739038/236663205-5341e064-a113-4683-9ab3-836a3a2be693.png)

![img_14](https://user-images.githubusercontent.com/40739038/236663208-d7f64f6f-1c61-4477-9122-c557cd5c945f.png)

![img_15](https://user-images.githubusercontent.com/40739038/236663209-240a80ce-6284-414a-9e07-ea65e64e250c.png)


## Assignment-3
1. Create multistage build and run Dockerfile for go -app
- Stage 1 : Build
- Stage 2 : Run

![img_33.png](img_33.png)

![img_34.png](img_34.png)

![img_35.png](img_35.png)

## Assignment-4
1. Create  a volume  call it as my-volume
2. Create a container and attach it to my-volume
3. Change something in the volume folder and add a file with some content.
4. Create a second container mounted with same volume . Check if the file exists or not.

![img_19.png](img_19.png)

![img_20.png](img_20.png)

![img_21.png](img_21.png)

![img_22.png](img_22.png)

![img_23.png](img_23.png)

![img_24.png](img_24.png)

![img_25.png](img_25.png)

![img_26.png](img_26.png)

![img_27.png](img_27.png)

![img_28.png](img_28.png)

![img_29.png](img_29.png)

![img_30.png](img_30.png)

![img_31.png](img_31.png)

![img_32.png](img_32.png)



## Assignment-5
1. Create docker-compose file for go-app
2. docker-compose up
3. Use / endpoint to check the service running
4. Use /vote endpoint to add vote
5. docker-compose down

![img_16.png](img_16.png)

![img_17.png](img_17.png)

This is a Docker Compose YAML file that defines a service called `app`.

`version: '3'` specifies the version of the Docker Compose file syntax.

Under `services`, the `app` service is defined with the following properties:

- `container_name: my_go_app`: sets the name of the container to `my_go_app`. This is optional, but can be useful for easier container management.
- `build`: specifies how to build the Docker image for the service. It has two properties:
    - `context: .`: sets the build context to the current directory (`.`). This is the directory from which the build context is sent to the Docker daemon.
    - `dockerfile: Dockerfile3`: specifies the Dockerfile name to use for building the image. This file should be present in the build context.
- `ports`: maps the container's port `8080` to the host's port `8080`. This allows the service to be accessible from outside the Docker container.
- `volumes`: mounts the current directory `.` as a volume in the container at the path `/go/src/my_app`. This allows changes made to the source code on the host machine to be reflected in the container.
- `environment`: sets an environment variable `PORT` to `8080`. This environment variable can be used in the application code to set the port on which the application listens.

Overall, this Docker Compose file is defining a service that builds a Docker image from a specified Dockerfile, runs the image in a container with a specified container name, exposes the container's port `8080` to the host's port `8080`, mounts the current directory as a volume in the container, and sets an environment variable `PORT` to `8080`.


![img_18.png](img_18.png)

![img_36.png](img_36.png)

![img_37.png](img_37.png)

![img_38.png](img_38.png)

![img_39.png](img_39.png)

![img_40.png](img_40.png)
