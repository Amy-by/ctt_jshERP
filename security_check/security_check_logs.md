# jshERP项目安全性检查日志

## 1. 代码敏感信息搜索

### 检查工具
- **grep**：命令行搜索工具

### 检查过程
1. 使用grep搜索硬编码的密码
   ```bash
   grep -r "password" --include="*.properties" --include="*.xml" --include="*.java" /home/aaaaaa/workplace/ctt_jshERP
   ```

2. 搜索硬编码的密钥和令牌
   ```bash
   grep -r "secret\|key\|token" --include="*.properties" --include="*.xml" --include="*.java" /home/aaaaaa/workplace/ctt_jshERP
   ```

3. 搜索硬编码的数据库连接信息
   ```bash
   grep -r "jdbc:mysql" --include="*.properties" --include="*.xml" --include="*.java" /home/aaaaaa/workplace/ctt_jshERP
   ```

### 发现结果
- 在application.properties中发现硬编码的数据库密码和Redis密码
- 在generatorConfig.xml中发现硬编码的测试数据库密码

---

## 2. 后门与数据收集机制检查

### 检查工具
- **grep**：命令行搜索工具
- **Git**：版本控制系统，用于检查代码历史

### 检查过程
1. 搜索可疑的函数调用
   ```bash
   grep -r "exec\|system\|Runtime.getRuntime().exec\|ProcessBuilder" --include="*.java" /home/aaaaaa/workplace/ctt_jshERP
   ```

2. 搜索向外部服务器发送数据的代码
   ```bash
   grep -r "http://\|https://" --include="*.java" /home/aaaaaa/workplace/ctt_jshERP
   ```

3. 检查GitHub仓库和代码贡献者
   ```bash
   git log --author="可疑作者" /home/aaaaaa/workplace/ctt_jshERP
   ```

### 发现结果
- 项目中使用了HttpClient工具类发送HTTP请求，但仅用于微信相关功能
- 未发现向未知服务器发送数据的机制
- 未发现可疑的函数调用

---

## 3. 认证与授权机制检查

### 检查工具
- **IntelliJ IDEA**：代码分析工具
- **grep**：命令行搜索工具

### 检查过程
1. 查看UserController.java文件，分析登录流程
   ```bash
   grep -A 20 "@PostMapping(\"/login\")" /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp/web/controller/UserController.java
   ```

2. 查看UserService.java文件，分析密码验证和token生成
   ```bash
   grep -A 30 "login" /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp/service/UserService.java
   ```

3. 查看权限控制相关代码
   ```bash
   grep -r "permission\|role" --include="*.java" /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp
   ```

### 发现结果
- 用户登录时，密码使用MD5加密存储
- 登录成功后，生成UUID作为token并存入Redis
- 通过角色控制用户权限，角色信息存储在数据库中
- 缺少密码复杂度要求和登录失败次数限制

---

## 4. 输入验证与输出编码检查

### 检查工具
- **IntelliJ IDEA**：代码分析工具
- **grep**：命令行搜索工具
- **PMD**：静态代码分析工具

### 检查过程
1. 搜索MyBatis XML文件中的参数绑定方式
   ```bash
   grep -r "${" --include="*.xml" /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/resources/mapper
   ```

2. 查看前端表单验证逻辑
   ```bash
   grep -r "validate" --include="*.vue" /home/aaaaaa/workplace/ctt_jshERP/jshERP-web/src
   ```

3. 检查后端接口参数验证
   ```bash
   grep -r "@Valid\|@NotBlank\|@NotNull" --include="*.java" /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp
   ```

### 发现结果
- 在DepotItemMapperEx.xml中发现3处直接参数替换（${}），存在SQL注入风险
- 未发现明显的XSS防护机制
- 后端接口缺少统一的参数验证机制

---

## 5. 错误处理与信息泄露检查

### 检查工具
- **IntelliJ IDEA**：代码分析工具
- **grep**：命令行搜索工具

### 检查过程
1. 查看全局异常处理类
   ```bash
   cat /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp/web/GlobalExceptionHandler.java
   ```

