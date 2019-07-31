package com.news.controller;

import com.news.entity.App;
import com.news.entity.Web;
import com.news.service.WebService;
import com.utils.base.BaseController;
import com.utils.response.ErrorMessage;
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

@Controller
@RequestMapping("web")
@Api(value = "/web", tags = "WEB模块")
public class WebController extends BaseController {

    private final Logger logger = LoggerFactory.getLogger(NewsController.class);

    @Autowired
    WebService webService;

    @RequestMapping(value = "/createWeb",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "创建web信息", notes = "创建web信息", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="webName" , value="网站名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="webUrl" , value="网站域名" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="rootType" , value="大类" ,required = false , paramType = "query" ,dataType = "Long"),
            @ApiImplicitParam(name="subType" , value="小类" ,required = false , paramType = "query" ,dataType = "Long"),
            @ApiImplicitParam(name="recordInfo" , value="备案信息" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="accessLevel" , value="访问量" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="webDescription" , value="网站描述" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="remark" , value="备注" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="userId" , value="所属用户" ,required = false , paramType = "query" ,dataType = "Long"),
            @ApiImplicitParam(name="currentUserLevel" , value="当前用户身份" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse createWeb(String webName, String webUrl, Long rootType, Long subType, String recordInfo,
                                 int accessLevel, String webDescription, String remark, Long userId, Integer currentUserLevel) {
        ReqResponse req = new ReqResponse();
        Object currentUserId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            Web web = new Web();
            web.setWebName(webName);
            web.setWebUrl(webUrl);
            web.setRootType(rootType);
            web.setSubType(subType);
            web.setRecordInfo(recordInfo);
            web.setAccessLevel(accessLevel);
            web.setWebDescription(webDescription);
            web.setRemark(remark);
            web.setUserId(userId);
            req = webService.createWeb((Long)currentUserId, currentUserLevel, web);
        }
        return req;
    }

}
