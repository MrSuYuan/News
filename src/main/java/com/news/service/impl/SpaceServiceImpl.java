package com.news.service.impl;

import com.news.dao.SpaceDao;
import com.news.service.SpaceService;
import com.news.vo.*;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import net.sf.json.JSONObject;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.io.IOException;
import java.net.URLDecoder;
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

    public static void main(String[] args) {
        long startTime = System.currentTimeMillis();
        String data = "{\n" +
                "\t\"requestId\": \"1119092016594257588754\",\n" +
                "\t\"app\": {\n" +
                "\t\t\"appId\": \"DJPVHA\",\n" +
                "\t\t\"appName\": \"斗地主经典版\",\n" +
                "\t\t\"appVersion\": \"1.1.3\",\n" +
                "\t\t\"appPackage\": \"com.tencent.tmgp.zy.ddzjdb\"\n" +
                "\t},\n" +
                "\t\"slot\": {\n" +
                "\t\t\"slotId\": \"28n0la4p\",\n" +
                "\t\t\"slotheight\": \"480\",\n" +
                "\t\t\"slotwidth\": \"320\",\n" +
                "\t\t\"adtype\": 4\n" +
                "\t},\n" +
                "\t\"device\": {\n" +
                "\t\t\"androidId\": \"4fd86c81fc8e2daa\",\n" +
                "\t\t\"deviceType\": 1,\n" +
                "\t\t\"idfa\": \"\",\n" +
                "\t\t\"imei\": \"866333026939494\",\n" +
                "\t\t\"mac\": \"18:59:36:16:47:59\",\n" +
                "\t\t\"vendor\": \"Xiaomi\",\n" +
                "\t\t\"model\": \"MI 4LTE\",\n" +
                "\t\t\"osType\": 1,\n" +
                "\t\t\"osVersion\": \"6.0.1\",\n" +
                "\t\t\"screenHeight\": 1920,\n" +
                "\t\t\"screenWidth\": 1080,\n" +
                "\t\t\"ua\": \"Mozilla/5.0 (Linux; Android 6.0.1; MI 4LTE Build/MMB29M; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/57.0.2987.132 Mobile Safari/537.36\",\n" +
                "\t\t\"ppi\": 480,\n" +
                "\t\t\"screenOrientation\": 1,\n" +
                "\t\t\"imsi\": \"460021317195750\",\n" +
                "\t\t\"brand\": \"Xiaomi\"\n" +
                "\t},\n" +
                "\t\"network\": {\n" +
                "\t\t\"connectionType\": 100,\n" +
                "\t\t\"ip\": \"117.150.189.133\",\n" +
                "\t\t\"operatorType\": 1,\n" +
                "\t\t\"lat\": \"0.0\",\n" +
                "\t\t\"lon\": \"0.0\"\n" +
                "\t},\n" +
                "\t\"news\":{\n" +
                "\t\t\"page\":1,\n" +
                "\t\t\"title\":\"娱乐\"\n" +
                "\t}\n" +
                "}";
        String url = "http://47.95.31.238/adx/ssp/dspAdVideo";
        CloseableHttpClient httpClient = HttpClients.createDefault();
        JSONObject jsonResult;
        HttpPost method = new HttpPost(url);
        method.setHeader("Content-Type","application/json");
        try {
            StringEntity entity = new StringEntity(data);
            method.setEntity(entity);
            HttpResponse result = httpClient.execute(method);
            //url = URLDecoder.decode(url, "UTF-8");
            String str = EntityUtils.toString(result.getEntity(), "utf-8");
            jsonResult = JSONObject.fromObject(str);
            System.out.println("post请求提交成功:" + jsonResult);
            long endTime = System.currentTimeMillis();
            System.out.println("time"+(endTime-startTime));
        } catch (IOException e) {
            System.out.println("post请求提交失败:" + url);
        }
    }

}
