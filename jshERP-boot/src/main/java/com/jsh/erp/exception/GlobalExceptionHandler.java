package com.jsh.erp.exception;

import com.alibaba.fastjson.JSONObject;
import com.jsh.erp.constants.ExceptionConstants;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import javax.servlet.http.HttpServletRequest;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(value = Exception.class)
    @ResponseBody
    public Object handleException(Exception e, HttpServletRequest request) {
        JSONObject status = new JSONObject();
        
        // 获取请求详细信息
        String requestUrl = request.getRequestURL().toString();
        String method = request.getMethod();
        String queryString = request.getQueryString();
        String clientIp = request.getRemoteAddr();
        
        // 记录请求参数
        JSONObject requestInfo = new JSONObject();
        requestInfo.put("url", requestUrl);
        requestInfo.put("method", method);
        requestInfo.put("queryString", queryString);
        requestInfo.put("clientIp", clientIp);
        
        // 针对业务参数异常的处理
        if (e instanceof BusinessParamCheckingException) {
            BusinessParamCheckingException be = (BusinessParamCheckingException) e;
            status.put(ExceptionConstants.GLOBAL_RETURNS_CODE, be.getCode());
            status.put(ExceptionConstants.GLOBAL_RETURNS_DATA, be.getData());
            
            // 记录业务参数异常日志
            log.error("Business Param Exception Occured => requestInfo: {}, code: {}, message: {}", 
                    requestInfo, be.getCode(), be.getMessage(), e);
            return status;
        }

        //针对业务运行时异常的处理
        if (e instanceof BusinessRunTimeException) {
            BusinessRunTimeException be = (BusinessRunTimeException) e;
            status.put(ExceptionConstants.GLOBAL_RETURNS_CODE, be.getCode());
            status.put(ExceptionConstants.GLOBAL_RETURNS_DATA, be.getData());
            
            // 记录业务运行时异常日志
            log.error("Business Runtime Exception Occured => requestInfo: {}, code: {}, message: {}", 
                    requestInfo, be.getCode(), be.getMessage(), e);
            return status;
        }

        status.put(ExceptionConstants.GLOBAL_RETURNS_CODE, ExceptionConstants.SERVICE_SYSTEM_ERROR_CODE);
        status.put(ExceptionConstants.GLOBAL_RETURNS_DATA, ExceptionConstants.SERVICE_SYSTEM_ERROR_MSG);
        
        // 记录系统异常详细日志
        log.error("Global System Exception Occured => requestInfo: {}, message: {}", 
                requestInfo, e.getMessage());
        log.error("Global System Exception Occured => requestInfo: {}", requestInfo, e);
        
        // 这里可以添加异常告警机制，例如发送邮件、短信等
        // TODO: 实现异常告警机制
        
        return status;
    }
}