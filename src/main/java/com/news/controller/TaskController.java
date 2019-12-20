package com.news.controller;

import com.news.service.NewsService;
import com.news.service.TaskService;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;


/**
 * 定时器
 */
@Service
public class TaskController {

    private final Logger logger = LoggerFactory.getLogger(NewsController.class);

    @Autowired
    NewsService newsService;
    @Autowired
    TaskService taskService;

    /**
     * 爬虫获取新闻信息
     */
    public void getNews() {
        logger.error("++++++++++++++获取新闻定时器开启+++++++++++++++++++");
        for(int i = 1; i < 8; i++){
            logger.error("++++++++++++++获取新闻类型+"+i+"++++++++++++++++++");
            newsService.getNews(i);
        }
        logger.error("++++++++++++++获取新闻定时器结束+++++++++++++++++++");
    }

    /**
     * 星辰+数据统计
     */
    public void xingChen() {
        logger.error("++++++++++++++星辰广告数据统计开始+++++++++++++++++++");

        //星辰账号key
        String key = "47484e3dbaf3b66a80ced2";
        //获取日期(获取昨天的日期)
        Calendar cal=Calendar.getInstance();
        cal.add(Calendar.DATE,-1);
        Date d=cal.getTime();
        SimpleDateFormat sp=new SimpleDateFormat("yyyy-MM-dd");
        String date=sp.format(d);

        String url = "https://channel.xingchenjia.com/client/dataapi/pcwap?key="+key+"&date="+date;
        System.out.println(url);
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet(url);
        CloseableHttpResponse response;
        try {
            response = httpClient.execute(httpGet);
            HttpEntity entity = response.getEntity();
            String str = EntityUtils.toString(entity,"utf-8");
            taskService.xingChen(str);
        } catch (IOException e) {
            e.printStackTrace();
        }
        logger.error("++++++++++++++星辰广告数据统计结束+++++++++++++++++++");
    }
}
