# ERP系统本地运行指南

## 1. 项目概述

本ERP系统是一套功能完善的企业资源计划管理系统，采用前后端分离架构：
- **后端**：Spring Boot 2.0.9
- **前端**：Vue.js 2.7.16 + Ant Design Vue 1.5.2
- **数据库**：MySQL 5.7+ / 8.0+
- **缓存**：Redis 5.0+

## 2. 环境准备

### 2.1 安装依赖软件

#### 2.1.1 MySQL数据库

**Ubuntu/Debian系统：**
```bash
# 安装MySQL
apt update
apt install -y mysql-server

# 启动MySQL服务
systemctl start mysql
systemctl enable mysql

# 查看MySQL状态
systemctl status mysql
```

**CentOS/RHEL系统：**
```bash
# 安装MySQL
dnf install -y mysql-server

# 启动MySQL服务
systemctl start mysqld
systemctl enable mysqld

# 查看MySQL状态
systemctl status mysqld
```

#### 2.1.2 Redis缓存

**Ubuntu/Debian系统：**
```bash
# 安装Redis
apt install -y redis-server

# 启动Redis服务
systemctl start redis
systemctl enable redis

# 查看Redis状态
systemctl status redis
```

**CentOS/RHEL系统：**
```bash
# 安装Redis
dnf install -y redis

# 启动Redis服务
systemctl start redis
systemctl enable redis

# 查看Redis状态
systemctl status redis
```

#### 2.1.3 JDK 8+

**Ubuntu/Debian系统：**
```bash
# 安装OpenJDK 8
apt install -y openjdk-8-jdk

# 验证JDK版本
java -version
```

**CentOS/RHEL系统：**
```bash
# 安装OpenJDK 8
dnf install -y java-1.8.0-openjdk

# 验证JDK版本
java -version
```

#### 2.1.4 Maven 3.6+

```bash
# 下载Maven
wget https://dlcdn.apache.org/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.tar.gz

# 解压并安装
tar -zxvf apache-maven-3.8.8-bin.tar.gz -C /opt/
ln -s /opt/apache-maven-3.8.8 /opt/maven

# 配置环境变量
echo 'export MAVEN_HOME=/opt/maven' >> ~/.bashrc
echo 'export PATH=$MAVEN_HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# 验证Maven版本
mvn -version
```

#### 2.1.5 Node.js 14+

```bash
# 安装Node.js和npm
curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt-get install -y nodejs

# 验证版本
node -v
npm -v

# 升级npm
npm install -g npm@latest
```

## 3. 数据库初始化

### 3.1 创建数据库

```bash
# 登录MySQL
mysql -u root -p

# 创建数据库
CREATE DATABASE jsh_erp DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# 退出MySQL
quit
```

### 3.2 导入初始化数据

```bash
# 使用mysql命令导入数据
mysql -u root -p jsh_erp < /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/docs/jsh_esp_test.sql
```

## 4. 启动后端服务

### 4.1 配置数据库连接

查看并确认后端配置文件：
```bash
cat /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/resources/application.properties
```

默认配置已经适配本地环境：
- 数据库地址：`127.0.0.1:3306`
- 数据库名称：`jsh_erp`
- 数据库用户名：`root`
- 数据库密码：`123456`
- Redis地址：`127.0.0.1:6379`
- Redis密码：`1234abcd`

### 4.2 启动后端服务

```bash
# 进入后端目录
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot

# 启动后端服务（开发模式）
mvn spring-boot:run
```

### 4.3 验证后端服务

后端服务启动成功后，会看到以下输出：
```
2026/01/25-19:55:34 INFO  [main] com.jsh.erp.ErpApplication - Started ErpApplication in 24.095 seconds (JVM running for 31.788)
启动成功，后端服务API地址：http://0.0.0.1:8443/jshERP-boot/doc.html
您还需启动前端服务，启动命令：yarn run serve 或 npm run serve，测试用户：jsh，密码：123456
```

可以通过以下地址访问API文档：
- **Swagger文档**：http://localhost:8443/jshERP-boot/swagger-ui.html
- **增强版API文档**：http://localhost:8443/jshERP-boot/doc.html
- **HTTP访问地址**：http://localhost:9090/jshERP-boot

