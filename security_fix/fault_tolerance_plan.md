# jshERP安全修复容错管理计划

## 1. 概述

本计划旨在为jshERP项目的安全修复工作建立一套完整的容错管理机制，确保修复过程的安全性、可靠性和可追溯性，最小化修复过程中可能出现的风险和损失。

## 2. 容错管理原则

- **预防为主**：在修复前采取充分的预防措施，降低风险
- **可追溯性**：所有修复操作必须记录完整日志
- **快速回滚**：修复失败时能够快速恢复到原始状态
- **验证优先**：修复后必须经过严格验证才能上线
- **分层保护**：采用多层容错机制，确保系统安全性

## 3. 容错管理体系

### 3.1 备份机制

#### 3.1.1 备份策略
- **全量备份**：修复前对整个项目进行全量备份
- **增量备份**：修复过程中对修改的文件进行增量备份
- **关键文件备份**：对配置文件、数据库脚本等关键文件进行单独备份

#### 3.1.2 备份方法
```bash
# 全量备份示例
BACKUP_DIR="/home/aaaaaa/workplace/ctt_jshERP_backups/$(date +%Y%m%d_%H%M%S)"
mkdir -p $BACKUP_DIR
tar -czf $BACKUP_DIR/full_backup.tar.gz /home/aaaaaa/workplace/ctt_jshERP

# 关键文件备份
cp /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/resources/application.properties $BACKUP_DIR/
cp /home/aaaaaa/workplace/ctt_jshERP/jshERP-boot/src/main/resources/mapper_xml/DepotItemMapperEx.xml $BACKUP_DIR/
```

#### 3.1.3 备份存储
- 备份文件存储在独立目录中
- 备份文件保留30天
- 定期检查备份文件的完整性

### 3.2 监控机制

#### 3.2.1 修复过程监控
- 使用版本控制系统（Git）监控代码变化
- 记录修复过程中的所有操作
- 实时监控修复过程中的错误信息

#### 3.2.2 系统状态监控
- 监控系统资源使用情况
- 监控应用程序运行状态
- 监控数据库连接和性能

### 3.3 验证机制

#### 3.3.1 静态代码分析
- 使用PMD进行代码质量检查
- 使用OWASP Dependency Check检查依赖漏洞
- 运行代码格式化工具确保代码风格一致

#### 3.3.2 动态测试
- 运行单元测试
- 运行集成测试
- 进行功能测试
- 进行安全测试（如SQL注入、XSS等）

#### 3.3.3 验证流程
1. 修复完成后运行静态代码分析
2. 运行单元测试和集成测试
3. 进行功能测试验证修复效果
4. 进行安全测试确保没有引入新的漏洞
5. 验证通过后才能进行下一步

### 3.4 回滚机制

#### 3.4.1 回滚策略
- **快速回滚**：使用备份文件快速恢复到修复前状态
- **增量回滚**：针对部分修复失败的情况，只回滚失败的部分
- **版本回滚**：使用Git版本控制系统回滚到指定版本

#### 3.4.2 回滚方法
```bash
# 使用备份回滚示例
BACKUP_FILE="/home/aaaaaa/workplace/ctt_jshERP_backups/20260109_120000/full_backup.tar.gz"
tar -xzf $BACKUP_FILE -C /

# 使用Git回滚示例
git checkout <commit_id>
```

#### 3.4.3 回滚触发条件
- 静态代码分析失败
- 单元测试或集成测试失败
- 功能测试验证不通过
- 安全测试发现新的漏洞
- 修复后系统出现异常

### 3.5 日志记录

#### 3.5.1 修复日志
- 记录修复的安全问题
- 记录修复方法和步骤
- 记录修复前后的状态对比
- 记录验证结果

#### 3.5.2 操作日志
- 记录执行的命令和脚本
- 记录修改的文件和内容
- 记录执行时间和执行人
- 记录执行结果

#### 3.5.3 日志格式
```
[2026-01-09 12:00:00] [INFO] 开始修复SQL注入漏洞
[2026-01-09 12:00:05] [INFO] 备份文件：/home/aaaaaa/workplace/ctt_jshERP_backups/20260109_120000
[2026-01-09 12:00:10] [INFO] 修改文件：DepotItemMapperEx.xml
[2026-01-09 12:00:15] [INFO] 修复完成，开始验证
[2026-01-09 12:00:20] [INFO] 静态代码分析通过
[2026-01-09 12:00:25] [INFO] 单元测试通过
[2026-01-09 12:00:30] [INFO] 修复验证通过
```

## 4. 容错管理工具

