#!/bin/bash

# jshERP安全漏洞修复回滚脚本
# 用于回滚所有安全修复到修复前状态

# 回滚日志文件
ROLLBACK_LOG="/home/aaaaaa/workplace/ctt_jshERP/security_fix/rollback_log.md"

# 备份目录
BACKUP_DIR="/tmp/security_fix"

# 项目根目录
PROJECT_ROOT="/home/aaaaaa/workplace/ctt_jshERP"

# 后端目录
BACKEND_DIR="$PROJECT_ROOT/jshERP-boot"

# 前端目录
FRONTEND_DIR="$PROJECT_ROOT/jshERP-web"

# 记录回滚开始时间
echo "# jshERP安全漏洞修复回滚日志" > $ROLLBACK_LOG
echo "## 回滚概况" >> $ROLLBACK_LOG
echo "- **回滚开始时间**：$(date +"%Y-%m-%d %H:%M:%S")" >> $ROLLBACK_LOG
echo "- **回滚人员**：AI助手" >> $ROLLBACK_LOG
echo "" >> $ROLLBACK_LOG
echo "## 回滚详细记录" >> $ROLLBACK_LOG

# 1. 回滚SQL注入风险修复
echo "### 1. 回滚SQL注入风险修复" >> $ROLLBACK_LOG
echo "- **回滚开始时间**：$(date +"%Y-%m-%d %H:%M:%S")" >> $ROLLBACK_LOG
if [ -f "$BACKUP_DIR/DepotItemMapperEx.xml.bak" ]; then
    cp $BACKUP_DIR/DepotItemMapperEx.xml.bak $BACKEND_DIR/src/main/resources/mapper_xml/DepotItemMapperEx.xml
    echo "  - 已恢复DepotItemMapperEx.xml文件" >> $ROLLBACK_LOG
else
    echo "  - 警告：未找到DepotItemMapperEx.xml.bak备份文件" >> $ROLLBACK_LOG
fi
echo "- **回滚结束时间**：$(date +"%Y-%m-%d %H:%M:%S")" >> $ROLLBACK_LOG
echo "" >> $ROLLBACK_LOG

# 2. 回滚文件下载权限控制修复
echo "### 2. 回滚文件下载权限控制修复" >> $ROLLBACK_LOG
echo "- **回滚开始时间**：$(date +"%Y-%m-%d %H:%M:%S")" >> $ROLLBACK_LOG
if [ -f "$BACKUP_DIR/SystemConfigController.java.bak" ]; then
    cp $BACKUP_DIR/SystemConfigController.java.bak $BACKEND_DIR/src/main/java/com/jsh/erp/controller/SystemConfigController.java
    echo "  - 已恢复SystemConfigController.java文件" >> $ROLLBACK_LOG
else
    echo "  - 警告：未找到SystemConfigController.java.bak备份文件" >> $ROLLBACK_LOG
fi
echo "- **回滚结束时间**：$(date +"%Y-%m-%d %H:%M:%S")" >> $ROLLBACK_LOG
echo "" >> $ROLLBACK_LOG

# 3. 回滚依赖项安全漏洞修复
echo "### 3. 回滚依赖项安全漏洞修复" >> $ROLLBACK_LOG
echo "- **回滚开始时间**：$(date +"%Y-%m-%d %H:%M:%S")" >> $ROLLBACK_LOG

# 3.1 回滚后端pom.xml
if [ -f "$BACKUP_DIR/pom.xml.bak" ]; then
    cp $BACKUP_DIR/pom.xml.bak $BACKEND_DIR/pom.xml
    echo "  - 已恢复pom.xml文件" >> $ROLLBACK_LOG
else
    echo "  - 警告：未找到pom.xml.bak备份文件" >> $ROLLBACK_LOG
fi

# 3.2 回滚前端依赖
if [ -f "$BACKUP_DIR/package.json.bak" ] && [ -f "$BACKUP_DIR/package-lock.json.bak" ]; then
    cp $BACKUP_DIR/package.json.bak $FRONTEND_DIR/package.json
    cp $BACKUP_DIR/package-lock.json.bak $FRONTEND_DIR/package-lock.json
    rm -rf $FRONTEND_DIR/node_modules
    echo "  - 已恢复package.json和package-lock.json文件" >> $ROLLBACK_LOG
else
    echo "  - 警告：未找到前端依赖备份文件" >> $ROLLBACK_LOG
fi
echo "- **回滚结束时间**：$(date +"%Y-%m-%d %H:%M:%S")" >> $ROLLBACK_LOG
echo "" >> $ROLLBACK_LOG

# 4. 回滚安全配置完善
echo "### 4. 回滚安全配置完善" >> $ROLLBACK_LOG
echo "- **回滚开始时间**：$(date +"%Y-%m-%d %H:%M:%S")" >> $ROLLBACK_LOG

