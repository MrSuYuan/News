package com.news.service;

import java.util.Date;

/**
 * 定时器
 */
public interface TaskService {

    /**
     * 星辰广告统计
     */
    void xingChen(String str, String date, Date yesterday);

    /**
     * 广告位消息
     */
    void xiaoxi();
}
