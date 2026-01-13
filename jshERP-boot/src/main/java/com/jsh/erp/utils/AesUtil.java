package com.jsh.erp.utils;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

/**
 * AES加密工具类
 * 用于敏感数据的加密和解密
 */
public class AesUtil {
    
    // 默认密钥，实际应用中应从配置文件或环境变量中获取
    private static final String DEFAULT_KEY = "jshERP20260113AB";
    private static final String ALGORITHM = "AES";
    
    /**
     * 生成AES密钥
     * @return 密钥字符串
     * @throws Exception 异常
     */
    public static String generateKey() throws Exception {
        KeyGenerator keyGenerator = KeyGenerator.getInstance(ALGORITHM);
        keyGenerator.init(128);
        SecretKey secretKey = keyGenerator.generateKey();
        return Base64.getEncoder().encodeToString(secretKey.getEncoded());
    }
    
    /**
     * AES加密
     * @param content 待加密内容
     * @return 加密后的字符串
     * @throws Exception 异常
     */
    public static String encrypt(String content) throws Exception {
        return encrypt(content, DEFAULT_KEY);
    }
    
    /**
     * AES加密
     * @param content 待加密内容
     * @param key 密钥
     * @return 加密后的字符串
     * @throws Exception 异常
     */
    public static String encrypt(String content, String key) throws Exception {
        if (content == null || content.isEmpty()) {
            return content;
        }
        
        SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes(), ALGORITHM);
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec);
        byte[] encryptedBytes = cipher.doFinal(content.getBytes());
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }
    
    /**
     * AES解密
     * @param encryptedContent 加密后的内容
     * @return 解密后的字符串
     */
    public static String decrypt(String encryptedContent) {
        return decrypt(encryptedContent, DEFAULT_KEY);
    }
    
    /**
     * AES解密
     * @param encryptedContent 加密后的内容
     * @param key 密钥
     * @return 解密后的字符串
     */
    public static String decrypt(String encryptedContent, String key) {
        if (encryptedContent == null || encryptedContent.isEmpty()) {
            return encryptedContent;
        }
        
        try {
            SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes(), ALGORITHM);
            Cipher cipher = Cipher.getInstance(ALGORITHM);
            cipher.init(Cipher.DECRYPT_MODE, secretKeySpec);
            byte[] encryptedBytes = Base64.getDecoder().decode(encryptedContent);
            byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
            return new String(decryptedBytes);
        } catch (Exception e) {
            // 如果解密失败，可能是因为数据是明文存储的，直接返回原始内容
            return encryptedContent;
        }
    }
}
