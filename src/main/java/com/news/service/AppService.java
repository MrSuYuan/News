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
    ReqResponse appList(Long userId, Long appId, String appName, Integer appStatus, Integer currentPage, Integer pageSize);

    /**
     * 修改app状态
     */
    ReqResponse appStatus(Long userId, Long appId, Integer appStatus);

    /**
     * 创建代码位信息
     */
    ReqResponse createAdspace(Long userId, Long appId, int spaceType, String spaceName, int width, int height);

    /**
     * 广告位列表
     */
    ReqResponse appAdspaceList(Long userId, String appName, String spaceName, int spaceType, Integer currentPage, Integer pageSize);

    /**
     * 上传统计信息
     */
    ReqResponse addAppStatistics(Long userId, String reportList)throws Exception;

    /**
     * 查看APP统计列表
     */
    ReqResponse appStatisticsList(Long userId, String spaceName, String appName, Integer currentPage, Integer pageSize);

}
