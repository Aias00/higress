#!/bin/bash

echo "=== Higress 插件日志查看工具 ==="

# 基础函数
function show_help() {
    echo "用法: $0 [选项] [插件名称]"
    echo ""
    echo "选项:"
    echo "  all                    - 查看所有插件日志"
    echo "  mcp-servers-dockerhub  - 查看您的 Docker Hub MCP 插件日志"
    echo "  mcp-server.internal    - 查看内部 MCP 插件日志"
    echo "  key-auth               - 查看认证插件日志"
    echo "  errors                 - 查看所有错误日志"
    echo "  live                   - 实时查看日志"
    echo ""
}

# 获取日志的基础命令
BASE_CMD="kubectl logs -n higress-system -l app=higress-gateway"

case "$1" in
    "all")
        echo "查看所有插件日志 (最近50行):"
        $BASE_CMD --tail=50
        ;;
    "mcp-servers-dockerhub")
        echo "查看 mcp-servers-dockerhub 插件日志:"
        $BASE_CMD | grep "mcp-servers-dockerhub" | tail -20
        ;;
    "mcp-server.internal")
        echo "查看 mcp-server.internal 插件日志:"
        $BASE_CMD | grep "mcp-server.internal" | tail -20
        ;;
    "key-auth")
        echo "查看 key-auth 插件日志:"
        $BASE_CMD | grep "key-auth" | tail -20
        ;;
    "errors")
        echo "查看错误日志:"
        $BASE_CMD | grep -i error | tail -20
        ;;
    "live")
        echo "实时查看日志 (按 Ctrl+C 退出):"
        $BASE_CMD -f
        ;;
    "wasm")
        echo "查看 WASM 相关日志:"
        $BASE_CMD | grep -i wasm | tail -20
        ;;
    *)
        show_help
        ;;
esac
