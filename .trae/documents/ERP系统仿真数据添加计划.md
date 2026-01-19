## 修复零售出库页面无数据问题

### 问题分析

* 零售出库页面 `http://localhost:3003/bill/retail_out` 显示无数据

* 数据库中存在4条零售出库记录，且 `tenant_id=63`

* **根本原因**：`DepotHeadMapperEx.xml` 中的 `selectByConditionDepotHead` 查询缺少 `tenant_id` 过滤条件

* 系统采用多租户架构，所有查询必须包含 `tenant_id` 过滤以隔离不同用户数据

### 修复步骤

1. **修改** **`selectByConditionDepotHead`** **查询**

   * 在 `DepotHeadMapperEx.xml` 文件中，为 `selectByConditionDepotHead` 查询添加 `tenant_id` 过滤条件

   * 添加位置：在查询的 WHERE 子句中添加 `and dh.tenant_id = #{tenantId}`

2. **检查其他相关查询**

   * 检查 `DepotHeadMapperEx.xml` 中其他查询是否也需要添加 `tenant_id` 过滤

   * 重点检查：`findInOutDetail`、`findInOutDetailCount`、`findInOutDetailStatistic` 等查询

3. **重启后端服务**

   * 停止当前运行的后端服务

   * 重新打包并启动后端服务，使配置变更生效

4. **验证修复效果**

   * 访问零售出库页面 `http://localhost:3003/bill/retail_out`

   * 确认页面显示零售出库记录

   * 检查其他相关页面是否正常显示数据

### 预期结果

* 零售出库页面成功显示4条零售出库记录

* 其他相关页面数据显示正常

* 系统多租户隔离机制正常工作

