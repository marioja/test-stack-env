# Purpose of this repository

This branch is to the problem with support of .env file in portainer

If I deploy a portainer stack from a git repository that contains a .env file, the environment variables will not be available in the environment when building the stack

If I checkout the branch and then type:

`docker compose up`

Then the output will contain