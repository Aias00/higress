#!/bin/bash

# Docker Hub 推送脚本
# 请将 YOUR_USERNAME 替换为您的实际 Docker Hub 用户名

DOCKER_USERNAME="aias00"  # Docker Hub 用户名
IMAGE_NAME="mcp-all-in-one"
TAG="latest"

echo "=== Docker Hub 推送脚本 ==="

# 1. 重新标记镜像
echo "1. 重新标记镜像..."
docker tag higress-registry.cn-hangzhou.cr.aliyuncs.com/mcp-server/all-in-one:20250911-144326-db08e77 \
  ${DOCKER_USERNAME}/${IMAGE_NAME}:${TAG}

# 2. 登录 Docker Hub (需要手动输入用户名密码)
echo "2. 登录 Docker Hub..."
docker login

# 3. 推送镜像
echo "3. 推送镜像..."
docker push ${DOCKER_USERNAME}/${IMAGE_NAME}:${TAG}

echo "=== 推送完成 ==="
echo "镜像地址: ${DOCKER_USERNAME}/${IMAGE_NAME}:${TAG}"
echo "请更新 wasmplugin-dockerhub.yaml 中的 url 为:"
echo "url: oci://${DOCKER_USERNAME}/${IMAGE_NAME}:${TAG}"
