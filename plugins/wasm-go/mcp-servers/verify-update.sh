#!/bin/bash

echo "=== 验证更新状态 ==="

echo "1. 检查本地修改的 go.mod:"
echo "   本地 wasm-go 路径替换:"
grep "replace.*wasm-go" all-in-one/go.mod

echo ""
echo "2. 检查新编译的 WASM 文件:"
ls -lh all-in-one/main.wasm

echo ""
echo "3. 检查 Docker 镜像:"
docker images | grep "aias00/mcp-all-in-one" | head -3

echo ""
echo "4. 检查 Higress 插件配置:"
kubectl get wasmplugin mcp-server.internal -n higress-system -o jsonpath='{.spec.url}'

echo ""
echo ""
echo "5. 检查最新的镜像拉取日志:"
kubectl logs -n higress-system -l app=higress-gateway | grep "v2.0-local" | tail -3

echo ""
echo "=== 验证完成 ==="