### 4.1 备份脚本
```bash
#!/bin/bash
# 安全修复备份脚本

BACKUP_ROOT="/home/aaaaaa/workplace/ctt_jshERP_backups"
PROJECT_DIR="/home/aaaaaa/workplace/ctt_jshERP"
BACKUP_DIR="$BACKUP_ROOT/$(date +%Y%m%d_%H%M%S)"

# 创建备份目录
mkdir -p $BACKUP_DIR

# 全量备份
echo "开始全量备份..."
tar -czf $BACKUP_DIR/full_backup.tar.gz $PROJECT_DIR > $BACKUP_DIR/backup.log 2>&1

# 关键文件备份
echo "开始关键文件备份..."
mkdir -p $BACKUP_DIR/critical_files
cp $PROJECT_DIR/jshERP-boot/src/main/resources/application.properties $BACKUP_DIR/critical_files/
cp $PROJECT_DIR/jshERP-boot/src/main/resources/mapper_xml/*.xml $BACKUP_DIR/critical_files/

# 备份数据库（如果有）
echo "开始数据库备份..."
# mysqldump -u root -p jsh_erp > $BACKUP_DIR/jsh_erp.sql 2>> $BACKUP_DIR/backup.log

# 生成备份报告
echo "备份完成！" > $BACKUP_DIR/backup_report.txt
echo "备份时间：$(date)" >> $BACKUP_DIR/backup_report.txt
echo "备份目录：$BACKUP_DIR" >> $BACKUP_DIR/backup_report.txt
echo "全量备份文件：$BACKUP_DIR/full_backup.tar.gz" >> $BACKUP_DIR/backup_report.txt
echo "关键文件备份：$BACKUP_DIR/critical_files/" >> $BACKUP_DIR/backup_report.txt

# 显示备份结果
cat $BACKUP_DIR/backup_report.txt
```

### 4.2 验证脚本
```bash
#!/bin/bash
# 安全修复验证脚本

PROJECT_DIR="/home/aaaaaa/workplace/ctt_jshERP"
LOG_FILE="$PROJECT_DIR/security_check/validation.log"

# 清空日志文件
> $LOG_FILE

# 静态代码分析
echo "[INFO] 开始静态代码分析..." >> $LOG_FILE
cd $PROJECT_DIR/jshERP-boot
mvn pmd:check >> $LOG_FILE 2>&1
if [ $? -eq 0 ]; then
    echo "[INFO] 静态代码分析通过！" >> $LOG_FILE
else
    echo "[ERROR] 静态代码分析失败！" >> $LOG_FILE
    exit 1
fi

# 依赖检查
echo "[INFO] 开始依赖检查..." >> $LOG_FILE
mvn dependency-check:check >> $LOG_FILE 2>&1
if [ $? -eq 0 ]; then
    echo "[INFO] 依赖检查通过！" >> $LOG_FILE
else
    echo "[WARNING] 依赖检查发现问题，继续验证..." >> $LOG_FILE
fi

# 单元测试
echo "[INFO] 开始单元测试..." >> $LOG_FILE
mvn test >> $LOG_FILE 2>&1
if [ $? -eq 0 ]; then
    echo "[INFO] 单元测试通过！" >> $LOG_FILE
else
    echo "[ERROR] 单元测试失败！" >> $LOG_FILE
    exit 1
fi

# 集成测试
echo "[INFO] 开始集成测试..." >> $LOG_FILE
mvn verify >> $LOG_FILE 2>&1
if [ $? -eq 0 ]; then
    echo "[INFO] 集成测试通过！" >> $LOG_FILE
else
    echo "[ERROR] 集成测试失败！" >> $LOG_FILE
    exit 1
fi

# 验证报告
echo "[INFO] 验证完成！" >> $LOG_FILE
cat $LOG_FILE
```

### 4.3 回滚脚本
```bash
#!/bin/bash
# 安全修复回滚脚本

PROJECT_DIR="/home/aaaaaa/workplace/ctt_jshERP"

# 检查参数
if [ $# -eq 0 ]; then
    echo "请提供备份目录路径！"
    echo "用法：$0 <备份目录>"
    exit 1
fi

BACKUP_DIR=$1

# 检查备份目录是否存在
if [ ! -d "$BACKUP_DIR" ]; then
    echo "备份目录不存在：$BACKUP_DIR"
    exit 1
fi

# 停止应用（如果运行中）
echo "正在停止应用..."
pkill -f "jshERP-boot" 2>/dev/null

# 恢复文件
echo "开始恢复文件..."
tar -xzf $BACKUP_DIR/full_backup.tar.gz -C /

# 恢复数据库（如果有）
echo "开始恢复数据库..."
# mysql -u root -p jsh_erp < $BACKUP_DIR/jsh_erp.sql

# 启动应用
echo "正在启动应用..."
cd $PROJECT_DIR/jshERP-boot
mvn spring-boot:run > $PROJECT_DIR/security_check/rollback.log 2>&1 &

# 回滚报告
echo "回滚完成！" > $PROJECT_DIR/security_check/rollback_report.txt
echo "回滚时间：$(date)" >> $PROJECT_DIR/security_check/rollback_report.txt
echo "备份目录：$BACKUP_DIR" >> $PROJECT_DIR/security_check/rollback_report.txt
echo "应用已启动，日志位于：$PROJECT_DIR/security_check/rollback.log" >> $PROJECT_DIR/security_check/rollback_report.txt

# 显示回滚结果
cat $PROJECT_DIR/security_check/rollback_report.txt
```

