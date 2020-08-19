package com.news.service.impl;

import com.news.dao.SpaceDao;
import com.news.service.SpaceService;
import com.news.vo.*;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 广告位业务实现
 */
@Service("spaceService")
public class SpaceServiceImpl implements SpaceService {

    @Resource
    private SpaceDao spaceDao;

    /**
     * 广告位基本信息
     */
    @Override
    public ReqResponse spaceMsg(String spaceId) {
        ReqResponse req = new ReqResponse();
        AppAdspaceListVo space = spaceDao.spaceMsg(spaceId);
        req.setResult(space);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        return req;
    }

    /**
     * 平台统计
     */
    @Override
    public ReqResponse platformStatistics(String spaceId, String date) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        if (null == date || "".equals(date)){
            Date d = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            map.put("createTime",sdf.format(d));
        }else{
            map.put("createTime",date);
        }
        map.put("slotId",spaceId);
        //总请求
        int sumRequest = 0;
        //总返回
        int sumResponse = 0;
        //总曝光
        int sumLook = 0;
        //总点击
        int sumClick = 0;
        //总deepLink
        int sumDeeplink = 0;
        int t300 = 0;
        int t400 = 0;
        int t500 = 0;
        int t1000 = 0;
        List<PlatformStatisticsListVo> list = spaceDao.platformStatisticsList(map);
        for (PlatformStatisticsListVo vo : list){
            sumRequest = sumRequest + vo.getDownstreamRequest();
            sumResponse = sumResponse + vo.getResponse();
            sumLook = sumLook + vo.getLook();
            sumClick = sumClick + vo.getClick();
            sumDeeplink = sumDeeplink + vo.getDeeplink();
            t300 = t300 + vo.getT300();
            t400 = t400 + vo.getT400();
            t500 = t500 + vo.getT500();
            t1000 = t1000 + vo.getT1000();
        }
        PlatformStatisticsVo psv = new PlatformStatisticsVo();
        psv.setSumRequest(sumRequest);
        psv.setSumResponse(sumResponse);
        psv.setSumClick(sumClick);
        psv.setSumLook(sumLook);
        psv.setSumDeeplink(sumDeeplink);
        psv.setT300(t300);
        psv.setT400(t400);
        psv.setT500(t500);
        psv.setT1000(t1000);
        psv.setList(list);
        req.setResult(psv);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        return req;
    }

    /**
     * 渠道统计
     */
    @Override
    public ReqResponse channelStatistics(String spaceId, String date) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        if (null == date || "".equals(date)){
            Date d = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            map.put("createTime",sdf.format(d));
        }else{
            map.put("createTime",date);
        }
        map.put("slotId",spaceId);
        //和
        List<ChannelStatisticsSumListVo> sumList = spaceDao.ChannelStatisticsSumList(map);
        //详细
        List<ChannelStatisticsListVo> list = spaceDao.ChannelStatisticsList(map);
        for (ChannelStatisticsSumListVo cssv : sumList){
            List<ChannelStatisticsListVo> sList = new ArrayList<>();
            for (ChannelStatisticsListVo cslv : list){
                if (cslv.getUpstreamId().equals(cssv.getUpstreamId())){
                    sList.add(cslv);
                }
            }
            cssv.setList(sList);
        }
        req.setResult(sumList);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        return req;
    }


    /**
     * 上报统计列表
     */
    @Override
    public ReqResponse appReportList(String appId, String slotId, String startTime, String endTime, Integer currentPage, Integer pageSize) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        map.put("appId",appId);
        map.put("slotId",slotId);
        map.put("startTime",startTime);
        map.put("endTime",endTime);
        //页码格式化
        if(null == currentPage){
            currentPage = 1;
        }
        if(null == pageSize){
            pageSize = 20;
        }
        map.put("num",(currentPage - 1) * pageSize);
        map.put("pageSize",pageSize);
        List<AdStatisticsListVo> list = spaceDao.appReportList(map);
        int sumData = spaceDao.appReportListNum(map);

        //总页数
        int sumPage = 0;
        if(sumData%Integer.valueOf(pageSize) == 0){
            sumPage = (sumData/Integer.valueOf(pageSize));
        }else{
            sumPage = (sumData/Integer.valueOf(pageSize)) + 1;
        }

        Map<String,Object> result = new HashMap<>();
        result.put("list",list);
        result.put("currentPage",currentPage);
        result.put("pageSize",pageSize);
        result.put("sumPage",sumPage);
        result.put("sumData",sumData);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("数据加载完成");
        req.setResult(result);
        return req;
    }

    /**
     * 上报统计详情(展开)
     */
    @Override
    public ReqResponse appUpstreamReport(String createTime, String slotId) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        map.put("createTime",createTime);
        map.put("slotId",slotId);
        List<AdReportUpstreamListVo> appReportDetail = spaceDao.appUpstreamReport(map);
        System.out.println(appReportDetail.size());
        req.setMessage("数据加载完成");
        req.setResult(appReportDetail);
        req.setCode("200");
        return req;
    }


}
