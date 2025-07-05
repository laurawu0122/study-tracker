# 使用官方Node.js运行时作为基础镜像
FROM node:18-alpine

# 设置工作目录
WORKDIR /app

# 复制package.json和package-lock.json
COPY package*.json ./

# 安装依赖
RUN npm ci --only=production && npm cache clean --force

# 复制应用代码
COPY . .

# 创建必要的目录
RUN mkdir -p uploads/avatars logs

# 设置脚本执行权限
RUN chmod +x scripts/start-app.sh

# 构建CSS文件
RUN npm run build:css || echo "CSS构建失败，使用默认样式"

# 暴露端口
EXPOSE 3001

# 启动应用
CMD ["./scripts/start-app.sh"] 