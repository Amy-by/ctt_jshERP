package com.jsh.erp.utils;

import java.util.Date;
import com.jsh.erp.constants.BusinessConstants;

/**
 * 密码策略工具类
 * 用于验证密码是否符合复杂度要求
 */
public class PasswordPolicyUtil {
    
    /**
     * 验证密码是否符合复杂度要求
     * @param password 待验证的密码
     * @return 验证结果，null表示验证通过，否则返回具体的错误信息
     */
    public static String validatePassword(String password) {
        if (password == null || password.isEmpty()) {
            return "密码不能为空";
        }
        
        // 检查密码长度
        if (password.length() < BusinessConstants.PASSWORD_MIN_LENGTH) {
            return "密码长度不能少于" + BusinessConstants.PASSWORD_MIN_LENGTH + "个字符";
        }
        
        // 检查是否包含大写字母
        if (BusinessConstants.PASSWORD_REQUIRE_UPPERCASE && !password.matches(".*[A-Z].*")) {
            return "密码必须包含至少一个大写字母";
        }
        
        // 检查是否包含小写字母
        if (BusinessConstants.PASSWORD_REQUIRE_LOWERCASE && !password.matches(".*[a-z].*")) {
            return "密码必须包含至少一个小写字母";
        }
        
        // 检查是否包含数字
        if (BusinessConstants.PASSWORD_REQUIRE_DIGIT && !password.matches(".*\d.*")) {
            return "密码必须包含至少一个数字";
        }
        
        // 检查是否包含特殊字符
        if (BusinessConstants.PASSWORD_REQUIRE_SPECIAL_CHAR) {
            boolean hasSpecialChar = false;
            for (char c : password.toCharArray()) {
                if (BusinessConstants.PASSWORD_ALLOWED_SPECIAL_CHARS.indexOf(c) != -1) {
                    hasSpecialChar = true;
                    break;
                }
            }
            if (!hasSpecialChar) {
                return "密码必须包含至少一个特殊字符（" + BusinessConstants.PASSWORD_ALLOWED_SPECIAL_CHARS + "）";
            }
        }
        
        return null; // 验证通过
    }
    
    /**
     * 检查密码是否过期
     * @param passwordLastChangedDate 密码最后修改日期
     * @return true表示密码已过期，false表示密码未过期
     */
    public static boolean isPasswordExpired(Date passwordLastChangedDate) {
        if (passwordLastChangedDate == null) {
            return true; // 未设置修改日期，视为已过期
        }
        
        long now = System.currentTimeMillis();
        long lastChanged = passwordLastChangedDate.getTime();
        long diffDays = (now - lastChanged) / (1000 * 60 * 60 * 24);
        
        return diffDays > BusinessConstants.PASSWORD_EXPIRE_DAYS;
    }
    
    /**
     * 检查密码是否即将过期
     * @param passwordLastChangedDate 密码最后修改日期
     * @return true表示密码即将过期，false表示密码不会即将过期
     */
    public static boolean isPasswordAboutToExpire(Date passwordLastChangedDate) {
        if (passwordLastChangedDate == null) {
            return true; // 未设置修改日期，视为即将过期
        }
        
        long now = System.currentTimeMillis();
        long lastChanged = passwordLastChangedDate.getTime();
        long diffDays = (now - lastChanged) / (1000 * 60 * 60 * 24);
        
        return diffDays > (BusinessConstants.PASSWORD_EXPIRE_DAYS - BusinessConstants.PASSWORD_EXPIRE_WARNING_DAYS);
    }
    
    /**
     * 检查登录失败次数是否超过限制
     * @param failedTimes 登录失败次数
     * @return true表示超过限制，false表示未超过限制
     */
    public static boolean isLoginLocked(int failedTimes) {
        return failedTimes >= BusinessConstants.MAX_LOGIN_FAILED_TIMES;
    }
}
