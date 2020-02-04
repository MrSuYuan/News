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
     * str是星辰返回信息
     * date是字符串格式昨日日期
     * yesterday是时间格式昨日日期
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
                //查询对应广告位id和分润概率
                DividedVo dv = taskDao.dividedVo(map);
                if (null == dv){
                    System.out.println("不存在ID---"+upstreamId);
                    continue;
                }else{
                    System.out.println("正常ID---"+upstreamId+"..."+dv.getSpaceId());
                    //查看有没有当日数据
                    int spaceId = dv.getSpaceId();
                    map.put("spaceId",spaceId);
                    int num = taskDao.statisticsNum(map);
                    //没有昨日数据,添加数据
                    if (num == 0){
                        int show = jb.getInt("show");//展现
                        int click = jb.getInt("click");//点击
                        double income = jb.getDouble("income");//收入
                        double upstreamDivided = dv.getUpstreamDivided();
                        double dividedY = dv.getDividedY();
                        double dividedZ = dv.getDividedZ();
                        WebStatistics as = new WebStatistics();
                        as.setCreateTime(yesterday);
                        as.setSpaceId(spaceId);
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
                    //有昨日数据,跳过无操作
                    else{

                    }
                }
            }
            //添加数据统计
            if (list.size()>0){
                webDao.addWebStatistics(list);
            }
        }
    }
}
