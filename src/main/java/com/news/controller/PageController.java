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
        ModelAndView mv = new ModelAndView("/manage/login");
        return mv;
    }

    /**
     * PC端
     * 动态生成验证码
     */
    @RequestMapping(value="image")
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
        return "manage/index";
    }

    /**
     * 用户列表
     */
    @RequestMapping(value = "userList" , method= RequestMethod.GET)
    @ApiOperation(value = "用户列表", notes = "用户列表", httpMethod = "GET")
    public String userList(){ return "manage/userList";}

    /**
     * 新增用户
     */
    @RequestMapping(value = "createUser" , method= RequestMethod.GET)
    @ApiOperation(value = "新增用户页面", notes = "新增用户页面", httpMethod = "GET")
    public String createUser(){ return "manage/createUser";}

    /**
     * 模板实例
     */
    @RequestMapping(value = "exampleList" , method= RequestMethod.GET)
    @ApiOperation(value = "模板实例页面", notes = "模板实例页面", httpMethod = "GET")
    public String exampleList(){
        return "example/exampleList";
    }

    /**
     * 用户审核列表
     */
    @RequestMapping(value = "userAuditList" , method= RequestMethod.GET)
    @ApiOperation(value = "用户审核列表页面", notes = "用户审核列表页面", httpMethod = "GET")
    public String userAuditList(){ return "example/userAuditList";}

    /**
     * 用户管理列表
     */
    @RequestMapping(value = "userManagementList" , method= RequestMethod.GET)
    @ApiOperation(value = "用户管理列表页面", notes = "用户管理列表页面", httpMethod = "GET")
    public String userManagementList(){ return "example/userManagementList";}

    /**
     * 用户审核详情
     */
    @RequestMapping(value = "userAudit" , method= RequestMethod.GET)
    @ApiOperation(value = "用户审核详情", notes = "用户审核详情", httpMethod = "GET")
    public String userAudit(){ return "example/userAudit";}

    /**
     * 用户管理详情
     */
    @RequestMapping(value = "userManagement" , method= RequestMethod.GET)
    @ApiOperation(value = "用户管理详情", notes = "用户管理详情", httpMethod = "GET")
    public String userManagement(){ return "example/userManagement";}

    /**
     * 跳转到图片上传页面
     */
    @RequestMapping(value = "upload" , method= RequestMethod.GET)
    @ApiOperation(value = "跳转到图片上传页面", notes = "跳转到图片上传页面", httpMethod = "GET")
    public String upload(){ return "example/uploadPicture";}

    /**
     * 应用审核列表页
     */
    @RequestMapping(value = "reviewNormalList" , method= RequestMethod.GET)
    @ApiOperation(value = "应用审核列表页面", notes = "应用审核列表页面", httpMethod = "GET")
    public String reviewNormalList(){ return "example/reviewNormalList";}

    /**
     * 应用审核详情页
     */
    @RequestMapping(value = "reviewNormalDetails" , method= RequestMethod.GET)
    @ApiOperation(value = "应用审核详情页面", notes = "应用审核详情页面", httpMethod = "GET")
    public String reviewNormalDetails(){ return "example/reviewNormalDetails";}

    /**
     * 应用审核历史页
     */
    @RequestMapping(value = "reviewNormalHistory" , method= RequestMethod.GET)
    @ApiOperation(value = "应用审核历史页", notes = "应用审核历史页", httpMethod = "GET")
    public String reviewNormalHistory(){ return "example/reviewNormalHistory";}

    /**
     * 异常审核列表
     */
    @RequestMapping(value = "reviewErrorList" , method= RequestMethod.GET)
    @ApiOperation(value = "异常审核列表页面", notes = "异常审核列表页面", httpMethod = "GET")
    public String reviewErrorList(){ return "example/reviewErrorList";}

    /**
     * 异常审核详情页
     */
    @RequestMapping(value = "reviewErrorDetails" , method= RequestMethod.GET)
    @ApiOperation(value = "异常审核详情页面", notes = "异常审核详情页面", httpMethod = "GET")
    public String reviewErrorDetails(){ return "example/reviewErrorDetails";}

    /**
     * 修改密码
     */
    @RequestMapping(value = "updatePassWord" , method= RequestMethod.GET)
    @ApiOperation(value = "修改密码页面", notes = "修改密码页面", httpMethod = "GET")
    public String updatePassWord(){
        return "example/updatePass";
    }



}
