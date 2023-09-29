#!/bin/bash
export Version=$(($version +1))

docker build -t selvasuba/lbg-python-api:v${version} .
docker build -t selvasuba/lbg-python-api .


docker stop sample-app \
&& (docker rm sample-app) \
|| (docker rm sample-app && sleep 1 || sleep 1)

docker run -d -p 80:${PORT} -e PORT=${PORT} --name sample-app selvasuba/lbg-python-api