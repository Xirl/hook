#!/bin/bash
WORK_PATH='/usr/projects/back'
cd $WORK_PATH
echo "清理代码"
git reset --hard origin/main
git clean -f
echo "拉取最新代码"
git pull origin main
echo "开始构建镜像"
docker build -t back .
echo "删除旧容器"
docker stop back-container
docker rm back-container
echo "启动新容器"
docker container run -p 3000:3000 -d --name back-container back
