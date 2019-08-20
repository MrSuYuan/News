package com.news.controller;

import com.news.entity.Login;
import com.news.entity.User;
import com.news.service.UserService;
import com.utils.base.BaseController;
import com.utils.image.ImageUtil;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
@RequestMapping("")
@Api(value = "/page", tags = "跳转路径接口")
public class PageController extends BaseController {

    private final Logger logger = LoggerFactory.getLogger(PageController.class);

    @Autowired
    UserService userService;

    /**
     * 跳转到登录页
     */
    @RequestMapping(value = "/login",method=RequestMethod.GET)
    public ModelAndView loginPage(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("/index/login");
        return mv;
    }

    /**
     * PC端
     * 动态生成验证码
     */
    @RequestMapping(value="image",method=RequestMethod.GET)
    public void image(HttpServletRequest request,HttpServletResponse response)throws Exception{
        response.setHeader("Pragma", "No-cache");//No-cache不走缓存
        response.setHeader("Cache-Control", "No-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("image/jpeg");
        //生成随机字符串  4位
        String verifyCode=ImageUtil.generateVerifyCode(4);
        //存入会话session
        HttpSession session=request.getSession(true);
        session.setAttribute("captcha", verifyCode.toLowerCase());
        //生成图片
        int w=150,h=60;
        ImageUtil.outputImage(w, h, response.getOutputStream(), verifyCode);
    }

    /**
     * 用户登录方法
     */
    @RequestMapping(value = "/userLogin", method = RequestMethod.POST)
    @ResponseBody
    public ReqResponse login(@Valid @ModelAttribute Login login)  {
        ReqResponse req = new ReqResponse();
        //验证验证码
        Object captcha = request.getSession().getAttribute("captcha");
        if(null != captcha){
            if(login.getCaptcha().equals(captcha.toString())){
                //验证用户信息
                req = userService.userLogin(login);
                if(req.getCode().equals("200")){
                    User user = (User)req.getResult();
                    request.getSession().invalidate();
                    HttpSession session = request.getSession();
                    session.setAttribute("userId", user.getUserId());
                    session.setAttribute("userLevel", user.getUserLevel());
                    session.setAttribute("nickName", user.getNickName());
                    req.setResult("/index");
                }else{
                    req.setCode(req.getCode());
                    req.setMessage(req.getMessage());
                }

            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("验证码错误");
            }

        }else{
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("验证码失效请刷新");
        }
        return req;
    }

    /**
     * 退出登录
     */
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public ModelAndView logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.invalidate();
        ModelAndView mv = new ModelAndView("redirect:/login");
        return mv;
    }

    /**
     * 模板主页
     */
    @RequestMapping(value = "index" , method= RequestMethod.GET)
    @ApiOperation(value = "模板主页面", notes = "模板主页面", httpMethod = "GET")
    public String index(){
        return "/index/index";
    }

    /**
     * 用户列表
     */
    @RequestMapping(value = "userList" , method= RequestMethod.GET)
    @ApiOperation(value = "用户列表", notes = "用户列表", httpMethod = "GET")
    public String userList(){ return "user/userList";}

    /**
     * app列表页
     */
    @RequestMapping(value = "appList" , method= RequestMethod.GET)
    @ApiOperation(value = "app列表页", notes = "app列表页", httpMethod = "GET")
    public String appList(){ return "app/appList";}

    /**
     * app详情页
     */
    @RequestMapping(value = "appDetail" , method= RequestMethod.GET)
    @ApiOperation(value = "app详情页", notes = "app详情页", httpMethod = "GET")
    public String appDetail(){ return "app/appDetail";}

    /**
     * APP添加代码位信息
     */
    @RequestMapping(value = "addAppAdspace" , method= RequestMethod.GET)
    @ApiOperation(value = "添加APP代码位信息", notes = "添加APP代码位信息", httpMethod = "GET")
    public String addAppAdspace(){ return "app/addAdspace";}

    /**
     * APP广告位列表
     */
    @RequestMapping(value = "appAdspaceList" , method= RequestMethod.GET)
    @ApiOperation(value = "APP广告位列表", notes = "APP广告位列表", httpMethod = "GET")
    public String appAdspaceList(){ return "app/adspaceList";}

    /**
     * APP编辑上游信息
     */
    @RequestMapping(value = "addUpstream" , method= RequestMethod.GET)
    @ApiOperation(value = "APP编辑上游信息", notes = "APP编辑上游信息", httpMethod = "GET")
    public String addUpstream(){ return "app/addUpstream";}

    /**
     * APP上游信息列表
     */
    @RequestMapping(value = "appUpstreamList" , method= RequestMethod.GET)
    @ApiOperation(value = "APP上游信息列表", notes = "APP上游信息列表", httpMethod = "GET")
    public String appUpstreamList(){ return "app/appUpstreamList";}

    /**
     * APP添加数据统计
     */
    @RequestMapping(value = "addAppStatistics" , method= RequestMethod.GET)
    @ApiOperation(value = "添加APP数据统计", notes = "添加APP数据统计", httpMethod = "GET")
    public String addAppStatistics(){ return "app/addAppStatistics";}

    /**
     * APP数据统计列表
     */
    @RequestMapping(value = "appStatisticsList" , method= RequestMethod.GET)
    @ApiOperation(value = "数据统计列表", notes = "数据统计列表", httpMethod = "GET")
    public String appStatisticsList(){ return "app/appStatisticsList";}

    /**
     * WEB列表页
     */
    @RequestMapping(value = "webList" , method= RequestMethod.GET)
    @ApiOperation(value = "web列表页", notes = "web列表页", httpMethod = "GET")
    public String webList(){ return "web/webList";}

    /**
     * WEB详情页
     */
    @RequestMapping(value = "webDetail" , method= RequestMethod.GET)
    @ApiOperation(value = "web详情页", notes = "web详情页", httpMethod = "GET")
    public String webDetail(){ return "web/webDetail";}

    /**
     * WEB添加代码位信息
     */
    @RequestMapping(value = "addWebAdspace" , method= RequestMethod.GET)
    @ApiOperation(value = "添加WEB代码位信息", notes = "添加WEB代码位信息", httpMethod = "GET")
    public String addWebAdspace(){ return "web/addAdspace";}

    /**
     * WEB广告位列表
     */
    @RequestMapping(value = "webAdspaceList" , method= RequestMethod.GET)
    @ApiOperation(value = "WEB广告位列表", notes = "WEB广告位列表", httpMethod = "GET")
    public String webAdspaceList(){ return "web/adspaceList";}

    /**
     * WEB添加数据统计
     */
    @RequestMapping(value = "addWebStatistics" , method= RequestMethod.GET)
    @ApiOperation(value = "添加WEB数据统计", notes = "添加WEB数据统计", httpMethod = "GET")
    public String addWebStatistics(){ return "web/addWebStatistics";}

    /**
     * WEB数据统计列表
     */
    @RequestMapping(value = "webStatisticsList" , method= RequestMethod.GET)
    @ApiOperation(value = "数据统计列表", notes = "数据统计列表", httpMethod = "GET")
    public String webStatisticsList(){ return "web/webStatisticsList";}

    /**
     * 测试
     */
    @RequestMapping(value = "test" , method= RequestMethod.GET)
    @ApiOperation(value = "测试", notes = "测试", httpMethod = "GET")
    public String test(){ return "index/test";}


}
