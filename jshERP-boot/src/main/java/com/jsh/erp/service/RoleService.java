package com.jsh.erp.service;

import com.alibaba.fastjson.JSONObject;
import com.jsh.erp.constants.BusinessConstants;
import com.jsh.erp.datasource.entities.Role;
import com.jsh.erp.datasource.entities.RoleEx;
import com.jsh.erp.datasource.entities.RoleExample;
import com.jsh.erp.datasource.entities.User;
import com.jsh.erp.datasource.mappers.RoleMapper;
import com.jsh.erp.datasource.mappers.RoleMapperEx;
import com.jsh.erp.exception.JshException;
import com.jsh.erp.utils.PageUtils;
import com.jsh.erp.utils.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class RoleService {
    private Logger logger = LoggerFactory.getLogger(RoleService.class);
    @Resource
    private RoleMapper roleMapper;

    @Resource
    private RoleMapperEx roleMapperEx;
    @Resource
    private LogService logService;
    @Resource
    private UserService userService;

    //超管的专用角色
    private static Long MANAGE_ROLE_ID = 4L;

    public Role getRole(Long id) {
        Role result=null;
        try{
            if (id != null && id > 0) {
                result=roleMapper.selectByPrimaryKey(id);
            }
        }catch(Exception e){
            logger.error("获取角色信息失败: {}", e.getMessage(), e);
        }
        return result;
    }

    public List<Role> getRoleListByIds(String ids) {
        List<Long> idList = StringUtil.strToLongList(ids);
        List<Role> list = new ArrayList<>();
        try{
            RoleExample example = new RoleExample();
            example.createCriteria().andIdIn(idList);
            list = roleMapper.selectByExample(example);
        }catch(Exception e){
            logger.error("根据ID列表获取角色信息失败: {}", e.getMessage(), e);
        }
        return list;
    }

    public List<Role> allList() {
        RoleExample example = new RoleExample();
        example.createCriteria().andEnabledEqualTo(true).andDeleteFlagNotEqualTo(BusinessConstants.DELETE_FLAG_DELETED);
        example.setOrderByClause("sort asc, id desc");
        List<Role> list=new ArrayList<>();
        try{
            list=roleMapper.selectByExample(example);
        }catch(Exception e){
            logger.error("获取所有角色列表失败: {}", e.getMessage(), e);
        }
        return list;
    }

    public List<Role> tenantRoleList() {
        List<Role> list=new ArrayList<>();
        try{
            if(BusinessConstants.DEFAULT_MANAGER.equals(userService.getCurrentUser().getLoginName())) {
                RoleExample example = new RoleExample();
                example.createCriteria().andEnabledEqualTo(true).andTenantIdIsNull().andIdNotEqualTo(MANAGE_ROLE_ID)
                        .andDeleteFlagNotEqualTo(BusinessConstants.DELETE_FLAG_DELETED);
                example.setOrderByClause("sort asc, id asc");
                list=roleMapper.selectByExample(example);
            }
        }catch(Exception e){
            logger.error("获取租户角色列表失败: {}", e.getMessage(), e);
        }
        return list;
    }

    public List<RoleEx> select(String name, String description) {
        List<RoleEx> list=new ArrayList<>();
        try{
            PageUtils.startPage();
            list=roleMapperEx.selectByConditionRole(name, description);
            for(RoleEx roleEx: list) {
                String priceLimit = roleEx.getPriceLimit();
                if(StringUtil.isNotEmpty(priceLimit)) {
                    String priceLimitStr = priceLimit
                        .replace("1", "屏蔽首页采购价")
                        .replace("2", "屏蔽首页零售价")
                        .replace("3", "屏蔽首页销售价")
                        .replace("4", "屏蔽单据采购价")
                        .replace("5", "屏蔽单据零售价")
                        .replace("6", "屏蔽单据销售价");
                    roleEx.setPriceLimitStr(priceLimitStr);
                }
            }
        }catch(Exception e){
            logger.error("查询角色列表失败: {}", e.getMessage(), e);
        }
        return list;
    }

    @Transactional(value = "transactionManager", rollbackFor = Exception.class)
    public int insertRole(JSONObject obj, HttpServletRequest request) {
        Role role = JSONObject.parseObject(obj.toJSONString(), Role.class);
        int result=0;
        try{
            role.setEnabled(true);
            result=roleMapper.insertSelective(role);
            logService.insertLog("角色",
                    new StringBuffer(BusinessConstants.LOG_OPERATION_TYPE_ADD).append(role.getName()).toString(), request);
        }catch(Exception e){
            logger.error("新增角色失败: {}", e.getMessage(), e);
        }
        return result;
    }

    @Transactional(value = "transactionManager", rollbackFor = Exception.class)
    public int updateRole(JSONObject obj, HttpServletRequest request) {
        Role role = JSONObject.parseObject(obj.toJSONString(), Role.class);
        int result=0;
        try{
            result=roleMapper.updateByPrimaryKeySelective(role);
            logService.insertLog("角色",
                    new StringBuffer(BusinessConstants.LOG_OPERATION_TYPE_EDIT).append(role.getName()).toString(), request);
        }catch(Exception e){
            logger.error("修改角色失败: {}", e.getMessage(), e);
        }
        return result;
    }

    @Transactional(value = "transactionManager", rollbackFor = Exception.class)
    public int deleteRole(Long id, HttpServletRequest request) {
        return batchDeleteRoleByIds(id.toString());
    }

    @Transactional(value = "transactionManager", rollbackFor = Exception.class)
    public int batchDeleteRole(String ids, HttpServletRequest request) {
        return batchDeleteRoleByIds(ids);
    }

    public int checkIsNameExist(Long id, String name) {
        RoleExample example = new RoleExample();
        RoleExample.Criteria criteria = example.createCriteria();
        
        // 如果id不为0，添加id不等于条件
        if (id != null && id != 0) {
            criteria.andIdNotEqualTo(id);
        }
        
        criteria.andNameEqualTo(name).andDeleteFlagNotEqualTo(BusinessConstants.DELETE_FLAG_DELETED);
        
        List<Role> list = null;
        try {
            list = roleMapper.selectByExample(example);
        } catch (Exception e) {
            logger.error("检查角色名称是否存在失败: {}", e.getMessage(), e);
        }
        
        return list == null ? 0 : list.size();
    }

    public List<Role> findUserRole() {
        RoleExample example = new RoleExample();
        example.setOrderByClause("Id");
        example.createCriteria().andEnabledEqualTo(true).andDeleteFlagNotEqualTo(BusinessConstants.DELETE_FLAG_DELETED);
        List<Role> list=new ArrayList<>();
        try{
            list=roleMapper.selectByExample(example);
        }catch(Exception e){
            logger.error("查询用户角色失败: {}", e.getMessage(), e);
        }
        return list;
    }
    /**
     * create by: qiankunpingtai
     *  逻辑删除角色信息
     * create time: 2019/3/28 15:44
     * @Param: ids
     * @return int
     */
    @Transactional(value = "transactionManager", rollbackFor = Exception.class)
    public int batchDeleteRoleByIds(String ids) {
        StringBuffer sb = new StringBuffer();
        sb.append(BusinessConstants.LOG_OPERATION_TYPE_DELETE);
        List<Role> list = getRoleListByIds(ids);
        for(Role role: list){
            sb.append("[").append(role.getName()).append("]");
        }
        try {
            logService.insertLog("角色", sb.toString(),
                    ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest());
            User userInfo=userService.getCurrentUser();
            String [] idArray=ids.split(",");
            int result=roleMapperEx.batchDeleteRoleByIds(new Date(),userInfo==null?null:userInfo.getId(),idArray);
            return result;
        } catch (Exception e) {
            logger.error("批量删除角色失败: {}", e.getMessage(), e);
            return 0;
        }
    }

    public Role getRoleWithoutTenant(Long roleId) {
        return roleMapperEx.getRoleWithoutTenant(roleId);
    }

    @Transactional(value = "transactionManager", rollbackFor = Exception.class)
    public int batchSetStatus(Boolean status, String ids) {
        try {
            logService.insertLog("角色",
                    new StringBuffer(BusinessConstants.LOG_OPERATION_TYPE_ENABLED).toString(),
                    ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest());
            List<Long> roleIds = StringUtil.strToLongList(ids);
            Role role = new Role();
            role.setEnabled(status);
            RoleExample example = new RoleExample();
            example.createCriteria().andIdIn(roleIds);
            int result = roleMapper.updateByExampleSelective(role, example);
            return result;
        } catch (Exception e) {
            logger.error("批量设置角色状态失败: {}", e.getMessage(), e);
            return 0;
        }
    }

    /**
     * 根据权限进行屏蔽价格-首页
     * @param price
     * @param type
     * @return
     */
    public Object parseHomePriceByLimit(BigDecimal price, String type, String priceLimit, String emptyInfo, HttpServletRequest request) {
        if(StringUtil.isNotEmpty(priceLimit)) {
            if("buy".equals(type) && priceLimit.contains("1")) {
                return emptyInfo;
            }
            if("retail".equals(type) && priceLimit.contains("2")) {
                return emptyInfo;
            }
            if("sale".equals(type) && priceLimit.contains("3")) {
                return emptyInfo;
            }
        }
        return price;
    }

    /**
     * 根据权限进行屏蔽价格-单据
     * @param price
     * @param billCategory
     * @param priceLimit
     * @param request
     * @return
     * @throws Exception
     */
    public BigDecimal parseBillPriceByLimit(BigDecimal price, String billCategory, String priceLimit, HttpServletRequest request) {
        if(StringUtil.isNotEmpty(priceLimit)) {
            if("buy".equals(billCategory) && priceLimit.contains("4")) {
                return BigDecimal.ZERO;
            }
            if("retail".equals(billCategory) && priceLimit.contains("5")) {
                return BigDecimal.ZERO;
            }
            if("sale".equals(billCategory) && priceLimit.contains("6")) {
                return BigDecimal.ZERO;
            }
        }
        return price;
    }

    /**
     * 根据权限进行屏蔽价格-物料
     * @param price
     * @param type
     * @return
     */
    public Object parseMaterialPriceByLimit(BigDecimal price, String type, String emptyInfo, HttpServletRequest request) {
        try {
            Long userId = userService.getUserId(request);
            String priceLimit = userService.getRoleTypeByUserId(userId).getPriceLimit();
            if(StringUtil.isNotEmpty(priceLimit)) {
                if("buy".equals(type) && priceLimit.contains("4")) {
                    return emptyInfo;
                }
                if("retail".equals(type) && priceLimit.contains("5")) {
                    return emptyInfo;
                }
                if("sale".equals(type) && priceLimit.contains("6")) {
                    return emptyInfo;
                }
            }
        } catch (Exception e) {
            logger.error("解析物料价格失败: {}", e.getMessage(), e);
        }
        return price;
    }

    public String getCurrentPriceLimit(HttpServletRequest request) {
        try {
            Long userId = userService.getUserId(request);
            return userService.getRoleTypeByUserId(userId).getPriceLimit();
        } catch (Exception e) {
            logger.error("获取当前价格限制失败: {}", e.getMessage(), e);
            return "";
        }
    }
}
