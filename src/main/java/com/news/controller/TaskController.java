package com.news.controller;

import com.news.service.NewsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * 定时器
 */
@Service
public class TaskController {

    private final Logger logger = LoggerFactory.getLogger(NewsController.class);

    @Autowired
    NewsService newsService;

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
}
