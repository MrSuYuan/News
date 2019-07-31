package com.news.service.impl;

import com.news.dao.UserDao;
import com.news.dao.WebDao;
import com.news.entity.Web;
import com.news.service.WebService;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * WEB模块逻辑层实现
 */
@Service("webService")
public class WebServiceImpl implements WebService {

    @Resource
    private WebDao webDao;

    @Resource
    private UserDao userDao;

    /**
     * 新加web网站信息
     */
    @Override
    public ReqResponse createWeb(Long currentUserId, int currentUserLevel, Web web) {
        ReqResponse req = new ReqResponse();
        //查看web用户名是否可用
        int webName = webDao.webName(web.getWebName());
        if(webName > 0){
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("此网站名称已经存在");
            return req;
        }
        //查看webUrl是否可用
        int webUrl = webDao.webUrl(web.getWebUrl());
        if(webUrl > 0){
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("此网址已经存在");
            return req;
        }

        //个人填写信息
        if(currentUserLevel == 3){
            webDao.insertWeb(web);
            req.setCode(ErrorMessage.SUCCESS.getCode());
            req.setMessage("添加成功");
        //管理员为下级填写app信息
        }else{
            //查看登录用户和web所属用户关系
            Map<String,Object> map = new HashMap<>();
            map.put("currentUserId",currentUserId);
            map.put("userId",web.getUserId());
            int count = userDao.userAndParent(map);
            if(count == 0){
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您没有操作权限");
            }else{
                webDao.insertWeb(web);
                req.setCode(ErrorMessage.SUCCESS.getCode());
                req.setMessage("添加成功");
            }
        }
        return req;
    }
}
