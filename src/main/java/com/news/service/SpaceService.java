package com.news.service;

import com.utils.response.ReqResponse;

/**
 * 广告位逻辑层
 */
public interface SpaceService {

    /**
     * 查看广告位基本信息
     */
    ReqResponse spaceMsg(String spaceId);

    /**
     * 平台统计
     */
    ReqResponse platformStatistics(String spaceId, String date);

    /**
     * 渠道统计
     */
    ReqResponse channelStatistics(String spaceId, String date);

    /**
     * 上报统计列表
     */
    ReqResponse appReportList(String appId, String slotId, String startTime, String endTime, Integer currentPage, Integer pageSize);

    /**
     * 上报统计详情(展开)
     */
    ReqResponse appUpstreamReport(String createTime, String slotId);


}
