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