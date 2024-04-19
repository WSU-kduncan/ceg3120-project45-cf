#! /bin/bash

# stop and remove the old container process.
docker stop flaskapp
docker remove flaskapp
# pull the latest image
docker pull radzo73/test-repo:latest
# run new container by name, with restart automagic
docker run -d -p 80:5000 --name flaskapp --restart always radzo73/test-repo:latest
