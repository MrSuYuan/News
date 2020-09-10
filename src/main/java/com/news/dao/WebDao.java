package com.news.dao;

import com.news.entity.*;
import com.news.vo.*;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * WEB模块数据层接口
 */
@Repository("webDao")
public interface WebDao {

    /**
     * 查看web网站名是否可用
     */
    int webName(String webName);

    /**
     * 查看webUrl是否可用
     */
    int webUrl(String webUrl);

    /**
     * 保存web网站信息
     */
    void insertWeb(Web web);

    /**
     * web列表
     */
    List<WebListVo> webList(Map<String,Object> map);

    /**
     * web列表数量
     */
    int webListNum(Map<String,Object> map);

    /**
     * 查看当前web的上级id
     */
    Long webParent(Long webId);

    /**
     * 修改web状态
     */
    void updateWebStatus(Map<String,Object> map);

    /**
     * 创建广告位信息
     */
    void createAdspace(WebAdspace ad);

    /**
     * 创建id使用记录信息
     */
    void insertAdspaceUpstream(WebAdspaceUpstream webAdspaceUpstream);

    /**
     * 查询最新id使用记录信息
     */
    WebAdspaceUpstream selectAdspaceUpstream(int spaceId);

    /**
     * 修改id使用记录信息结束时间
     */
    void updateEndTime(WebAdspaceUpstream wau);

    /**
     * 广告位列表
     */
    List<WebAdSpaceListVo> webAdspaceList(Map<String,Object> map);

    /**
     * 广告位列表数量
     */
    int webAdspaceListNum(Map<String,Object> map);

    /**
     * 查看广告位所属app的上级id
     */
    Long adParentId(int spaceId);

    /**
     * 查询广告位的分成比例
     */
    Map<String,Object> webDivided(int spaceId);

    /**
     * 批量添加广告位数据统计信息
     */
    void addWebStatistics(List<WebStatistics> list);

    /**
     * 查询上游id的使用情况
     */
    List<Integer> upstreamIdStatus(String upstreamId);

    /**
     * 查询上游id是否存在
     */
    int upstreamIdNum(String upstreamId);

    /**
     * 添加新上游id
     */
    void insertUpstream(WebUpstream webUpstream);

    /**
     * 查看数据统计信息列表-用户
     */
    List<WebStatisticsUser> webStatisticsUser(Map<String,Object> map);

    /**
     * 查看数据统计信息列表数量-用户
     */
    int webStatisticsUserNum(Map<String,Object> map);

    /**
     * 查看数据统计信息列表-管理
     */
    List<WebStatisticsManage> webStatisticsManage(Map<String,Object> map);

    /**
     * 查看数据统计信息列表数量-管理
     */
    int webStatisticsManageNum(Map<String,Object> map);

    /**
     * 修改id状态
     */
    void idStatus(Map<String,Object> map);

    /**
     * 通过数据统计
     */
    void updateStatisticsStatus(int statisticsId);

    /**
     * 查询id状态
     */
    int adspaceIdStatus(int statisticsId);

    /**
     * 删除数据统计
     */
    void deleteStatistics(int statisticsId);

    /**
     * 设置广告位divided
     */
    void spaceDivided(Map<String,Object> map);

    /**
     * 上游列表
     */
    List<WebUpstreamType> webUpstreamTypeList(Map<String,Object> map);
    int webUpstreamTypeListNum(Map<String,Object> map);

    /**
     * 设置上游分成比例
     */
    void webUpstreamDivided(Map<String,Object> map);

    /**
     * 查询数据
     */
    WebStatisticsManage webStatisticsOne(int statisticsId);

    /**
     * 修改数据
     */
    void updateStatistics(Map<String,Object> map);

    /**
     * 去数据库匹配数据
     */
    List<WebStatisticsManage> matchId(List<String> upstreamIds);

    /**
     * 查看有没有消息
     */
    Map<String,Object> messageNum();

    /**
     * 查看有没有读
     */
    int unReadMessage(Long userId);

    /**
     * 改为已读
     */
    void readMessage(Map<String,Object> map);

    /**
     * 此id对应的分润比例
     */
    Map<String,Object> divided(String upstreamId);
}
