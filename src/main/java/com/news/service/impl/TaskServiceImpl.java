package com.news.service.impl;

import com.news.dao.TaskDao;
import com.news.service.TaskService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * 定时器
 */
@Service("taskService")
public class TaskServiceImpl implements TaskService {

    @Resource
    private TaskDao taskDao;




    /**
     * 星辰广告统计
     */
    @Override
    public void xingChen(String str) {
        JSONObject json = JSONObject.fromObject(str);
        String data = json.getString("data");
        if (null != data && !"".equals(data)){
            JSONArray dataArray = json.getJSONArray("data");
        }
        System.out.println(str);

    }
}
