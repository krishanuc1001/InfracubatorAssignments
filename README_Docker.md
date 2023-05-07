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

![img_33](https://user-images.githubusercontent.com/40739038/236663367-1f8ea858-bc21-447a-bf13-4bfbd4497b07.png)

![img_34](https://user-images.githubusercontent.com/40739038/236663371-9609e8f4-38da-44c8-a4ae-0a54ed27298e.png)

![img_35](https://user-images.githubusercontent.com/40739038/236663377-ac9bef25-06b7-43df-b1e1-6a92ef7e53b4.png)


## Assignment-4
1. Create  a volume  call it as my-volume
2. Create a container and attach it to my-volume
3. Change something in the volume folder and add a file with some content.
4. Create a second container mounted with same volume . Check if the file exists or not.

![img_19](https://user-images.githubusercontent.com/40739038/236663475-a34d3134-1027-485d-94e2-98e3a6157e22.png)

![img_20](https://user-images.githubusercontent.com/40739038/236663479-2275de5a-ea14-4d7c-82d2-be8ad16754b1.png)

![img_21](https://user-images.githubusercontent.com/40739038/236663481-f310bd9a-f791-4fe2-918d-9545c5e83f86.png)

![img_22](https://user-images.githubusercontent.com/40739038/236663483-236d8ccf-ce66-4042-97e5-9eceda3628f6.png)

![img_23](https://user-images.githubusercontent.com/40739038/236663484-757d245e-bf94-448a-af27-bcbc13ee31c1.png)

![img_24](https://user-images.githubusercontent.com/40739038/236663486-2e76aeb0-ec3e-4f58-88b3-bdd7ffc4f790.png)

![img_25](https://user-images.githubusercontent.com/40739038/236663487-c7694616-369d-4c1d-8c2e-e579b292c600.png)

![img_26](https://user-images.githubusercontent.com/40739038/236663489-aa60d850-2f69-4ae1-ac80-2631b915b9b3.png)

![img_27](https://user-images.githubusercontent.com/40739038/236663490-05f5e2a9-2518-46c8-bb15-b45a0d0d4e8a.png)

![img_28](https://user-images.githubusercontent.com/40739038/236663492-904861ad-baad-4228-8c24-f1c87ca5f85d.png)

![img_29](https://user-images.githubusercontent.com/40739038/236663495-253de793-6691-49e7-84e7-97be2dc430cc.png)

![img_30](https://user-images.githubusercontent.com/40739038/236663497-11736cac-307d-4fcf-abfa-1b1a3d06ec67.png)

![img_31](https://user-images.githubusercontent.com/40739038/236663498-aaf826e6-d3ef-46ed-828a-7d48fa011726.png)

![img_32](https://user-images.githubusercontent.com/40739038/236663501-c83b0764-f79a-4353-a214-d9b7b7735b84.png)


## Assignment-5
1. Create docker-compose file for go-app
2. docker-compose up
3. Use / endpoint to check the service running
4. Use /vote endpoint to add vote
5. docker-compose down

![img_16](https://user-images.githubusercontent.com/40739038/236663741-4f0312a2-021d-4cb9-baa9-6162e97fd5fc.png)

![img_17](https://user-images.githubusercontent.com/40739038/236663742-83847fb1-013f-498d-83b6-9a113e483064.png)

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

![img_18](https://user-images.githubusercontent.com/40739038/236663743-e515aa39-e5b9-409f-a1c1-d804d2e19a01.png)

![img_36](https://user-images.githubusercontent.com/40739038/236663745-9dffbacc-8ca7-434b-99cc-0646f1aca612.png)

![img_37](https://user-images.githubusercontent.com/40739038/236663746-ef7aa672-1109-4b1a-bed3-936c45a62ab5.png)

![img_38](https://user-images.githubusercontent.com/40739038/236663747-0690eb5e-57d1-441d-bbee-18e439617349.png)

![img_39](https://user-images.githubusercontent.com/40739038/236663748-25ab1682-d7ad-445f-87d9-531778cbfd14.png)

![img_40](https://user-images.githubusercontent.com/40739038/236663749-ad42f36c-54ae-40b9-92e7-325d2fc64767.png)
