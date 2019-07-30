package com.news.dao;

import com.news.entity.*;
import com.news.vo.AppAdspaceListVo;
import com.news.vo.AppListVo;
import com.news.vo.AppStatisticsListVo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * APP模块
 */
@Repository("appDao")
public interface AppDao {

    /**
     * 查看行业分类大类
     */
    List<Industy> rootType();

    /**
     * 查看行业分类小类
     */
    List<Industy> subType();

    /**
     * 查询此管理下的用户
     */
    List<User> beLongUser(Long userId);

    /**
     * 添加APP信息
     */
    void createApp(App app);

    /**
     * app名称验重
     */
    int appName(String appName);

    /**
     * app列表
     */
    List<AppListVo> appList(Map<String,Object> map);

    /**
     * app列表数量
     */
    int appListNum(Map<String,Object> map);

    /**
     * 查看当前app的上级id
     */
    Long appParent(Long appId);

    /**
     * 修改app状态
     */
    void updateAppStatus(Map<String,Object> map);

    /**
     * 创建广告位信息
     */
    void createAdspace(AppAdspace ad);

    /**
     * 广告位列表
     */
    List<AppAdspaceListVo> appAdspaceList(Map<String,Object> map);

    /**
     * 广告位列表数量
     */
    int appAdspaceListNum(Map<String,Object> map);

    /**
     * 查看广告位所属app的上级id
     */
    Long adParentId(Long spaceId);

    /**
     * 批量添加广告位数据统计信息
     */
    void addAppStatistics(List<AppStatistics> list);

    /**
     * 查看数据统计信息列表
     */
    List<AppStatisticsListVo> appStatisticsList(Map<String,Object> map);

    /**
     * 查看数据统计信息列表数量
     */
    int appStatisticsListNum(Map<String,Object> map);

}
