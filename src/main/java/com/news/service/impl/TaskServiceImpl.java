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
import java.text.SimpleDateFormat;
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
                        int lookpv = (int)(as.getBeforeLookPV() * dividedZ);
                        if (lookpv == 0){
                            as.setLookPV(0);
                            as.setClickNum(0);
                            as.setIncome(0);
                            as.setClickProbability(0);
                            as.setEcpm(0);
                        }else{
                            as.setLookPV((int)(as.getBeforeLookPV() * dividedZ));
                            as.setClickNum((int)(as.getBeforeClickNum() * dividedZ));
                            as.setIncome(as.getBeforeIncome() * upstreamDivided * dividedY * dividedZ);
                            as.setClickProbability((double)as.getClickNum()*100/(double)as.getLookPV());
                            as.setEcpm(as.getIncome()*1000/(double)as.getLookPV());
                        }
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

    /**
     * 消息
     */
    @Override
    public void xiaoxi() {
        //时间
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar c = Calendar.getInstance();
        //-1.昨天时间 0.当前时间 1.明天时间 *以此类推
        c.add(Calendar.DATE, -1);
        String t1 = sdf.format(c.getTime());
        //-1.昨天时间 0.当前时间 1.明天时间 *以此类推
        c.add(Calendar.DATE, -1);
        String t2 = sdf.format(c.getTime());

        //先看看今天有没有出数据(昨天的数据id)
        List<String> l1 = taskDao.dayData(t1);
        System.out.println("昨天数据"+l1.size());
        //出了
        if (l1.size() > 0){
            //再看看今天有没有消息
            int todayMessage = taskDao.todayMessage();
            System.out.println("昨天消息"+todayMessage);
            //没有消息
            if (todayMessage == 0){
                //查看今天的id
                List<String> l2 = taskDao.dayData(t2);
                System.out.println("前天数据"+l2.size());
                //对比-添加消息
                int k = 0;
                for (int i = 0; i < l2.size(); i++){
                    for (int j = 0; j < l1.size(); j++){
                        if (l2.get(i).equals(l1.get(j))){
                            l2.set(i,"");
                            k = k + 1;
                            continue;
                        }
                    }
                }
                String message = "昨日无数据ID : ";
                if (k != l2.size()){
                    for (int i = 0; i < l2.size(); i++){
                        if (!"".equals(l2.get(i))){
                            message = message + l2.get(i) + "  ";
                        }
                    }
                    System.out.println("消息"+message);
                    //添加新消息
                    taskDao.insertMessage(message);

                }
            }
        }
    }

    public static void main(String[] args) {
        List l1 = new ArrayList();
        l1.add(1);
        l1.add(5);
        l1.add(3);
        l1.add(6);
        l1.add(8);
        List l2 = new ArrayList();
        l2.add(5);
        l2.add(3);
        l2.add(6);
        for (int i = 0; i < l1.size(); i++){
            for (int j = 0; j < l2.size(); j++){
                if (l1.get(i) == l2.get(j)){
                    l1.set(i,0);
                    continue;
                }
            }
        }
        for (int i = 0; i < l1.size(); i++){
            if ((int)l1.get(i) != 0){
                System.out.println(l1.get(i));
            }

        }
    }

}
