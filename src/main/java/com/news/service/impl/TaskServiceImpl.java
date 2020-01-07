package com.news.service.impl;

import com.news.dao.TaskDao;
import com.news.dao.WebDao;
import com.news.entity.WebStatistics;
import com.news.service.TaskService;
import com.news.vo.DividedVo;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.swing.*;
import java.util.*;

/**
 * 定时器
 */
@Service("taskService")
public class TaskServiceImpl implements TaskService {

    @Resource
    private TaskDao taskDao;

    @Resource
    private WebDao webDao;

    /**
     * 星辰广告统计
     */
    @Override
    public void xingChen(String str, String date, Date yesterday) {
        JSONObject json = JSONObject.fromObject(str);
        String data = json.getString("data");
        if (null != data && !"".equals(data)){
            //解析星辰返回参数
            JSONArray dataArray = json.getJSONArray("data");
            List<WebStatistics> list = new ArrayList<>();
            //循环取id
            for (Object object : dataArray){
                JSONObject jb = JSONObject.fromObject(object);
                String upstreamId = jb.getString("id");
                Map<String,Object> map = new HashMap<>();
                map.put("upstreamId",upstreamId);
                map.put("date",date);
                DividedVo dv = taskDao.dividedVo(map);
                if (null == dv){
                    System.out.println("不存在ID---"+upstreamId);
                    continue;
                }else{
                    System.out.println("ID---"+upstreamId+"?"+dv.getSpaceId());
                    int show = jb.getInt("show");//展现
                    int click = jb.getInt("click");//点击
                    double income = jb.getDouble("income");//收入
                    double upstreamDivided = dv.getUpstreamDivided();
                    double dividedY = dv.getDividedY();
                    double dividedZ = dv.getDividedZ();
                    WebStatistics as = new WebStatistics();
                    as.setCreateTime(yesterday);
                    as.setSpaceId(dv.getSpaceId());
                    as.setBeforeLookPV(show);
                    as.setBeforeClickNum(click);
                    as.setBeforeIncome(income);
                    as.setLookPV((int)(as.getBeforeLookPV() * dividedZ));
                    as.setClickNum((int)(as.getBeforeClickNum() * dividedZ));
                    as.setIncome(as.getBeforeIncome() * upstreamDivided * dividedY * dividedZ);
                    as.setClickProbability((double)as.getClickNum()*100/(double)as.getLookPV());
                    as.setEcmp(as.getIncome()*1000/(double)as.getLookPV());
                    list.add(as);
                }
            }
            if (list.size()>0){
                webDao.addWebStatistics(list);
            }
        }
    }
}
