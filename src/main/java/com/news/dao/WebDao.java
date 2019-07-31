package com.news.dao;

import com.news.entity.Web;
import org.springframework.stereotype.Repository;

/**
 * WEB模块数据层接口
 */
@Repository("webDao")
public interface WebDao {

    /**
     * 查看web网站名是否可用
     */
    int webName(String webName);

    /**
     * 查看webUrl是否可用
     */
    int webUrl(String webUrl);

    /**
     * 保存web网站信息
     */
    void insertWeb(Web web);

}
