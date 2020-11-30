# !/bin/bash

docker run 
       -it \  
       --name ojserver \
       -p 8000:8000 \
       -v /home/__woorin/github/CTFd/SharePoint:/SharePoint:rw \
       woorin/ctfd:v0.2 \
       /bin/bash