2. 搜索日志记录的异常信息
   ```bash
   grep -r "logger.error\|log.error" --include="*.java" /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp
   ```

3. 检查错误码和错误信息定义
   ```bash
   cat /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp/utils/ExceptionConstants.java
   ```

### 发现结果
- 使用了全局异常处理类`GlobalExceptionHandler`，使用`@RestControllerAdvice`注解捕获所有异常
- 异常信息会被记录到日志中，但对客户端只返回错误码和错误信息
- 系统异常返回统一的错误信息，不会泄露具体的异常类型和堆栈信息

---

## 6. 文件上传与下载安全检查

### 检查工具
- **IntelliJ IDEA**：代码分析工具
- **grep**：命令行搜索工具

### 检查过程
1. 查看文件上传相关代码
   ```bash
   grep -r "upload" --include="*.java" /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp
   ```

2. 查看SystemConfigController.java中的文件处理逻辑
   ```bash
   cat /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp/web/controller/SystemConfigController.java | grep -A 50 "upload" -A 50 "download"
   ```

3. 查看SystemConfigService.java中的文件处理逻辑
   ```bash
   cat /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp/service/SystemConfigService.java | grep -A 50 "upload" -A 50 "download"
   ```

### 发现结果
- 文件上传有类型验证和目录遍历防护
- 文件下载缺少权限控制
- 文件删除采用逻辑删除，将文件移动到deleted目录

---

## 7. 后端依赖项安全检查

### 检查工具
- **Maven**：构建工具
- **OWASP Dependency Check**：依赖项漏洞扫描工具

### 检查过程
1. 在pom.xml中配置OWASP Dependency Check插件
2. 运行依赖项漏洞扫描
   ```bash
   mvn dependency-check:check
   ```

### 发现结果
- 由于网络连接问题，无法获取CVE数据和RetireJS仓库数据
- 已在pom.xml中配置了OWASP Dependency Check插件

---

## 8. 前端依赖项安全检查

### 检查工具
- **npm**：Node.js包管理工具
- **npm audit**：依赖项漏洞扫描工具

### 检查过程
1. 安装前端依赖
   ```bash
   npm install --legacy-peer-deps
   ```

2. 运行npm audit检查依赖漏洞
   ```bash
   npm audit
   ```

### 发现结果
- 共发现179个漏洞，包括9个低危、82个中危、53个高危和35个严重漏洞
- 主要漏洞：Vue 2.x的ReDoS漏洞、webpack-dev-server的路径遍历和CORS漏洞、serialize-javascript的XSS和RCE漏洞等

---

## 9. 配置文件安全检查

### 检查工具
- **IntelliJ IDEA**：代码分析工具
- **grep**：命令行搜索工具

### 检查过程
1. 查看application.properties文件
   ```bash
   cat /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/resources/application.properties
   ```

2. 查看generatorConfig.xml文件
   ```bash
   cat /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/test/resources/generatorConfig.xml
   ```

3. 搜索所有配置文件
   ```bash
   find /home/aaaaaa/workplace/ctt_jshERP -name "*.properties" -o -name "*.xml" | xargs cat
   ```

### 发现结果
- application.properties中存在硬编码的数据库密码和Redis密码
- generatorConfig.xml中存在硬编码的测试数据库密码
- 未配置HTTPS传输和安全头信息

---

## 10. 数据安全检查

### 检查工具
- **IntelliJ IDEA**：代码分析工具
- **grep**：命令行搜索工具

### 检查过程
1. 检查密码哈希算法
   ```bash
   grep -r "MD5\|md5" --include="*.java" /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp
   ```

2. 检查HTTPS配置
   ```bash
   grep -r "https\|ssl" --include="*.properties" --include="*.xml" --include="*.java" /home/aaaaaa/workplace/ctt_jshERP
   ```

3. 检查数据加密相关代码
   ```bash
   grep -r "encrypt\|decrypt" --include="*.java" /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp
   ```

### 发现结果
- 密码使用MD5哈希存储，安全性较低
- 未配置HTTPS，数据传输存在泄露风险
- 未对敏感数据进行加密存储
- 缺少完善的密码策略

---

## 11. 日志安全检查

