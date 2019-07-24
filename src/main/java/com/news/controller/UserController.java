package com.news.controller;

import com.news.service.UserService;
import com.utils.base.BaseController;
import com.utils.response.ReqResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("")
@Api(value = "/user", tags = "用户模块")
public class UserController extends BaseController {

    private final Logger logger = LoggerFactory.getLogger(NewsController.class);

    @Autowired
    UserService userService;

    @RequestMapping(value = "/createUser",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "添加用户信息", notes = "添加用户信息", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="contentType" , value="1推荐 2热点 3娱乐 4科技 5探索 6趣闻 7历史" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse getNews(HttpServletRequest request) {
        int contentType = Integer.valueOf(request.getParameter("contentType"));
        ReqResponse req = null;
        return req;
    }


}
