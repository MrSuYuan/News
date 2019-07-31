package com.news.service;

import com.news.entity.Web;
import com.utils.response.ReqResponse;

/**
 * WEB模块逻辑层接口
 */
public interface WebService {

    /**
     * 新加web网站信息
     */
    ReqResponse createWeb(Long currentUserId, int currentUserLevel, Web web);

}
