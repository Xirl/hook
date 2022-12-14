#!/bin/bash
WORK_PATH='/usr/projects/front'
cd $WORK_PATH
echo "清理代码"
git reset --hard origin/main
git clean -f
echo "拉取最新代码"
git pull origin main
echo "打包最新代码"
npm run build
echo "开始构建镜像"
docker build -t front .
echo "删除旧容器"
docker stop front-container
docker rm front-container
echo "启动新容器"
docker container run -p 80:80 -d --name front-container front
