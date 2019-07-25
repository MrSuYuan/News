package com.news.service.impl;

import com.news.dao.AppDao;
import com.news.dao.UserDao;
import com.news.service.AppService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * APP模块
 */
@Service("appService")
public class AppServiceImpl implements AppService {

    @Resource
    private UserDao userDao;

    @Resource
    private AppDao appDao;
}
