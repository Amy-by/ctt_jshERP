# 构建阶段：用 Node 环境打包前端
FROM node:20.17.0-alpine as build-stage
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn config set registry https://registry.npmmirror.com && yarn install
COPY . .
RUN yarn build

# 运行阶段：用 Nginx 部署静态文件
FROM nginx:1.12.2
# 复制打包结果到 Nginx 静态目录
COPY --from=build-stage /app/dist /usr/share/nginx/html
# 复制自定义 Nginx 配置（需提前创建，见步骤 3）
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