> 注意：HTTP端口已从默认的8080更改为9090

## 5. 启动前端服务

### 5.1 安装前端依赖

```bash
# 进入前端目录
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-web

# 安装npm依赖
npm install
```

### 5.2 启动前端服务

```bash
# 启动前端服务（开发模式）
npm run serve
```

### 5.3 验证前端服务

前端服务启动成功后，会看到以下输出：
```
 DONE  Compiled successfully in 55287ms                      7:56:53 PM

  App running at:
  - Local:   http://localhost:3003/ 
  - Network: http://10.25.2.34:3003/

  Note that the development build is not optimized.
  To create a production build, run npm run build.
```

## 6. 访问系统

### 6.1 系统登录

1. 打开浏览器，访问前端地址：http://localhost:3003/
2. 输入测试账号和密码：
   - **用户名**：`jsh`
   - **密码**：`123456`
3. 点击"登录"按钮进入系统

### 6.2 功能模块

系统包含以下核心功能模块：
- **零售管理**：零售出库、零售退货
- **采购管理**：请购单、采购订单、采购入库、采购退货
- **销售管理**：销售订单、销售出库、销售退货
- **仓库管理**：其他入库、其他出库、调拨出库、组装单、拆卸单
- **财务管理**：收入单、支出单、收款单、付款单、转账单、收预付款
- **报表查询**：商品库存、账户统计、零售统计、采购统计、销售统计等
- **商品管理**：商品类别、商品信息、多单位、多属性
- **基础资料**：供应商信息、客户信息、会员信息、仓库信息等
- **系统管理**：角色管理、用户管理、机构管理、日志管理等

## 7. 常见问题及解决方案

### 7.1 数据库连接失败

**问题现象**：后端启动时提示数据库连接失败

**解决方案**：
1. 检查MySQL服务是否运行：`systemctl status mysql`
2. 检查数据库用户名和密码是否正确
3. 检查数据库是否已创建：`mysql -u root -p -e "SHOW DATABASES;"`
4. 检查数据库权限：确保root用户可以本地连接

### 7.2 Redis连接失败

**问题现象**：后端启动时提示Redis连接失败

**解决方案**：
1. 检查Redis服务是否运行：`systemctl status redis`
2. 检查Redis配置文件：`cat /etc/redis/redis.conf`
3. 确保Redis监听本地地址：`bind 127.0.0.1`
4. 检查Redis密码是否正确

### 7.3 前端编译失败

**问题现象**：`npm run serve` 命令执行失败

**解决方案**：
1. 清理npm缓存：`npm cache clean --force`
2. 删除node_modules目录：`rm -rf node_modules package-lock.json`
3. 重新安装依赖：`npm install`
4. 检查Node.js版本是否符合要求

### 7.4 端口被占用

**问题现象**：启动服务时提示端口已被占用

**解决方案**：
1. 查找占用端口的进程：`lsof -i :8443`（后端端口）或 `lsof -i :3003`（前端端口）
2. 终止占用端口的进程：`kill -9 <PID>`
3. 或修改配置文件中的端口号

## 8. 开发建议

1. **开发顺序**：先启动数据库和Redis，再启动后端，最后启动前端
2. **日志查看**：后端日志在控制台实时输出，前端日志在浏览器控制台查看
3. **API调试**：使用Swagger文档（http://localhost:8443/jshERP-boot/doc.html）调试后端API
4. **代码规范**：遵循项目现有的代码风格和规范
5. **版本控制**：使用Git进行代码版本管理

## 9. 生产环境部署建议

1. 使用Nginx作为前端静态资源服务器和反向代理
2. 配置HTTPS证书，确保数据传输安全
3. 配置数据库主从复制和Redis主从复制
4. 使用Docker容器化部署，便于管理和扩展
5. 配置监控告警系统，及时发现和处理问题
6. 定期备份数据库和重要数据

## 10. 联系方式

- **技术支持**：如有任何问题，请联系技术支持团队
- **文档更新**：本文档会定期更新，请关注最新版本

---

**文档版本**：v1.0
**更新日期**：2026-01-26
**适用范围**：ERP系统本地开发环境搭建