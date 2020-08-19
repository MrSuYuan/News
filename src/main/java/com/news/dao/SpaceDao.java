package com.news.dao;

import com.news.vo.*;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Map;

/**
 * 广告位模块
 */
@Repository("spaceDao")
public interface SpaceDao {

    /**
     * 广告位基本信息
     */
    AppAdspaceListVo spaceMsg(String spaceId);

    /**
     * 平台分时统计查询
     */
    List<PlatformStatisticsListVo> platformStatisticsList(Map<String,Object> map);

    /**
     * 渠道分时统计-求和
     */
    List<ChannelStatisticsSumListVo> ChannelStatisticsSumList(Map<String,Object> map);

    /**
     * 渠道分时统计-详细列表
     */
    List<ChannelStatisticsListVo> ChannelStatisticsList(Map<String,Object> map);

    /**
     * 广告位统计
     */
    List<AdStatisticsListVo> appReportList(Map<String,Object> map);
    int appReportListNum(Map<String,Object> map);
    List<AdReportUpstreamListVo> appUpstreamReport(Map<String,Object> map);


}
