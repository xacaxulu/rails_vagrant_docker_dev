# Download and install Vagrant & VirtualBox on your laptop.
## The main idea here is that you edit your code locally on your host laptop but you execute specs/database migrations inside of Vagrant against the Docker container. This is so that all the heavy lifting is done on the exact same Docker image that you'll containerize in production.

## The other benefit is that everyone can have the exact same development environment via Vagrant while still using their own Text Editors / IDEs and Browsers.

# Edit Code Locally => Test/Execute in Vagrant against Docker

###

# Spin up Vagrant Ubuntu box running Docker

from the root of this directory run `vagrant up`

# Apply Chef settings located in Vagrantfile
``` shell
vagrant provision
```
# login to Ubuntu box
``` shell
vagrant ssh
cd /vagrant
```
(code has been shared via directives in Vagrantfile NFS)


# Build new docker image from Dockerfile
``` shell
sudo docker build -t demo .
```

# Start docker container 
``` shell
sudo docker run -dP -p 3000:3000 demo
```

# Get docker container name 
``` shell
sudo docker ps
```
Look for the running container. It will have a silly name like fabulous_turing

# Run RSpec inside of the container.
``` shell
sudo docker exec <container_name> bin/rake spec
```
# Run migrations for development
``` shell
sudo docker run -it <container_name> bin/rake db:migrate RAILS_ENV=development
```
# From your Host computer, you should be able to access the Rails app @ http://localhost:1234/