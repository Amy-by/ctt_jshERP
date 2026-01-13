# jshERP项目安全漏洞修复计划（最终版）

## 修复目标
根据安全检查结果，修复项目中存在的安全漏洞，提高系统整体安全性，确保修复过程可控、可回滚，并建立完整的修复日志。

## 修复原则
1. **可控性**：每个修复步骤都有明确的操作指南和验证方法
2. **可回滚性**：修复前备份原始文件，确保可以恢复到修复前状态
3. **日志完整性**：记录修复全过程，包括问题描述、修复步骤、验证结果等
4. **优先级**：按照风险等级和修复难度排序，先修复高风险问题

## 修复环境准备
1. **容错机制目录**：使用 `/home/aaaaaa/workplace/ctt_jshERP/security_fix` 作为容错目录，用于备份原始文件和存储修复日志
2. **日志文件**：在容错目录下创建 `security_fix_log.md` 作为修复全过程日志
3. **备份脚本**：创建备份脚本，用于自动备份待修改文件

## Git分支策略

### 分支清理与创建
1. **删除旧分支**：删除已存在的两个安全修复分支 `security-fix-auth` 和 `security-fixes-20260113`
2. **创建新分支**：基于最新的 `master` 分支创建新的安全修复分支 `security-fixes-20260113-new`
3. **分支用途**：所有安全修复工作都在新分支上进行，修复完成后合并到 `master` 分支

### 分支操作步骤

#### 1.1 问题描述
- 存在两个无用的安全修复分支，需要清理后创建新的分支

#### 1.2 修复步骤
1. 切换到 `master` 分支
2. 删除旧的安全修复分支 `security-fix-auth` 和 `security-fixes-20260113`
3. 拉取 `master` 分支最新代码
4. 创建新的安全修复分支 `security-fixes-20260113-new`
5. 验证新分支创建成功

#### 1.3 修复结果验证
- 旧分支已成功删除
- 新分支已基于最新master创建
- 分支结构清晰，便于后续修复工作

#### 1.4 命令
```bash
# 切换到master分支
git checkout master

# 删除旧的安全修复分支
git branch -D security-fix-auth
git branch -D security-fixes-20260113

# 拉取master分支最新代码
git pull

# 创建新的安全修复分支
git checkout -b security-fixes-20260113-new
```

## 修复步骤详细规划

### 2. 敏感信息硬编码修复

#### 2.1 问题描述
- 配置文件中硬编码数据库密码和Redis密码
- 风险等级：高

#### 2.2 修复步骤
1. 备份原始配置文件到容错目录
2. 修改application.properties，将硬编码密码替换为环境变量
3. 修改generatorConfig.xml，使用环境变量配置数据库连接
4. 测试应用启动是否正常

#### 2.3 修复结果验证
- 检查配置文件中是否存在硬编码密码
- 应用是否能正常启动
- 数据库和Redis连接是否正常

#### 2.4 编译/测试命令
```bash
# 测试后端启动
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot && mvn spring-boot:run
```

#### 2.5 回滚步骤
```bash
# 恢复原始配置文件
cp /home/aaaaaa/workplace/ctt_jshERP/security_fix/application.properties.bak /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/resources/application.properties
cp /home/aaaaaa/workplace/ctt_jshERP/security_fix/generatorConfig.xml.bak /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/generatorConfig.xml
```

### 3. 密码加密方式升级

#### 3.1 问题描述
- 密码仅使用MD5加密，安全性较低
- 风险等级：中

#### 3.2 修复步骤
1. 备份相关文件（UserService.java、密码工具类等）
2. 添加Spring Security依赖到pom.xml
3. 创建BCrypt密码工具类
4. 修改UserService中的密码验证逻辑
5. 测试密码验证功能

#### 3.3 修复结果验证
- 新用户注册密码是否使用BCrypt加密
- 现有用户登录是否正常
- 密码验证是否正确

#### 3.4 编译/测试命令
```bash
# 编译后端
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot && mvn compile

# 运行单元测试
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot && mvn test -Dtest=UserServiceTest
```

#### 3.5 回滚步骤
```bash
# 恢复原始文件
cp /home/aaaaaa/workplace/ctt_jshERP/security_fix/UserService.java.bak /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp/service/UserService.java
# 删除新增的密码工具类
rm /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp/utils/PasswordUtil.java
# 恢复pom.xml中的依赖配置
cp /home/aaaaaa/workplace/ctt_jshERP/security_fix/pom.xml.bak /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/pom.xml
```

### 4. SQL注入风险修复

#### 4.1 问题描述
- DepotItemMapperEx.xml中存在3处SQL注入风险
- 风险等级：高

#### 4.2 修复步骤
1. 备份原始DepotItemMapperEx.xml文件
2. 修改文件，将直接参数替换（${}）改为预编译参数（#{}）
3. 对于IN查询，使用MyBatis的foreach标签
4. 测试相关功能

#### 4.3 修复结果验证
- 检查文件中是否还有直接参数替换（${}）
- 测试相关接口功能是否正常
- 使用SQL注入测试工具验证漏洞是否修复

