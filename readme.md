# Purpose of this repository

This branch is to the problem with support of .env file in portainer

If I deploy a portainer stack from a git repository that contains a .env file, the environment variables will not be available in the environment when building the stack

If I checkout the branch and then type:

`docker compose up`

Then the output will confirm the creation of the env_env1 environment variable in the service myserv1 as well as the substitution in the compose from from the presence of the variable in the docker compose environment (output prefix in my example by compose:):

```
env_env1=pickaboo
HOSTNAME=714a78e32b10
SHLVL=1
HOME=/root
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PWD=/
compose: env_env1=pickaboo
```