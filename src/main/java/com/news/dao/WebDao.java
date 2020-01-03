package com.news.dao;

import com.news.entity.*;
import com.news.vo.AppListVo;
import com.news.vo.WebAdSpaceListVo;
import com.news.vo.WebListVo;
import com.news.vo.WebStatisticsListVo;
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
    Long adParentId(String spaceId);

    /**
     * 批量添加广告位数据统计信息
     */
    void addWebStatistics(List<WebStatistics> list);

    /**
     * 查看数据统计信息列表
     */
    List<WebStatisticsListVo> webStatisticsList(Map<String,Object> map);

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
     * 查看数据统计信息列表数量
     */
    int webStatisticsListNum(Map<String,Object> map);

    /**
     * 修改id状态
     */
    void idStatus(Map<String,Object> map);

}