### 检查工具
- **IntelliJ IDEA**：代码分析工具
- **grep**：命令行搜索工具

### 检查过程
1. 检查日志配置
   ```bash
   grep -r "log4j\|slf4j\|logger" --include="*.properties" --include="*.xml" /home/aaaaaa/workplace/ctt_jshERP
   ```

2. 检查日志记录代码
   ```bash
   grep -r "logger." --include="*.java" /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp | head -50
   ```

3. 检查日志文件位置
   ```bash
   grep -r "log.path" --include="*.properties" --include="*.xml" /home/aaaaaa/workplace/ctt_jshERP
   ```

### 发现结果
- 日志中记录了完整的异常信息和堆栈跟踪
- 对客户端只返回错误码和错误信息，不泄露敏感信息
- 缺少日志访问控制和备份策略

---

## 12. 业务逻辑安全检查

### 检查工具
- **IntelliJ IDEA**：代码分析工具
- **grep**：命令行搜索工具

### 检查过程
1. 检查权限控制代码
   ```bash
   grep -r "checkPermission\|hasPermission" --include="*.java" /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp
   ```

2. 检查关键业务流程
   ```bash
   grep -r "order\|payment\|user" --include="*.java" /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp/web/controller
   ```

3. 检查审计相关代码
   ```bash
   grep -r "audit\|log\|record" --include="*.java" /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp
   ```

### 发现结果
- 通过角色控制用户权限，角色信息存储在数据库中
- 支持基于租户的权限控制
- 管理员登录时会发送登录邮件通知
- 缺少关键业务操作的审计记录

---

## 13. 静态代码扫描

### 检查工具
- **Maven**：构建工具
- **PMD**：静态代码分析工具

### 检查过程
1. 在pom.xml中配置PMD插件
2. 运行PMD静态代码扫描
   ```bash
   mvn pmd:pmd
   ```

3. 查看PMD生成的报告
   ```bash
   cat /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/target/site/pmd.html
   ```

### 发现结果
- 扫描成功完成，生成了HTML和XML格式的报告
- 发现了代码质量问题和潜在的安全漏洞
- 发现了不良的编码实践

---

## 14. 动态应用扫描

### 检查工具
- **Nikto**：Web服务器扫描工具

### 检查过程
1. 安装并配置MySQL 8.0数据库
   ```bash
   sudo apt install -y mysql-server
   sudo mysql -u root -e "CREATE DATABASE jsh_erp; ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456'; FLUSH PRIVILEGES;"
   ```

2. 安装并配置Redis 6.0
   ```bash
   sudo apt install -y redis-server
   sudo sed -i 's/# requirepass foobared/requirepass 1234abcd/' /etc/redis/redis.conf
   sudo systemctl restart redis-server
   ```

3. 启动应用程序
   ```bash
   cd jshERP-boot && mvn spring-boot:run
   ```

4. 安装并运行Nikto扫描
   ```bash
   sudo apt install -y nikto
   nikto -h http://localhost:9999/jshERP-boot
   ```

### 发现结果
- 使用Nikto 2.1.5工具进行了动态应用扫描
- 扫描目标：http://localhost:9999/jshERP-boot
- 扫描项数：6544项
- 发现问题：
  - 缺少X-Frame-Options安全头，存在点击劫持风险
- 扫描耗时：9秒

---

## 检查过程中遇到的问题及解决方法

1. **mvn命令未找到**
   - 原因：未安装Maven
   - 解决：使用apt安装Maven：`sudo apt update && sudo apt install -y maven`

2. **npm命令未找到**
   - 原因：未安装Node.js和npm
   - 解决：使用apt安装Node.js和npm：`sudo apt update && sudo apt install -y nodejs npm`

3. **后端依赖检查失败**
   - 原因：网络连接问题，无法获取CVE数据和RetireJS仓库数据
   - 解决：已在pom.xml中配置OWASP Dependency Check插件，建议在网络环境良好时重新运行

4. **前端依赖安装失败**
   - 原因：依赖项版本冲突
   - 解决：使用`--legacy-peer-deps`参数忽略peer dependency冲突，成功安装依赖

