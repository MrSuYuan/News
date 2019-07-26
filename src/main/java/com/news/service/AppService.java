package com.news.service;

import com.news.entity.App;
import com.utils.response.ReqResponse;

/**
 * APP模块
 */
public interface AppService {

    /**
     * 查看行业分类
     */
    ReqResponse industy();

    /**
     * 查看归属用户
     */
    ReqResponse beLongUser(Long userId);

    /**
     * 创建APP信息
     */
    ReqResponse createApp(Long currentUserId, Integer currentUserLevel, App app);

    /**
     * APP列表
     */
    ReqResponse appList(Long userId, String appId, String appName, Integer auditStatus, Integer appStatus, Integer currentPage, Integer pageSize);

}
