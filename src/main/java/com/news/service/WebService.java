package com.news.service;

import com.news.entity.Web;
import com.utils.response.ReqResponse;

/**
 * WEB模块逻辑层接口
 */
public interface WebService {

    /**
     * 新加web网站信息
     */
    ReqResponse createWeb(Long currentUserId, int currentUserLevel, Web web);

    /**
     * WEB列表
     */
    ReqResponse webList(Long userId, Long webId, String webName, Integer webStatus, Integer currentPage, Integer pageSize);

    /**
     * 修改web状态
     */
    ReqResponse webStatus(Long userId, Long webId, Integer webStatus);

    /**
     * 创建代码位信息
     */
    ReqResponse createAdspace(Long userId, Long webId, int terminal, String spaceName, int spaceType, String remark, int width, int height);

    /**
     * 广告位列表
     */
    ReqResponse webAdspaceList(Long userId, String webName, String spaceName, int terminal, int spaceType, Integer currentPage, Integer pageSize);

    /**
     * 上传统计信息
     */
    ReqResponse addWebStatistics(Long userId, String statisticsList)throws Exception;

    /**
     * 查看WEB统计列表
     */
    ReqResponse webStatisticsList(Long userId, String spaceName, String appName, Integer currentPage, Integer pageSize);

}
