package com.news.service.impl;

import com.news.dao.AppDao;
import com.news.dao.UserDao;
import com.news.entity.App;
import com.news.entity.Industy;
import com.news.entity.User;
import com.news.service.AppService;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * APP模块
 */
@Service("appService")
public class AppServiceImpl implements AppService {

    @Resource
    private UserDao userDao;

    @Resource
    private AppDao appDao;

    /**
     * 行业分类
     */
    @Override
    public ReqResponse industy() {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        //大类
        List<Industy> rootType = appDao.rootType();
        //小类
        List<Industy> subType = appDao.subType();
        map.put("rootType",rootType);
        map.put("subType",subType);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("分类加载完成");
        req.setResult(map);
        return req;
    }

    /**
     * 查看归属用户
     */
    @Override
    public ReqResponse beLongUser(Long userId) {
        ReqResponse req = new ReqResponse();
        List<User> userList = appDao.beLongUser(userId);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("数据加载完成");
        req.setResult(userList);
        return req;
    }

    /**
     * 创建APP信息
     */
    @Override
    public ReqResponse createApp(Long currentUserId, Integer currentUserLevel, App app) {
        ReqResponse req = new ReqResponse();
        //查看app用户名是否可用
        int appName = appDao.appName(app.getAppName());
        if(appName > 0){
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("此APP名称已经存在");
            return req;
        }
        //封装剩余信息
        SimpleDateFormat sdf = new SimpleDateFormat("MMddHHmm");
        app.setAppId(sdf.format(new Date()) +""+ app.getUserId());
        app.setAccessMethod(1);
        //个人填写app信息
        if(currentUserLevel == 3){
            appDao.createApp(app);
            req.setCode(ErrorMessage.SUCCESS.getCode());
            req.setMessage("添加成功");
        //管理员为下级填写app信息
        }else{
            //查看登录用户和app所属用户关系
            Map<String,Object> map = new HashMap<>();
            map.put("currentUserId",currentUserId);
            map.put("userId",app.getUserId());
            int count = userDao.userAndParent(map);
            if(count == 0){
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您没有操作权限");
            }else{
                appDao.createApp(app);
                req.setCode(ErrorMessage.SUCCESS.getCode());
                req.setMessage("添加成功");
            }
        }
        return req;
    }

    /**
     * APP列表
     */
    @Override
    public ReqResponse appList(Long userId, String appId, String appName, Integer auditStatus, Integer appStatus, Integer currentPage, Integer pageSize) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        List<App> appList = appDao.appList(map);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        map.put("appList",appList);
        req.setResult(map);
        return req;
    }
}
