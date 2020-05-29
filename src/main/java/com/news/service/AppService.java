package com.news.service;

import com.news.entity.App;
import com.utils.response.ReqResponse;
import org.apache.poi.ss.usermodel.Sheet;

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
    ReqResponse appList(Long currentUserId, String loginName, String nickName, String appId, String appName, Integer appStatus, Integer currentPage, Integer pageSize);

    /**
     * 修改app状态
     */
    ReqResponse appStatus(Long userId, String appId, Integer appStatus);

    /**
     * 创建代码位信息
     */
    ReqResponse createAdspace(Long userId, String appId, int spaceType, String spaceName, int width, int height);

    /**
     * 广告位列表
     */
    ReqResponse appAdspaceList(Long userId, String loginName, String nickName, String appId, String spaceId, int spaceType, Integer currentPage, Integer pageSize);

    /**
     * 添加上游广告位信息
     */
    ReqResponse appAdUpstream(Long userId, String spaceId, String upstreamId, String upstreamAppId, String upstreamPackageName, int upstreamType);

    /**
     * 上游广告位列表
     */
    ReqResponse appUpstreamList(String spaceId);

    /**
     * 上传统计信息
     */
    ReqResponse addAppStatistics(Long userId, int currentUserLevel, String statisticsList)throws Exception;

    /**
     * 查看APP统计列表-管理
     */
    ReqResponse appStatisticsList(String startTime, String endTime, Long userId, String spaceName, String appName, Integer currentPage, Integer pageSize, Integer status);

    /**
     * 查看APP统计列表-用户
     */
    ReqResponse appStatisticsUserList(int userLevel, String startTime, String endTime, Long userId, String spaceName, String appName, Integer currentPage, Integer pageSize);

    /**
     * 多选通过
     */
    ReqResponse examinationPassed(String ids);

    /**
     * 上游列表
     */
    ReqResponse appUpstreamList(Integer currentPage, Integer pageSize);

    /**
     * 全部上游
     */
    ReqResponse allAppUpstreamType();

    /**
     * 修改上游状态
     */
    ReqResponse updateUpstreamStatus(Integer id, Integer status);

    /**
     * 添加新上游
     */
    ReqResponse appUpstreamAdd(Integer type, String name, String shortName);

    /**
     * 上游广告位id列表
     */
    ReqResponse appUpstreamIdList(Integer currentPage, Integer pageSize, Integer type, String upstreamId);

    /**
     * 上游id对应详细信息
     */
    ReqResponse appUpstreamIdMsg(String upstreamId);

    /**
     * 更换上游
     */
    ReqResponse changeUpstream(String upstreamId, String newUpstreamId, String newUpstreamAppId, Integer newUpstreamType, String newUpstreamPackageName);

    /**
     * 删除上游ID
     */
    ReqResponse deleteUpstreamId(String upstreamId);

    /**
     * 设置上游分成比例
     */
    ReqResponse appUpstreamDivided(Integer upstreamType, double upstreamDivided);

    /**
     * 调度分配展示
     */
    ReqResponse selectAppAssign(String spaceId);

    /**
     * 广告位统计
     */
    ReqResponse appReportList(String appId, String slotId, String startTime, String endTime, Integer currentPage, Integer pageSize);
    ReqResponse appUpstreamReport(String downstreamReportId);
    ReqResponse appReportNewList(String startTime, String endTime, String appId, String slotId, Integer currentPage, Integer pageSize);
    ReqResponse appReportDetail(String appId, String slotId, String createTime);
    /**
     * 修改调度数据
     */
    ReqResponse assignSubmit(String list, String spaceId);

    /**
     * 广告位详情
     */
    ReqResponse adspaceDetail(String spaceId);

    /**
     * 广告位divided
     */
    ReqResponse updateSpaceDivided(String spaceId, double dividedY, double dividedZ);

    /**
     * 数据统计状态修改 0删除 1通过
     */
    ReqResponse changeStatus(String statisticsId,int status);

    /**
     * 填补upsteram表assign概率
     */
    ReqResponse assign();

    /**
     * 读取表格数据
     */
    ReqResponse readExcel(Sheet sheet);

    /**
     * 上传统计信息
     */
    ReqResponse addAppStatisticsUC(String statisticsList)throws Exception;


}
