package com.jsh.erp.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 测试控制器
 * 提供测试CORS的端点
 */
@RestController
@RequestMapping("/test")
public class TestController {
    
    /**
     * 测试CORS的端点
     * @return 测试响应
     */
    @GetMapping("/cors")
    public String testCors() {
        return "Hello, CORS is working!";
    }
}