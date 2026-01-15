package com.jsh.erp.exception;

import com.alibaba.fastjson.JSONObject;
import com.jsh.erp.constants.ExceptionConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import javax.servlet.http.HttpServletRequest;

@RestControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(value = BusinessParamCheckingException.class)
    @ResponseBody
    public Object handleBusinessParamCheckingException(BusinessParamCheckingException be, HttpServletRequest request) {
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
        status.put(ExceptionConstants.GLOBAL_RETURNS_CODE, be.getCode());
        status.put(ExceptionConstants.GLOBAL_RETURNS_DATA, be.getData());
        
        // 记录业务参数异常日志
        log.error("Business Param Exception Occured => requestInfo: {}, code: {}, message: {}", 
                requestInfo, be.getCode(), be.getMessage(), be);
        return status;
    }
    
    @ExceptionHandler(value = BusinessRunTimeException.class)
    @ResponseBody
    public Object handleBusinessRunTimeException(BusinessRunTimeException be, HttpServletRequest request) {
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
        
        //针对业务运行时异常的处理
        status.put(ExceptionConstants.GLOBAL_RETURNS_CODE, be.getCode());
        status.put(ExceptionConstants.GLOBAL_RETURNS_DATA, be.getData());
        
        // 记录业务运行时异常日志
        log.error("Business Runtime Exception Occured => requestInfo: {}, code: {}, message: {}", 
                requestInfo, be.getCode(), be.getMessage(), be);
        return status;
    }
    
    @ExceptionHandler(value = MethodArgumentTypeMismatchException.class)
    @ResponseBody
    public Object handleMethodArgumentTypeMismatchException(MethodArgumentTypeMismatchException me, HttpServletRequest request) {
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
        
        // 针对参数类型不匹配异常的处理（例如：将字符串ID转换为Long类型失败时）
        status.put(ExceptionConstants.GLOBAL_RETURNS_CODE, 400);
        status.put(ExceptionConstants.GLOBAL_RETURNS_DATA, "无效的参数类型");
        
        // 记录参数类型不匹配异常日志
        log.error("Method Argument Type Mismatch Exception Occured => requestInfo: {}, parameter: {}, expected type: {}, actual value: {}", 
                requestInfo, me.getName(), me.getRequiredType().getSimpleName(), me.getValue(), me);
        return status;
    }
    
    @ExceptionHandler(value = MissingServletRequestParameterException.class)
    @ResponseBody
    public Object handleMissingServletRequestParameterException(MissingServletRequestParameterException me, HttpServletRequest request) {
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
        
        // 针对缺少请求参数异常的处理
        status.put(ExceptionConstants.GLOBAL_RETURNS_CODE, 400);
        status.put(ExceptionConstants.GLOBAL_RETURNS_DATA, me.getParameterName() + "参数不能为空");
        
        // 记录缺少请求参数异常日志
        log.error("Missing Servlet Request Parameter Exception Occured => requestInfo: {}, parameter: {}", 
                requestInfo, me.getParameterName(), me);
        return status;
    }
    
    @ExceptionHandler(value = MethodArgumentNotValidException.class)
    @ResponseBody
    public Object handleMethodArgumentNotValidException(MethodArgumentNotValidException me, HttpServletRequest request) {
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
        
        // 针对参数验证异常的处理
        status.put(ExceptionConstants.GLOBAL_RETURNS_CODE, 400);
        status.put(ExceptionConstants.GLOBAL_RETURNS_DATA, "参数验证失败");
        
        // 记录参数验证异常日志
        log.error("Method Argument Not Valid Exception Occured => requestInfo: {}, errors: {}", 
                requestInfo, me.getBindingResult().getAllErrors(), me);
        return status;
    }
    
    @ExceptionHandler(value = RuntimeException.class)
    @ResponseBody
    public Object handleRuntimeException(RuntimeException e, HttpServletRequest request) {
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
        
        // 针对运行时异常的处理
        status.put(ExceptionConstants.GLOBAL_RETURNS_CODE, 500);
        status.put(ExceptionConstants.GLOBAL_RETURNS_DATA, "未知异常");
        
        // 记录运行时异常日志
        log.error("Runtime Exception Occured => requestInfo: {}, message: {}", 
                requestInfo, e.getMessage(), e);
        return status;
    }
}