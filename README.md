# Docker_for_yocto
A shell script that creates a Docker container that can be used to build yocto projects.

# Use
1. make sure that there is a directory ‘yocto’ in the home directory.
2. make sure that the directory belongs to the owner 1001. (Docker user) 
```sudo chown -R 1001:1001 /home/user/yocto```
3. start the start_dev_environment.sh script as superuser. If no container exists yet, a new container is created.
4. after completion, the container is executed in interactive mode. 

