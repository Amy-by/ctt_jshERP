# jshERP项目安全性检查推荐解决方案

基于您的项目情况和遇到的问题，我推荐以下解决方案，按照实施优先级排序：

## 一、优先推荐：Docker快速部署 + 配置国内镜像源

### 1. 后端依赖检查解决方案：配置国内镜像源

**推荐理由**：
- 实施简单，只需修改`pom.xml`文件
- 不需要额外安装工具
- 利用国内镜像源提高下载速度和成功率
- 可长期使用，适合后续持续检查

**实施步骤**：

1. 编辑`jshERP-boot/pom.xml`文件，修改OWASP Dependency Check插件配置：

```xml
<plugin>
    <groupId>org.owasp</groupId>
    <artifactId>dependency-check-maven</artifactId>
    <version>7.3.2</version>
    <configuration>
        <failBuildOnCVSS>7</failBuildOnCVSS>
        <formats>
            <format>html</format>
            <format>json</format>
        </formats>
        <!-- 配置清华大学NVD镜像源 -->
        <cveUrlModified>https://mirrors.tuna.tsinghua.edu.cn/nvd/feeds/json/cve/1.1/nvdcve-1.1-modified.json.gz</cveUrlModified>
        <cveUrlBase>https://mirrors.tuna.tsinghua.edu.cn/nvd/feeds/json/cve/1.1/nvdcve-1.1-%d.json.gz</cveUrlBase>
        <!-- 配置阿里云Maven镜像源 -->
        <centralRepositoryUrl>https://maven.aliyun.com/repository/central</centralRepositoryUrl>
        <pluginRepositoryUrl>https://maven.aliyun.com/repository/central</pluginRepositoryUrl>
    </configuration>
    <executions>
        <execution>
            <goals>
                <goal>check</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```

2. 运行依赖检查：
```bash
cd jshERP-boot
mvn dependency-check:check
```

### 2. 动态应用扫描解决方案：Docker Compose快速部署

**推荐理由**：
- 一次性部署所有必要服务（MySQL、Redis、应用）
- 环境隔离，不影响现有系统
- 配置简单，只需一个`docker-compose.yml`文件
- 适合快速搭建测试环境，用完即删

**实施步骤**：

1. 在项目根目录创建`docker-compose.yml`文件：

```yaml
version: '3.8'
services:
  mysql:
    image: mysql:5.7
    container_name: jsherp-mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: jsherp
      MYSQL_USER: jsherp
      MYSQL_PASSWORD: 123456
    ports:
      - "3306:3306"
    volumes:
      - mysql-data:/var/lib/mysql

  redis:
    image: redis:6.2.1
    container_name: jsherp-redis
    restart: always
    ports:
      - "6379:6379"
    volumes:
      - redis-data:/data
    command: redis-server --requirepass 1234abcd

  app:
    build:
      context: ./jshERP-boot
      dockerfile: Dockerfile
    container_name: jsherp-app
    restart: always
    ports:
      - "8080:8080"
    depends_on:
      - mysql
      - redis
    environment:
      SPRING_DATASOURCE_URL: jdbc:mysql://mysql:3306/jsherp?useUnicode=true&characterEncoding=utf-8&useSSL=false
      SPRING_DATASOURCE_USERNAME: jsherp
      SPRING_DATASOURCE_PASSWORD: 123456
      SPRING_REDIS_HOST: redis
      SPRING_REDIS_PORT: 6379
      SPRING_REDIS_PASSWORD: 1234abcd

volumes:
  mysql-data:
  redis-data:
```

2. 构建并启动服务：
```bash
docker-compose up -d
```

3. 验证应用是否启动成功：
```bash
curl http://localhost:8080
```

4. 使用OWASP ZAP Docker镜像进行扫描：
```bash
docker run -t owasp/zap2docker-stable zap-baseline.py -t http://host.docker.internal:8080 -r zap-report.html
```

5. 查看扫描报告：
```bash
cat zap-report.html
```

6. 扫描完成后，清理环境：
```bash
docker-compose down -v
```

## 二、备选方案：如果Docker不可用

### 1. 后端依赖检查：使用Snyk替代工具

**推荐理由**：
- 无需配置复杂的镜像源
- 提供直观的Web界面和报告
- 支持多种语言和框架

**实施步骤**：
```bash
# 安装Snyk
npm install -g snyk

# 登录Snyk（需要注册账号）
snyk auth

# 扫描后端依赖
cd jshERP-boot
snyk test

# 扫描前端依赖
cd ../jshERP-front
snyk test
```

### 2. 动态应用扫描：手动配置环境

**实施步骤**：
1. 安装并配置MySQL和Redis
2. 初始化数据库
3. 启动应用
4. 使用Nikto进行简单扫描：
```bash
sudo apt install -y nikto
nikto -h http://localhost:8080
```

## 三、长期安全检查建议

1. **持续集成**：将安全检查集成到CI/CD流程中
2. **定期更新**：每季度运行一次完整的安全检查
3. **依赖管理**：建立依赖项更新机制，及时修复已知漏洞
4. **安全培训**：对开发团队进行安全编码培训
5. **漏洞跟踪**：建立漏洞跟踪机制，确保所有发现的漏洞都得到修复

## 四、当前已知问题的紧急修复建议

基于之前的安全检查结果，建议优先修复以下高风险问题：

1. **SQL注入漏洞**：将`DepotItemMapperEx.xml`中的直接参数替换（${}）改为预编译参数（#{}）
2. **硬编码敏感信息**：移除配置文件中的硬编码密码，改用环境变量或配置中心
3. **文件下载权限**：为文件下载接口添加权限控制
4. **前端依赖漏洞**：升级存在严重漏洞的前端依赖，特别是Vue、webpack-dev-server、serialize-javascript等
5. **缺少X-Frame-Options头**：添加X-Frame-Options安全头，防止点击劫持攻击
6. **后端依赖漏洞**：升级存在漏洞的后端依赖项，特别是Jackson-databind、Log4j、Httpclient等

## 结论

我强烈推荐使用**Docker快速部署 + 配置国内镜像源**的方案，这是实施难度最低、效果最好的解决方案。该方案可以帮助您快速完成后端依赖检查和动态应用扫描，同时为后续持续安全检查奠定基础。

如果您在实施过程中遇到任何问题，或需要进一步的帮助，请随时告诉我。