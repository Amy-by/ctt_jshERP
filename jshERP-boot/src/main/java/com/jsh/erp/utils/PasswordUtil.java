package com.jsh.erp.utils;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * 密码工具类
 * 实现BCrypt密码加密和验证
 */
public class PasswordUtil {
    
    private static final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
    
    /**
     * 使用BCrypt加密密码
     * @param rawPassword 原始密码
     * @return 加密后的密码
     */
    public static String encodePassword(String rawPassword) {
        return encoder.encode(rawPassword);
    }
    
    /**
     * 验证密码
     * 支持MD5和BCrypt两种加密方式
     * @param rawPassword 原始密码
     * @param encodedPassword 加密后的密码
     * @return 是否匹配
     */
    public static boolean matchPassword(String rawPassword, String encodedPassword) {
        // 如果是BCrypt加密（以$2a$开头），使用BCrypt验证
        if (encodedPassword.startsWith("$2a$")) {
            return encoder.matches(rawPassword, encodedPassword);
        } else {
            // 否则使用MD5验证（兼容旧密码）
            try {
                return encodedPassword.equals(Tools.md5Encryp(rawPassword));
            } catch (Exception e) {
                return false;
            }
        }
    }
}
