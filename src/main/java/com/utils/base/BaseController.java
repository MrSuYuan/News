package com.utils.base;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 * @ClassName:  BaseController
 * @Description: 所有的Controller必须都继承BaseController
 * @date:   2019年7月10日16:21:01
 */
public class BaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    protected HttpServletRequest request;


    /**
     * 接口请求信息
     */
    @ModelAttribute
    public void init(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        logger.info("------------------------------拦截请求信息【开始】------------------------------");
        logger.info("浏览器信息："+request.getHeader("User-Agent"));
        logger.info("请求url："+request.getServletPath());
        logger.info("请求方式："+request.getMethod());
        Map<String, Object> map = findKeyMapByRequest(request);
        logger.info("请求参数1："+map);
        logger.info("请求参数2："+request.getQueryString());
        String token = request.getHeader("token");
        String sessionId = session.getId();
        logger.info("token："+token);
        logger.info("Session ID："+sessionId);
        logger.info("------------------------------拦截请求信息【结束】------------------------------");

        /**
         * 基础参数检测
         */
        //this.validateBasicParameters();
    }


    /**
     * 把request里面的参数转化成map
     */
    public Map<String, Object> findKeyMapByRequest(HttpServletRequest request) {
        Map<String, Object> keyMap = new HashMap<String, Object>();
        Enumeration<String> enu = request.getParameterNames();
        String[] item ;
        while (enu.hasMoreElements()) {
            String paramname = enu.nextElement();
            item = request.getParameterValues(paramname);
            if(item.length == 1){
                keyMap.put(paramname, item[0]);
            }else{
                keyMap.put(paramname, item);
            }
        }
        return keyMap;
    }

}