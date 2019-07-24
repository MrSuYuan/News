package com.news.service;

import com.news.entity.Login;
import com.utils.response.ReqResponse;

/**
 * 用户模块
 */
public interface UserService {

    /**
     * 用户登录方法
     */
    ReqResponse userLogin(Login login);
}