#### 4.4 编译/测试命令
```bash
# 编译后端
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot && mvn compile

# 运行相关测试
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot && mvn test -Dtest=DepotItemServiceTest
```

#### 4.5 回滚步骤
```bash
# 恢复原始文件
cp /home/aaaaaa/workplace/ctt_jshERP/security_fix/DepotItemMapperEx.xml.bak /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/resources/mapper/DepotItemMapperEx.xml
```

### 5. 文件下载权限控制修复

#### 5.1 问题描述
- SystemConfigController中的文件下载方法缺少权限控制
- 风险等级：中

#### 5.2 修复步骤
1. 备份原始SystemConfigController.java文件
2. 为view和viewMini方法添加权限检查
3. 测试文件下载功能

#### 5.3 修复结果验证
- 未登录用户访问文件下载URL是否返回401
- 登录用户是否可以正常下载文件

#### 5.4 编译/测试命令
```bash
# 编译后端
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot && mvn compile

# 运行相关测试
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot && mvn test -Dtest=SystemConfigControllerTest
```

#### 5.5 回滚步骤
```bash
# 恢复原始文件
cp /home/aaaaaa/workplace/ctt_jshERP/security_fix/SystemConfigController.java.bak /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp/controller/SystemConfigController.java
```

### 6. 依赖项安全漏洞修复

#### 6.1 问题描述
- 前端和后端依赖项存在大量已知漏洞
- 风险等级：高

#### 6.2 修复步骤
1. **前端依赖修复**：
   - 备份package.json和package-lock.json
   - 升级存在漏洞的依赖项
   - 测试构建是否成功

2. **后端依赖修复**：
   - 备份pom.xml
   - 升级存在漏洞的依赖项
   - 测试编译是否成功

#### 6.3 修复结果验证
- 前端：运行 `npm audit` 检查漏洞数量是否减少
- 后端：运行 `mvn dependency-check:check` 检查漏洞数量是否减少
- 应用功能是否正常

#### 6.4 编译/测试命令
```bash
# 前端依赖修复
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-web && npm install --legacy-peer-deps && npm run build

# 后端依赖修复
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot && mvn compile
```

#### 6.5 回滚步骤
```bash
# 前端回滚
cp /home/aaaaaa/workplace/ctt_jshERP/security_fix/package.json.bak /home/aaaaaa/workplace/ctt_jshERP/jshERP-web/package.json
cp /home/aaaaaa/workplace/ctt_jshERP/security_fix/package-lock.json.bak /home/aaaaaa/workplace/ctt_jshERP/jshERP-web/package-lock.json
rm -rf /home/aaaaaa/workplace/ctt_jshERP/jshERP-web/node_modules
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-web && npm install --legacy-peer-deps

# 后端回滚
cp /home/aaaaaa/workplace/ctt_jshERP/security_fix/pom.xml.bak /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/pom.xml
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot && mvn clean compile
```

### 7. 安全配置完善

#### 7.1 问题描述
- 缺少HTTPS配置
- 缺少安全头信息
- 缺少CORS配置
- 风险等级：中

#### 7.2 修复步骤
1. **HTTPS配置**：
   - 生成或获取SSL证书
   - 配置application.properties启用HTTPS
   - 配置HTTP到HTTPS重定向

2. **安全头配置**：
   - 完善SecurityConfig.java，添加完整的安全头配置
   - 包括Content-Security-Policy、X-XSS-Protection、X-Content-Type-Options等

3. **CORS配置**：
   - 在WebConfig.java中添加CORS策略配置
   - 限制允许的源、方法和头部

#### 7.3 修复结果验证
- 使用浏览器开发者工具检查响应头是否包含所需安全头
- 测试HTTPS访问是否正常
- 测试跨域请求是否正常

#### 7.4 编译/测试命令
```bash
# 编译后端
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot && mvn compile

# 运行应用测试HTTPS
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot && mvn spring-boot:run
```

#### 7.5 回滚步骤
```bash
# 恢复原始配置文件
cp /home/aaaaaa/workplace/ctt_jshERP/security_fix/application.properties.bak /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/resources/application.properties
cp /home/aaaaaa/workplace/ctt_jshERP/security_fix/SecurityConfig.java.bak /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp/config/SecurityConfig.java
cp /home/aaaaaa/workplace/ctt_jshERP/security_fix/WebConfig.java.bak /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp/config/WebConfig.java
```

### 8. 敏感数据加密存储

#### 8.1 问题描述
- 数据库中敏感数据未加密存储
- 风险等级：中

#### 8.2 修复步骤
1. 识别敏感数据字段（如用户手机号、邮箱等）
2. 实现数据库字段加密转换器
3. 修改实体类，添加加密注解
4. 更新数据访问代码
5. 测试数据加密和解密功能

#### 8.3 修复结果验证
- 数据库中敏感字段是否以加密形式存储
- 应用是否能正确读取和解密数据
- 相关功能是否正常

