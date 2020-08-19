package com.news.dao;

import com.news.entity.*;
import com.news.vo.*;
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
    List<User> allUser();

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
    Long appParent(String appId);

    /**
     * 查看app所属用户id
     */
    Long appUserId(String appId);

    /**
     * 修改app状态
     */
    void updateAppStatus(Map<String,Object> map);

    /**
     * 查看此app是否拥有同类型广告位(app每一种广告位只能有一种)
     */
    int appSpaceNum(AppAdspace ad);

    /**
     * 广告位名称验重
     */
    int spaceNameNum(String spaceName);

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
     * 放/停量
     */
    void updateFlowStatus(Map<String,Object> map);

    /**
     * 查看平台广告位所属app的上级id
     */
    Map<String,Object> adParentId(String spaceId);

    /**
     * 查询此上游广告位id是否存在
     */
    AppUpstream queryUpstream(String upstreamId);

    /**
     * 查询此上游广告位id是否存在
     */
    int upstreamIdNum(String upstreamId);

    /**
     * 查看上游广告位所属app的相关信息
     */
    Map<String,Object> adParent(String upstreamId);

    /**
     * 查看此广告位有没有重复上游类型
     */
    int appUpstreamNum(AppUpstream appUpstream);

    /**
     * 添加上游信息
     */
    void insertAppUpstream(AppUpstream appUpstream);

    /**
     * 修改上游绑定的平台id
     */
    void updateAppUpstream(AppUpstream appUpstream);

    /**
     * 添加上游使用记录
     */
    void insertAppAdspaceUpstream(AppAdspaceUpstream au);

    /**
     * 查看此广告位划量分流次数
     */
    int assignNum(String spaceId);

    /**
     * 广告位上游信息列表
     */
    List<AppUpstream> appUpstreamList(String spaceId);

    /**
     * 批量添加广告位数据统计信息
     */
    void addAppStatistics(List<AppStatistics> list);

    /**
     * 多选审核通过
     */
    void examinationPassed(List<String> ids);

    /**
     * 查看数据统计信息列表
     */
    List<AppStatisticsListVo> appStatisticsList(Map<String,Object> map);

    /**
     * 查看数据统计信息列表数量
     */
    int appStatisticsListNum(Map<String,Object> map);

    /**
     * 查看数据统计信息列表
     */
    List<AppStatisticsListVo> appStatisticsUserList(Map<String,Object> map);

    /**
     * 查看数据统计信息列表数量
     */
    int appStatisticsUserListNum(Map<String,Object> map);

    /**
     * 调度分配展示
     */
    List<AppAssign> selectAppAssign(String spaceId);

    /**
     * 正式服概率修改
     */
    void updateAssignZ(List<AppUpstream> list);

    /**
     * 查看上游列表
     */
    List<AppUpstreamType> appUpstreamTypeList(Map<String,Object> map);
    int appUpstreamTypeNum(Map<String,Object> map);

    /**
     * 修改上游状态
     */
    void updateUpstreamStatus(Map<String,Object> map);

    /**
     * 添加新上游
     */
    void appUpstreamAdd(AppUpstreamType aut);

    /**
     * 上游广告位
     */
    List<AppUpstreamIdList> appUpstreamIdList(Map<String,Object> map);
    int appUpstreamIdListNum(Map<String,Object> map);

    /**
     * 上游id对应详情
     */
    AppUpstreamIdList AppUpstreamIdMsg(String upstreamId);

    /**
     * 此id对应的分润比例
     */
    Map<String,Object> divided(String upstreamId);

    /**
     * 更换上游
     */
    Map<String,Object> check(String upstreamId);
    void updateUpstream(Map<String,Object> map);


    /**
     * 删除上游ID
     */
    AppUpstream appUpstream(String upstreamId);
    void deleteUpstream(String upstreamId);
    void updateEndTime(AppAdspaceUpstream au);

    /**
     * 设置上游分成比例
     */
    void appUpstreamDivided(Map<String,Object> map);

    /**
     * 广告位详情
     */
    Map<String,Object> adspaceDetail(String spaceId);

    /**
     * 设置广告位divided
     */
    void updateSpaceDivided(Map<String,Object> map);

    /**
     * 改变统计数据
     */
    void changeStatus(String statisticsId);

    /**
     * 删除统计数据
     */
    void deleteStatistics(String statisticsId);

    /**
     * 修改a_upstream表assign概率数据
     */
    void upstreamAssign(List<AppAssign> list);

    /**
     * 查询excel数据库对应数据
     */
    List<UCStatisticsList> queryExcel(List upstreamId);

    /**
     * 新Excel
     */
    List<UCStatisticsList> matchId(List upstreamId);
}
