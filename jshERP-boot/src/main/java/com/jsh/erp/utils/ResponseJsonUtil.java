package com.jsh.erp.utils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;

public class ResponseJsonUtil {
    public static final SimpleDateFormat FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    static {
        FORMAT.setTimeZone(TimeZone.getTimeZone("GMT+8"));
    }

    /**
     * 成功的json串
     * @param code
     * @param data
     * @return
     */
    public static String backJson(int code, Object data) {
        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("code", code);
        responseMap.put("data", data);
        return JSON.toJSONString(responseMap,
                SerializerFeature.DisableCircularReferenceDetect,
                SerializerFeature.WriteNonStringKeyAsString);
    }

    public static String returnJson(Map<String, Object> map, String message, int code) {
        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("code", code);
        responseMap.put("data", map);
        responseMap.put("message", message);
        return JSON.toJSONString(responseMap,
                SerializerFeature.DisableCircularReferenceDetect,
                SerializerFeature.WriteNonStringKeyAsString);
    }

    public static String returnStr(Map<String, Object> objectMap, int res) {
        if(res > 0) {
            return returnJson(objectMap, ErpInfo.OK.name, ErpInfo.OK.code);
        } else if(res == -1) {
            return returnJson(objectMap, ErpInfo.TEST_USER.name, ErpInfo.TEST_USER.code);
        } else {
            return returnJson(objectMap, ErpInfo.ERROR.name, ErpInfo.ERROR.code);
        }
    }
}
