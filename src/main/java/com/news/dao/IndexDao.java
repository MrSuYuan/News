package com.news.dao;

import com.news.entity.News;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("indexDao")
public interface IndexDao {

    /**
     * 新闻批量新增
     */
    void insertNews(List<News> list);

    /**
     * 主页面-主列表
     */
    List<News> indexNews(Map<String,Object> map);

    /**
     * 主页面-热门列表
     */
    List<News> hotNews();

    /**
     * 查看详情
     */
    News newsDetails(Long newsId);
}
