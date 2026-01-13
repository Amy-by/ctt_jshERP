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