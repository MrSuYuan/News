package com.news.service.impl;

import com.news.dao.WebDao;
import com.news.service.WebService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * WEB模块逻辑层实现
 */
@Service("webService")
public class WebServiceImpl implements WebService {

    @Resource
    private WebDao webDao;

}
