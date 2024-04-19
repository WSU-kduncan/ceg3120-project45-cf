## An Overview of the Project
I'm using GitHub Actions to automate building and pushing images from my GitHub repo to my DockerHub repo.

## Making tags in Git(Hub)
To create and push a tag using Git, use the following commands:
`git tag [name]`
`git push origin [name]`

Creating the tag went fine for me, but I couldn't push for some reason (some `403` error). Thankfully, GitHub Desktop exists. All I need to do there is:
- Add a commit.
- Go to History, select your commit, right-click, Tag the commit.
- Push to origin.

## The Action of GitHub
What my Action checks for is:
- Was there a `push` on branch `master`, AND
- Does it have a tag that begins with `v`?
OR
- Was there a `pull` request on branch `master`.
What my Action does, in order, is:
- Checkout the repo.
- Tag the images with `latest`, `v*.*`, and `v*.*.*`.
- Login to DockerHub with my secret username and token.
- Build the images and push them to DockerHub.

## Give me the pudding
[The proof is in the pudding, after all.](https://hub.docker.com/repository/docker/radzo73/test-repo/)

## Installing Docker (On an instance (Ubuntu))
To be honest I just followed the instructions from [the official Docker docs](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository) and everything worked fine.

## ~~Killing~~ Updating our darlings
Sometimes you want or even need to update a container. However, I don't feel like `ssh`ing into my instance every time I do this. Besides, what if I have a lot of containers that need restarting or updating?

This shell script will kill and remove the current container proccess, pull the latest image from my repo, and run a new container that will auto-restart if something happens. This script will be contained in `/var/scripts/`, since that's what the template on the Webhook readme uses.

## Hooked to the Web
You can install Webhook onto Ubuntu by simply running `sudo apt-get install webhook` (which is the other reason I used Ubuntu on this instance).

I created `hooks.json` and `redeploy.sh`, and put them inside `/var/scripts`. `hooks.json` has two hooks: One for manual restarting via `instance:9000/hooks.redeploy-webhook`, and a hook that activates whenever I push a tag. Both hooks run `redeploy.sh`, which stops the current container, removes it, pulls the latest image from my repo, and starts a new container using that image.

I start the webhook automatically using a systemd service in `/etc/systemd/system/webhook.service` with the following code:
```sh
[Unit]
Description=Docker stoppullrestart

[Service]
ExecStart=webhook -hooks /var/scripts/hooks.json -verbose
ExecStart=docker run -d -p 80:5000 --name flaskapp --restart always radzo73/test-repo:latest
Type=oneshot
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

To reload this service, use `sudo systemctl restart webhook`.

