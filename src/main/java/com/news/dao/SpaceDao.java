package com.news.dao;

import com.news.vo.AppAdspaceListVo;
import com.news.vo.ChannelStatisticsListVo;
import com.news.vo.ChannelStatisticsSumListVo;
import com.news.vo.PlatformStatisticsListVo;
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

}