#### 8.4 编译/测试命令
```bash
# 编译后端
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot && mvn compile

# 运行相关测试
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot && mvn test -Dtest=UserControllerTest
```

#### 8.5 回滚步骤
```bash
# 恢复原始实体类和相关文件
cp /home/aaaaaa/workplace/ctt_jshERP/security_fix/User.java.bak /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp/model/User.java
# 删除加密转换器
rm /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/java/com/jsh/erp/config/AESConverter.java
```

## 回滚机制设计

### 全局回滚流程
1. 停止应用服务
2. 恢复所有备份文件
3. 重新编译应用
4. 启动应用服务
5. 验证应用功能

### 回滚脚本
在容错目录下创建 `rollback.sh` 脚本，用于自动回滚所有修复：
```bash
#!/bin/bash

# 停止应用服务
# （根据实际部署方式添加停止命令）

# 恢复所有备份文件
cp /home/aaaaaa/workplace/ctt_jshERP/security_fix/*.bak /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/

# 恢复前端依赖
cp /home/aaaaaa/workplace/ctt_jshERP/security_fix/package.json.bak /home/aaaaaa/workplace/ctt_jshERP/jshERP-web/package.json
cp /home/aaaaaa/workplace/ctt_jshERP/security_fix/package-lock.json.bak /home/aaaaaa/workplace/ctt_jshERP/jshERP-web/package-lock.json
rm -rf /home/aaaaaa/workplace/ctt_jshERP/jshERP-web/node_modules
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-web && npm install --legacy-peer-deps

# 重新编译应用
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot && mvn clean compile
cd /home/aaaaaa/workplace/ctt_jshERP/jshERP-web && npm run build

# 启动应用服务
# （根据实际部署方式添加启动命令）
```

## 修复日志设计

### 日志文件格式
在容错目录下创建 `security_fix_log.md` 文件，记录修复全过程：

```markdown
# jshERP安全漏洞修复日志

## 修复概况
- **修复开始时间**：YYYY-MM-DD HH:MM:SS
- **修复结束时间**：YYYY-MM-DD HH:MM:SS
- **修复人员**：
- **修复环境**：

## 修复详细记录

### 1. Git分支清理与创建
- **问题描述**：存在两个无用的安全修复分支，需要清理后创建新的分支
- **修复开始时间**：YYYY-MM-DD HH:MM:SS
- **修复步骤**：
  1. 切换到master分支
  2. 删除旧的安全修复分支
  3. 拉取master分支最新代码
  4. 创建新的安全修复分支
- **修复结果**：成功/失败
- **验证方法**：检查分支列表，确认旧分支已删除，新分支已创建
- **修复结束时间**：YYYY-MM-DD HH:MM:SS
- **备注**：

### 2. 敏感信息硬编码修复
- **问题描述**：配置文件中硬编码数据库密码和Redis密码
- **风险等级**：高
- **修复开始时间**：YYYY-MM-DD HH:MM:SS
- **修复步骤**：
  1. 备份原始配置文件
  2. 修改配置文件，替换硬编码密码为环境变量
  3. 验证配置文件
- **修复结果**：成功/失败
- **验证方法**：检查配置文件中是否存在硬编码密码
- **编译/测试结果**：成功/失败
- **修复结束时间**：YYYY-MM-DD HH:MM:SS
- **备注**：

# ... 其他修复记录 ...

## 修复总结
- **总修复问题数**：
- **成功修复数**：
- **失败修复数**：
- **遗留问题**：
- **修复效果评估**：
```

### 日志记录要求
1. 每个修复步骤开始前记录开始时间
2. 修复过程中记录关键操作
3. 修复完成后记录结束时间、修复结果和验证情况
4. 编译/测试结果必须记录
5. 任何异常情况必须详细记录

## 修复顺序建议

按照风险等级和修复难度排序，建议修复顺序为：
1. Git分支清理与创建
2. 敏感信息硬编码修复
3. SQL注入风险修复
4. 文件下载权限控制修复
5. 依赖项安全漏洞修复
6. 安全配置完善
7. 密码加密方式升级
8. 敏感数据加密存储

## 预期修复效果

1. 消除高风险安全漏洞
2. 提高系统整体安全性
3. 建立完善的安全配置
4. 确保修复过程可控、可回滚
5. 建立完整的修复日志

## 后续建议

1. 定期进行安全检查，包括依赖项检查、静态代码扫描等
2. 建立依赖项自动更新机制
3. 完善安全审计和监控体系
4. 制定安全编码规范，加强代码审查
5. 定期进行安全培训

## 风险提示

1. 依赖项升级可能导致功能兼容性问题，需充分测试
2. 安全配置修改可能影响现有功能，需仔细验证
3. 敏感数据加密存储可能影响系统性能，需评估影响
4. 修复过程中需确保应用服务的可用性，建议在非生产环境测试后再部署到生产环境

---

以上是完整的安全漏洞修复计划，确保修复过程可控、可回滚，并建立完整的修复日志。修复过程中将严格按照计划执行，确保每个步骤都有详细记录和验证。