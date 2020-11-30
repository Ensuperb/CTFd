# !/bin/bash

docker run \
       -it \
       --name ojserver \
       -p 8000:8000 \
       -p 2222:22 \
       -v ${pwd}/Sharepoint:/opt/CTFd:rw \
       woorin/ctfd:v0.5 \
       /bin/bash