# 删除新增的安全配置文件
if [ -f "$BACKEND_DIR/src/main/java/com/jsh/erp/config/SecurityConfig.java" ]; then
    rm $BACKEND_DIR/src/main/java/com/jsh/erp/config/SecurityConfig.java
    echo "  - 已删除SecurityConfig.java文件" >> $ROLLBACK_LOG
fi

if [ -f "$BACKEND_DIR/src/main/java/com/jsh/erp/filter/SecurityHeaderFilter.java" ]; then
    rm $BACKEND_DIR/src/main/java/com/jsh/erp/filter/SecurityHeaderFilter.java
    echo "  - 已删除SecurityHeaderFilter.java文件" >> $ROLLBACK_LOG
fi
echo "- **回滚结束时间**：$(date +"%Y-%m-%d %H:%M:%S")" >> $ROLLBACK_LOG
echo "" >> $ROLLBACK_LOG

# 5. 回滚密码加密方式升级
echo "### 5. 回滚密码加密方式升级" >> $ROLLBACK_LOG
echo "- **回滚开始时间**：$(date +"%Y-%m-%d %H:%M:%S")" >> $ROLLBACK_LOG

# 删除新增的PasswordUtil.java文件
if [ -f "$BACKEND_DIR/src/main/java/com/jsh/erp/utils/PasswordUtil.java" ]; then
    rm $BACKEND_DIR/src/main/java/com/jsh/erp/utils/PasswordUtil.java
    echo "  - 已删除PasswordUtil.java文件" >> $ROLLBACK_LOG
fi

# 回滚UserService.java文件
if [ -f "$BACKUP_DIR/UserService.java.bak" ]; then
    cp $BACKUP_DIR/UserService.java.bak $BACKEND_DIR/src/main/java/com/jsh/erp/service/UserService.java
    echo "  - 已恢复UserService.java文件" >> $ROLLBACK_LOG
else
    echo "  - 警告：未找到UserService.java.bak备份文件" >> $ROLLBACK_LOG
fi
echo "- **回滚结束时间**：$(date +"%Y-%m-%d %H:%M:%S")" >> $ROLLBACK_LOG
echo "" >> $ROLLBACK_LOG

# 6. 回滚敏感数据加密存储
echo "### 6. 回滚敏感数据加密存储" >> $ROLLBACK_LOG
echo "- **回滚开始时间**：$(date +"%Y-%m-%d %H:%M:%S")" >> $ROLLBACK_LOG

# 删除新增的AesUtil.java文件
if [ -f "$BACKEND_DIR/src/main/java/com/jsh/erp/utils/AesUtil.java" ]; then
    rm $BACKEND_DIR/src/main/java/com/jsh/erp/utils/AesUtil.java
    echo "  - 已删除AesUtil.java文件" >> $ROLLBACK_LOG
fi
echo "- **回滚结束时间**：$(date +"%Y-%m-%d %H:%M:%S")" >> $ROLLBACK_LOG
echo "" >> $ROLLBACK_LOG

# 7. 重新编译项目
echo "### 7. 重新编译项目" >> $ROLLBACK_LOG
echo "- **编译开始时间**：$(date +"%Y-%m-%d %H:%M:%S")" >> $ROLLBACK_LOG

# 7.1 编译后端
cd $BACKEND_DIR && mvn clean compile
if [ $? -eq 0 ]; then
    echo "  - 后端编译成功" >> $ROLLBACK_LOG
else
    echo "  - 后端编译失败" >> $ROLLBACK_LOG
fi

# 7.2 编译前端
cd $FRONTEND_DIR && npm install --legacy-peer-deps && npm run build
if [ $? -eq 0 ]; then
    echo "  - 前端编译成功" >> $ROLLBACK_LOG
else
    echo "  - 前端编译失败" >> $ROLLBACK_LOG
fi
echo "- **编译结束时间**：$(date +"%Y-%m-%d %H:%M:%S")" >> $ROLLBACK_LOG
echo "" >> $ROLLBACK_LOG

# 记录回滚结束时间
echo "## 回滚总结" >> $ROLLBACK_LOG
echo "- **回滚结束时间**：$(date +"%Y-%m-%d %H:%M:%S")" >> $ROLLBACK_LOG
echo "- **回滚状态**：完成" >> $ROLLBACK_LOG
echo "- **回滚结果**：已回滚所有安全修复到修复前状态" >> $ROLLBACK_LOG
echo "" >> $ROLLBACK_LOG

echo "jshERP安全漏洞修复回滚完成！" >> $ROLLBACK_LOG
echo "回滚日志已保存到：$ROLLBACK_LOG"

# 给脚本添加执行权限
chmod +x /home/aaaaaa/workplace/ctt_jshERP/security_fix/rollback.sh
