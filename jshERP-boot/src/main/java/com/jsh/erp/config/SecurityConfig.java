package com.jsh.erp.config;

import com.jsh.erp.filter.SecurityHeaderFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 安全配置类
 * 添加安全头信息，如X-Frame-Options、Content-Security-Policy等
 * 添加CORS配置
 */
@Configuration
public class SecurityConfig implements WebMvcConfigurer {
    
    /**
     * 添加CORS过滤器
     * @return CorsFilter
     */
    @Bean
    public CorsFilter corsFilter() {
        CorsConfiguration config = new CorsConfiguration();
        
        // 允许的来源（根据实际情况修改）
        config.addAllowedOrigin("http://localhost:3000");
        config.addAllowedOrigin("http://localhost:3002");
        config.addAllowedOrigin("http://192.168.1.7:3000");
        config.addAllowedOrigin("http://192.168.1.7:3002");
        
        // 允许的HTTP方法
        config.addAllowedMethod("GET");
        config.addAllowedMethod("POST");
        config.addAllowedMethod("PUT");
        config.addAllowedMethod("DELETE");
        config.addAllowedMethod("OPTIONS");
        
        // 允许的头部
        config.addAllowedHeader("*");
        
        // 允许携带凭证
        config.setAllowCredentials(true);
        
        // 暴露的头部
        config.addExposedHeader("Authorization");
        config.addExposedHeader("X-Total-Count");
        config.addExposedHeader("X-Requested-With");
        
        // 预检请求的缓存时间（秒）
        config.setMaxAge(3600L);
        
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);
        
        return new CorsFilter(source);
    }
    
    /**
     * 注册安全头过滤器
     * @return FilterRegistrationBean
     */
    @Bean
    public FilterRegistrationBean<SecurityHeaderFilter> securityHeaderFilter() {
        FilterRegistrationBean<SecurityHeaderFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new SecurityHeaderFilter());
        registrationBean.addUrlPatterns("/*");
        registrationBean.setOrder(1);
        return registrationBean;
    }
}
