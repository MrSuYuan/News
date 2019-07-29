package com.news.dao;

import com.news.entity.AppStatistics;
import com.news.vo.AppStatisticsListVo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 报告模块
 */
@Repository("reportDao")
public interface AppStatisticsDao {

    /**
     * 批量添加报告
     */
    void addReport(List<AppStatistics> list);

    /**
     * 查看报告列表
     */
    List<AppStatisticsListVo> reportList(Map<String,Object> map);

    /**
     * 查看报告列表数量
     */
    int reportListNum(Map<String,Object> map);
}
