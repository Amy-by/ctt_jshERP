package com.jsh.erp.config;

import org.apache.catalina.Context;
import org.apache.catalina.connector.Connector;
import org.apache.tomcat.util.descriptor.web.SecurityCollection;
import org.apache.tomcat.util.descriptor.web.SecurityConstraint;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.servlet.server.ServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * HTTPS配置类
 * 配置HTTP到HTTPS的重定向
 */
@Configuration
public class HttpsConfig {

    /**
     * 配置Tomcat，添加HTTP连接器并设置重定向到HTTPS
     * @return ServletWebServerFactory
     */
    @Bean
    public ServletWebServerFactory servletContainer() {
        TomcatServletWebServerFactory tomcat = new TomcatServletWebServerFactory() {
            @Override
            protected void postProcessContext(Context context) {
                SecurityConstraint securityConstraint = new SecurityConstraint();
                securityConstraint.setUserConstraint("CONFIDENTIAL");
                SecurityCollection collection = new SecurityCollection();
                collection.addPattern("/*");
                securityConstraint.addCollection(collection);
                context.addConstraint(securityConstraint);
            }
        };
        
        // 添加HTTP连接器，端口8080
        tomcat.addAdditionalTomcatConnectors(httpConnector());
        
        return tomcat;
    }
    
    /**
     * 创建HTTP连接器
     * @return Connector
     */
    private Connector httpConnector() {
        Connector connector = new Connector(TomcatServletWebServerFactory.DEFAULT_PROTOCOL);
        connector.setScheme("http");
        // HTTP端口
        connector.setPort(8080);
        // HTTPS端口
        connector.setSecure(false);
        // 将HTTP请求重定向到HTTPS
        connector.setRedirectPort(8443);
        
        return connector;
    }
}