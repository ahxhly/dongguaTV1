# 基础镜像保持你指定的 node:20-alpine（最新LTS版本，更稳定）
FROM node:20-alpine

# 安全优化：使用非root用户运行（避免权限过大风险）
USER node

# 设置工作目录（与你docker-compose挂载路径一致）
WORKDIR /app

# 复制包管理文件，利用Docker缓存层（修改代码不重复安装依赖）
COPY --chown=node:node package*.json ./

# 安装生产依赖（--production 等价于 --only=production，保留你的写法）
RUN npm install --production

# 复制项目所有文件（设置权限为node用户，避免读写报错）
COPY --chown=node:node . .

# 赋予启动脚本执行权限（路径写法兼容你的配置）
RUN chmod +x /app/entrypoint.sh

# 暴露端口（与项目3000端口一致，方便外部识别）
EXPOSE 3000

# 启动入口（保留你原有的脚本路径）
ENTRYPOINT ["/app/entrypoint.sh"]