### 4.4 修复日志工具
```bash
#!/bin/bash
# 修复日志记录工具

LOG_FILE="/home/aaaaaa/workplace/ctt_jshERP/security_check/repair.log"

# 日志记录函数
log() {
    local level=$1
    local message=$2
    echo "[$(date +%Y-%m-%d%H:%M:%S)] [$level] $message" >> $LOG_FILE
    echo "[$level] $message"
}

# 示例用法
if [ "$1" = "init" ]; then
    log "INFO" "开始修复：$2"
elif [ "$1" = "backup" ]; then
    log "INFO" "备份完成：$2"
elif [ "$1" = "modify" ]; then
    log "INFO" "修改文件：$2"
elif [ "$1" = "verify" ]; then
    log "INFO" "验证结果：$2"
elif [ "$1" = "complete" ]; then
    log "INFO" "修复完成：$2"
elif [ "$1" = "rollback" ]; then
    log "ERROR" "修复失败，开始回滚：$2"
else
    echo "用法：$0 <命令> <参数>"
    echo "命令："
    echo "  init <修复名称> - 初始化修复日志"
    echo "  backup <备份目录> - 记录备份信息"
    echo "  modify <文件名> - 记录文件修改"
    echo "  verify <结果> - 记录验证结果"
    echo "  complete <修复名称> - 记录修复完成"
    echo "  rollback <原因> - 记录回滚信息"
fi
```

## 5. 容错管理流程

### 5.1 修复前准备
1. 制定详细的修复计划
2. 运行备份脚本，对项目进行全量备份
3. 初始化修复日志
4. 检查系统状态，确保系统正常运行

### 5.2 修复执行
1. 按照修复计划执行修复操作
2. 每修改一个文件，使用日志工具记录
3. 对修改的文件进行增量备份
4. 修复过程中遇到问题，及时记录并评估风险

### 5.3 修复验证
1. 运行验证脚本，进行静态代码分析和测试
2. 进行功能测试，验证修复效果
3. 进行安全测试，确保没有引入新的漏洞
4. 生成验证报告

### 5.4 上线部署
1. 修复验证通过后，部署到生产环境
2. 监控生产环境运行状态
3. 记录上线时间和状态

### 5.5 回滚流程
1. 修复失败或验证不通过时，启动回滚流程
2. 运行回滚脚本，恢复到修复前状态
3. 记录回滚原因和结果
4. 重新评估修复计划，调整修复方案

## 6. 容错管理文档

### 6.1 修复记录表
| 修复ID | 修复日期 | 修复内容 | 修复人员 | 备份目录 | 验证结果 | 上线状态 | 备注 |
|--------|----------|----------|----------|----------|----------|----------|------|
| REP001 | 2026-01-09 | 修复SQL注入漏洞 | AI助手 | /backup/20260109_120000 | 通过 | 已上线 | - |
| REP002 | 2026-01-10 | 升级依赖项 | AI助手 | /backup/20260110_143000 | 通过 | 已上线 | - |
| REP003 | 2026-01-11 | 修复密码加密 | AI助手 | /backup/20260111_091500 | 失败 | 已回滚 | 需调整方案 |

### 6.2 回滚记录表
| 回滚ID | 回滚日期 | 对应的修复ID | 回滚原因 | 回滚人员 | 结果 | 备注 |
|--------|----------|--------------|----------|----------|------|------|
| ROL001 | 2026-01-11 | REP003 | 验证失败 | AI助手 | 成功 | 重新评估方案 |

## 7. 持续改进

1. 定期评估容错管理机制的有效性
2. 根据实际修复经验，调整容错策略
3. 不断完善容错工具和脚本
4. 加强团队成员的容错意识培训
5. 建立容错管理最佳实践库

## 8. 责任分工

| 角色 | 职责 |
|------|------|
| 修复负责人 | 制定修复计划，执行修复操作 |
| 验证人员 | 负责修复结果的验证 |
| 备份管理员 | 负责备份策略的执行和管理 |
| 监控人员 | 负责修复过程的监控和日志记录 |
| 回滚负责人 | 负责回滚流程的执行和管理 |

## 9. 附录

### 9.1 相关文件路径
- 容错管理计划：`/home/aaaaaa/workplace/ctt_jshERP/security_check/fault_tolerance_plan.md`
- 备份脚本：`/home/aaaaaa/workplace/ctt_jshERP/security_check/backup.sh`
- 验证脚本：`/home/aaaaaa/workplace/ctt_jshERP/security_check/validate.sh`
- 回滚脚本：`/home/aaaaaa/workplace/ctt_jshERP/security_check/rollback.sh`
- 修复日志工具：`/home/aaaaaa/workplace/ctt_jshERP/security_check/repair_log.sh`
- 修复日志：`/home/aaaaaa/workplace/ctt_jshERP/security_check/repair.log`

### 9.2 紧急联系信息
- 技术支持：[技术支持联系方式]
- 运维团队：[运维团队联系方式]
- 安全团队：[安全团队联系方式]

---

**版本**：1.0  
**创建日期**：2026-01-09  
**更新日期**：2026-01-09  
**审批人**：[审批人姓名]
