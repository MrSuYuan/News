package com.news.dao;

import com.news.vo.DividedVo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("taskDao")
public interface TaskDao {

    /**
     * 查询分润参数
     */
    DividedVo dividedVo(Map<String,Object> map);

    /**
     * 查看有没有数据信息
     */
    int statisticsNum(Map<String,Object> map);

    /**
     * 查询指定时间的数据
     */
    List<String> dayData(String date);

    /**
     * 查看当日消息
     */
    int todayMessage();

    /**
     * 添加消息
     */
    void insertMessage(String message);

}
