package com.news.service;

import com.news.entity.Web;
import com.utils.response.ReqResponse;
import org.apache.poi.ss.usermodel.Sheet;

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
    ReqResponse createAdspace(Long userId, Long webId, int terminal, String spaceName, int spaceType, String remark, int width, int height, String upstreamId, int upstreamType);

    /**
     * 广告位列表
     */
    ReqResponse webAdspaceList(Long userId, String webName, String spaceName, int terminal, int spaceType, Integer currentPage, Integer pageSize);

    /**
     * 上传统计信息
     */
    ReqResponse addWebStatistics(Long userId, String statisticsList)throws Exception;

    /**
     * 查看WEB统计列表-manage
     */
    ReqResponse webStatisticsManage(String startTime, String endTime, Long userId, String spaceName, String appName, Integer currentPage, Integer pageSize);

    /**
     * 查看WEB统计列表-user
     */
    ReqResponse webStatisticsUser(String startTime, String endTime, Long userId, String spaceName, String appName, Integer currentPage, Integer pageSize);

    /**
     * 修改id状态
     */
    ReqResponse idStatus(int spaceId, int status);

    /**
     * 通过/删除数据
     */
    ReqResponse webStatisticsStatus(int statisticsId, int status);

    /**
     * 广告位divided
     */
    ReqResponse spaceDivided(int spaceId, double dividedY, double dividedZ);

    /**
     * 上游列表
     */
    ReqResponse webUpstreamTypeList(Integer currentPage, Integer pageSize);

    /**
     * 设置上游分成比例
     */
    ReqResponse webUpstreamDivided(Integer upstreamType, double upstreamDivided);

    /**
     * 查询数据
     */
    ReqResponse webStatisticsOne(int statisticsId);

    /**
     * 修改数据
     */
    ReqResponse updateStatistics(double dividedY, double dividedZ, Integer lookPV, Integer clickNum, double income, double clickProbability,
                                 double ecmp, Integer spaceId, Integer statisticsId);

    /**
     * 百度Excel
     */
    ReqResponse baiDuExcel(Sheet sheetAt);

    /**
     * 消息
     */
    ReqResponse message(Long userId);

    /**
     * 上游id对应详细信息
     */
    ReqResponse webUpstreamIdMsg(String upstreamId);
}
