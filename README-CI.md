## An Overview of the Project
I'm making a container in Docker for a simple webpage.

## How to Run the Project
- First, I downloaded [Docker Desktop](https://www.docker.com/products/docker-desktop/). The installer should take care of any dependencies.
- Then, after a few computer restarts, I make sure Docker Desktop is open
 - No really, make sure Docker Desktop is open
- From there, I open up Command Prompt and set my working directory to `website`.
- Then, I run `docker build . -t imagename` to create the image, where:
 - `.` specifies the location to pull files from, including the `Dockerfile`. In this case, I'm using the current working directory.
 - `-t imagename` gives the resulting image the name `imagename`. (or whatever you decide to call it)
- After the image has been created, it can be run in Docker Desktop by clicking its `Run` button in the `Images` tab.
 - Or, if you want to be a NERD, run `docker run imagename -p 4096:80 --name containername --rm`, where:
  - `imagename` is the name of the image you want to run.
  - `-p 4096:80` forwards port 80 in the container to port 4096 on your host device.
  - `--name containername` goves the resulting container the name `containername`. (or whatever you decide to call it)
  - `--rm` removes the container's file system when the container exits.
   - As in, deletes everything inside the container. You aren't getting your logs back with this one
   - This doesn't delete the image or source files, however.
- Once the container is running, you can go to `hostdevicepublicip:port` to access your webpage.
 - `hostdevicepublicip` refers to the public IP address of your host device. (For example, `87.65.43.210`.)
 - If you're trying to access the webpage from the host device, you can use `localhost:port` instead.
 - The port you use to access the webpage is the same one that the container uses for the host device. (In this example, it's port 4096, so I would use `hostdevicepublicip:4096`.)