package com.news.dao;

import com.news.entity.User;
import org.springframework.stereotype.Repository;

/**
 * 用户模块
 */
@Repository("userDao")
public interface UserDao {

    /**
     * 用户登录
     */
    User user(String loginName);

}
