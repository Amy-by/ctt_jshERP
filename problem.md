问题编号：1
问题具体内容：零售出库页面（http://localhost:3003/bill/retail_out）显示无数据
问题解决方法：
1) 在DepotHeadMapperEx.xml中为selectByConditionDepotHead查询添加tenant_id过滤条件；
2) 修复数据库中零售出库记录的type和subType值，从'零售出库'更新为正确的'出库'和'零售'；
3) 重新打包并启动后端服务
问题涉及文件或其他：
- jshERP-boot/src/main/resources/mapper_xml/DepotHeadMapperEx.xml
- jshERP-boot/src/main/java/com/jsh/erp/service/DepotHeadService.java
- 数据库表jsh_depot_head

问题编号：2
问题具体内容：数据库中零售出库记录的type和subType值与系统定义不符
问题解决方法：执行SQL语句将记录更新为正确值：UPDATE jsh_depot_head SET type='出库', sub_type='零售' WHERE type='零售出库' OR sub_type='零售出库'
问题涉及文件或其他：数据库表jsh_depot_head

问题编号：3
问题具体内容：后端查询缺少tenant_id过滤条件，导致多租户数据隔离问题
问题解决方法：在DepotHeadMapperEx.xml中为所有相关查询添加tenant_id过滤条件
问题涉及文件或其他：jshERP-boot/src/main/resources/mapper_xml/DepotHeadMapperEx.xml

问题编号：4
问题具体内容：零售出库记录因creator过滤条件无法显示，当前用户只能看到自己创建的记录
问题解决方法：修改DepotHeadService的select方法，为零售出库记录添加特殊处理，将creatorArray设为null，允许查看所有零售出库记录
问题涉及文件或其他：jshERP-boot/src/main/java/com/jsh/erp/service/DepotHeadService.java

问题编号：5
问题具体内容：测试文档中"物料管理"菜单在系统中实际显示为"商品管理"，导致用户找不到对应菜单
问题解决方法：更新测试文档，将所有"物料管理"相关内容改为"商品管理"，包括菜单名称、测试数据和测试步骤
问题涉及文件或其他：/home/aaaaaa/workplace/ctt_jshERP/MANUAL_TEST_FLOW.md

问题编号：6
问题具体内容：UserMenu.vue组件的Dropdown部分存在渲染错误，当isDesktop()返回false时会导致TypeError
问题解决方法：修改UserMenu.vue组件，将Dropdown的触发器从条件渲染改为条件显示，确保在所有情况下Dropdown都有内容
问题涉及文件或其他：jshERP-web/src/components/tools/UserMenu.vue

问题编号：7
问题具体内容：商品创建时出现"条码信息写入异常"错误，无法正常保存商品信息
问题解决方法：
1) 修复MaterialModal.vue中的图片上传处理逻辑，正确处理fileList数组而非当作字符串处理
2) 修复错误信息获取方式，直接从res.message获取错误信息，而非res.data.message
3) 增强HTTP请求的错误处理机制，确保显示具体的错误信息而非模糊的"数据写入异常"
4) 将可选链操作符替换为兼容的写法，确保代码能正常编译
问题涉及文件或其他：jshERP-web/src/views/material/modules/MaterialModal.vue