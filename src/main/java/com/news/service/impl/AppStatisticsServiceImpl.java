package com.news.service.impl;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.news.dao.AppDao;
import com.news.dao.AppStatisticsDao;
import com.news.dao.UserDao;
import com.news.entity.AppStatistics;
import com.news.service.AppStatisticsService;
import com.news.vo.AppStatisticsListVo;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;
/**
 * 报告模块逻辑层实现
 */
@Service("reportService")
public class AppStatisticsServiceImpl implements AppStatisticsService {

    @Resource
    private AppStatisticsDao reportDao;

    @Resource
    private AppDao appDao;

    @Resource
    private UserDao userDao;

    /**
     * 批量添加报告信息
     */
    @Override
    public ReqResponse addAppStatistics(Long userId, String reportList) throws Exception {
        ReqResponse req = new ReqResponse();
        if(null != reportList && !"".equals(reportList)){
            //解析前端传过来的集合数据
            ObjectMapper mapper = new ObjectMapper();
            JavaType jt = mapper.getTypeFactory().constructParametricType(ArrayList.class, AppStatistics.class);
            List<AppStatistics> list =  mapper.readValue(reportList, jt);
            Long appId = list.get(0).getAppId();

            //查看当前app的上级id
            Long parentId = appDao.appParent(appId);
            if(userId.longValue() == parentId.longValue()){
                reportDao.addReport(list);
                req.setCode(ErrorMessage.SUCCESS.getCode());
                req.setMessage("添加成功");
            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您无权操作此APP");
            }
        }else{
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("参数错误");
        }
        return req;
    }

    /**
     * 查看报告列表
     */
    @Override
    public ReqResponse appStatisticsList(Long userId, Long appId, String appName, Integer currentPage, Integer pageSize) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        //页码格式化
        if(null == currentPage){
            currentPage = 1;
        }
        if(null == pageSize){
            pageSize = 20;
        }
        map.put("num",(currentPage - 1) * pageSize);
        map.put("pageSize",pageSize);
        map.put("appId",appId);
        map.put("appName",appName);
        map.put("parentId",userId);
        //先查询当前用户身份
        int currentUserLevel = userDao.userLevel(userId);
        map.put("currentUserLevel",currentUserLevel);

        //查询集合列表
        List<AppStatisticsListVo> reportList = reportDao.reportList(map);
        //总数量
        int sumData = reportDao.reportListNum(map);
        //总页数
        int sumPage = 0;
        if(sumData%Integer.valueOf(pageSize) == 0){
            sumPage = (sumData/Integer.valueOf(pageSize));
        }else{
            sumPage = (sumData/Integer.valueOf(pageSize)) + 1;
        }

        Map<String,Object> result = new HashMap<>();
        result.put("reportList",reportList);
        result.put("currentPage",currentPage);
        result.put("pageSize",pageSize);
        result.put("sumPage",sumPage);
        result.put("sumData",sumData);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("数据加载完成");
        req.setResult(result);
        return req;
    }
}