5. **PMD配置问题**
   - 原因：找不到rulesets/java/security.xml规则集文件
   - 解决：修复PMD配置，使用正确的规则集路径

---

## 所需的额外工具

### 已安装的工具
- grep
- Git
- Maven
- Node.js + npm
- PMD（通过Maven插件）
- OWASP Dependency Check（通过Maven插件）

### 建议安装的工具
1. **OWASP ZAP**：动态应用安全扫描工具
   ```bash
   sudo apt update && sudo apt install -y zaproxy
   ```

2. **SonarQube Scanner**：静态代码分析工具
   ```bash
   sudo apt update && sudo apt install -y sonar-scanner
   ```

3. **Checkstyle**：代码风格检查工具
   ```bash
   sudo apt update && sudo apt install -y checkstyle
   ```

4. **FindBugs**：静态代码分析工具
   ```bash
   sudo apt update && sudo apt install -y findbugs
   ```

5. **JSHint**：JavaScript代码质量检查工具
   ```bash
   npm install -g jshint
   ```

6. **ESLint**：JavaScript代码质量检查工具
   ```bash
   npm install -g eslint
   ```

7. **nmap**：网络扫描工具，用于检测开放端口和服务
   ```bash
   sudo apt update && sudo apt install -y nmap
   ```

8. **Nikto**：Web服务器扫描工具
   ```bash
   sudo apt update && sudo apt install -y nikto
   ```

---

## 15. Docker环境搭建

### 检查工具
- **Docker**：容器化平台
- **Docker Compose**：多容器管理工具

### 检查过程
1. 卸载旧版Docker
   ```bash
   sudo apt-get remove -y docker docker-engine docker.io containerd runc docker-compose
   ```

2. 安装系统工具
   ```bash
   sudo apt-get install -y ca-certificates curl
   ```

3. 添加Docker GPG密钥
   ```bash
   sudo install -m 0755 -d /etc/apt/keyrings
   sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
   sudo chmod a+r /etc/apt/keyrings/docker.asc
   ```

4. 添加阿里云Docker源
   ```bash
   sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list'
   ```

5. 添加阿里云GPG密钥
   ```bash
   curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
   ```

6. 安装Docker
   ```bash
   sudo apt-get update
   sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
   ```

7. 配置Docker加速器
   ```bash
   sudo mkdir -p /etc/docker
   sudo tee /etc/docker/daemon.json <<-'EOF'
   {
     "registry-mirrors": ["https://do.nark.eu.org","https://dc.j8.work","https://docker.m.daocloud.io","https://dockerproxy.com","https://docker.mirrors.ustc.edu.cn","https://docker.nju.edu.cn"]
   }
   EOF
   sudo systemctl daemon-reload
   sudo systemctl restart docker
   ```

8. 测试Docker安装
   ```bash
   sudo docker run hello-world
   ```

### 发现结果
- 成功安装Docker 29.1.3
- 成功安装Docker Compose 1.29.2
- 能正常拉取和运行Docker镜像

### 建议
- 使用Docker Compose启动jshERP应用
- 进行动态应用扫描

---

## 16. 动态应用扫描准备

### 检查工具
- **Docker Compose**：用于启动应用环境
- **OWASP ZAP**：动态应用扫描工具

### 检查过程
1. 创建docker-compose.yml文件
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

### 发现结果
- 已创建docker-compose.yml文件
- 准备启动应用进行动态扫描

### 建议
- 启动应用：`docker-compose up -d`
- 进行动态扫描：`docker run -t owasp/zap2docker-stable zap-baseline.py -t http://host.docker.internal:8080 -g gen.conf -r zap-report.html`

---

## 后续检查建议

1. 在网络环境良好时重新运行后端依赖项安全检查
2. 使用已搭建的Docker环境启动应用，进行动态应用扫描
3. 安装SonarQube Scanner，进行更全面的静态代码分析
4. 定期进行安全检查，包括依赖项检查、静态代码扫描和动态应用扫描
5. 建立安全监控机制，及时发现和处理安全事件

---

## 报告生成时间
2026-01-09

## 报告生成人
AI助手