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

# 压缩关键文件目录
echo "压缩关键文件目录..."
tar -czf $BACKUP_DIR/critical_files.tar.gz $BACKUP_DIR/critical_files/ >> $BACKUP_DIR/backup.log 2>&1

# 备份数据库（如果有）
echo "开始数据库备份..."
# mysqldump -u root -p jsh_erp > $BACKUP_DIR/jsh_erp.sql 2>> $BACKUP_DIR/backup.log

# 生成备份报告
echo "备份完成！" > $BACKUP_DIR/backup_report.txt
echo "备份时间：$(date)" >> $BACKUP_DIR/backup_report.txt
echo "备份目录：$BACKUP_DIR" >> $BACKUP_DIR/backup_report.txt
echo "全量备份文件：$BACKUP_DIR/full_backup.tar.gz" >> $BACKUP_DIR/backup_report.txt
echo "关键文件备份：$BACKUP_DIR/critical_files.tar.gz" >> $BACKUP_DIR/backup_report.txt

# 显示备份结果
cat $BACKUP_DIR/backup_report.txt