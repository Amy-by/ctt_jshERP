# 编译运行ERP项目计划

## 1. 检查环境依赖
- 检查JDK 1.8是否安装
- 检查Maven 3.3.9+是否安装
- 检查Node.js 20.17.0+是否安装
- 检查MySQL 8.0.24+是否安装并运行
- 检查Redis 6.2.1+是否安装并运行

## 2. 准备数据库
- 创建数据库：`jsh_erp`
- 导入初始数据（如果有）

## 3. 编译后端项目
- 进入后端目录：`/home/aaaaaa/workplace/ctt_jshERP/jshERP-boot`
- 执行Maven编译命令：`mvn clean install -DskipTests`

## 4. 编译前端项目
- 进入前端目录：`/home/aaaaaa/workplace/ctt_jshERP/jshERP-web`
- 安装依赖：`npm install`
- 构建前端项目：`npm run build`

## 5. 启动后端服务
- 运行后端jar包：`java -jar target/jshERP.jar`

## 6. 启动前端服务
- 进入前端目录
- 启动开发服务器：`npm run dev`

## 7. 验证项目运行
- 访问前端页面：`http://localhost:8080`
- 访问后端API：`https://localhost:8443/jshERP-boot`
- 使用默认账号密码登录：admin/123456