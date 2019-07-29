package com.news.service;

import com.utils.response.ReqResponse;

/**
 * 报告模块逻辑层接口
 */
public interface AppStatisticsService {

    /**
     * 批量添加报告信息
     */
    ReqResponse addAppStatistics(Long userId, String reportList)throws Exception;

    /**
     * 查看报告列表
     */
    ReqResponse appStatisticsList(Long userId, Long appId, String appName, Integer currentPage, Integer pageSize);

}
