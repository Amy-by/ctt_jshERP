package com.jsh.erp.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 安全头过滤器
 * 添加安全头信息，如X-Frame-Options、Content-Security-Policy等
 */
public class SecurityHeaderFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 初始化
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // 添加X-Frame-Options头，防止点击劫持
        httpResponse.setHeader("X-Frame-Options", "SAMEORIGIN");
        
        // 添加X-XSS-Protection头，防止XSS攻击
        httpResponse.setHeader("X-XSS-Protection", "1; mode=block");
        
        // 添加X-Content-Type-Options头，防止MIME类型嗅探
        httpResponse.setHeader("X-Content-Type-Options", "nosniff");
        
        // 添加Content-Security-Policy头，限制资源加载
        httpResponse.setHeader("Content-Security-Policy", 
                "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; img-src 'self' data:;");
        
        // 添加Strict-Transport-Security头，强制HTTPS
        httpResponse.setHeader("Strict-Transport-Security", "max-age=31536000; includeSubDomains");
        
        // 继续执行过滤器链
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // 销毁
    }
}
