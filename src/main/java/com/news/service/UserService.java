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

    /**
     * 修改密码
     */
    ReqResponse updatePassWord(Long userId, String oldPassWord, String passWord, String confirmPassWord);

    /**
     * 创建新用户
     */
    ReqResponse createUser(Long userId, String loginName, String passWord, String confirmPassWord, String nickName);

    /**
     * 用户列表
     */
    ReqResponse userList(Long userId, String loginName, String nickName, Integer userLevel, Integer userStatus, Integer currentPage, Integer pageSize);

    /**
     * 禁用/启用用户状态
     */
    ReqResponse userStatus(Long currentUserId, Long userId, Integer userStatus);
}
