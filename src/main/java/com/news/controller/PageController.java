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
     * 登录页
     */
    @RequestMapping(value = "/login",method=RequestMethod.GET)
    public ModelAndView loginPage() {
        ModelAndView mv = new ModelAndView("/html/index/login.jsp");
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
            if(login.getCaptcha().toLowerCase().equals(captcha.toString())){
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
        return "/html/index/index.jsp";
    }

    /**
     * 个人中心
     */
    @RequestMapping(value = "userCenter" , method= RequestMethod.GET)
    @ApiOperation(value = "个人中心", notes = "个人中心", httpMethod = "GET")
    public String userCenter(){ return "/html/user/userCenter.jsp";}

    /**
     * 用户列表
     */
    @RequestMapping(value = "userList" , method= RequestMethod.GET)
    @ApiOperation(value = "用户列表", notes = "用户列表", httpMethod = "GET")
    public String userList(){ return "/html/user/userList.jsp";}

    /**
     * app列表页
     */
    @RequestMapping(value = "appList" , method= RequestMethod.GET)
    @ApiOperation(value = "app列表页", notes = "app列表页", httpMethod = "GET")
    public String appList(){ return "/html/app/appList.jsp";}

    /**
     * app详情页
     */
    @RequestMapping(value = "appDetail" , method= RequestMethod.GET)
    @ApiOperation(value = "app详情页", notes = "app详情页", httpMethod = "GET")
    public String appDetail(){ return "/html/app/appDetail.jsp";}

    /**
     * APP广告位列表
     */
    @RequestMapping(value = "appSlotList" , method= RequestMethod.GET)
    @ApiOperation(value = "APP广告位列表", notes = "APP广告位列表", httpMethod = "GET")
    public String appSlotList(){ return "html/app/appSlotList.jsp";}

    /**
     * APP添加代码位信息
     */
    @RequestMapping(value = "appSlotAdd" , method= RequestMethod.GET)
    @ApiOperation(value = "添加APP代码位信息", notes = "添加APP代码位信息", httpMethod = "GET")
    public String appSlotAdd(){ return "html/app/appSlotAdd.jsp";}

    /**
     * APP编辑上游信息
     */
    @RequestMapping(value = "appSlotAddUpstream" , method= RequestMethod.GET)
    @ApiOperation(value = "APP编辑上游信息", notes = "APP编辑上游信息", httpMethod = "GET")
    public String appSlotAddUpstream(){ return "html/app/appSlotAddUpstream.jsp";}

    /**
     * APP上游信息列表
     */
    @RequestMapping(value = "appSlotUpstreamList" , method= RequestMethod.GET)
    @ApiOperation(value = "APP上游信息列表", notes = "APP上游信息列表", httpMethod = "GET")
    public String appSlotUpstreamList(){ return "html/app/appSlotUpstreamList.jsp";}

    /**
     * APP广告位上报详情
     */
    @RequestMapping(value = "appSlotReport" , method= RequestMethod.GET)
    @ApiOperation(value = "APP广告位上报详情", notes = "APP广告位上报详情", httpMethod = "GET")
    public String appSlotReport(){ return "html/app/appSlotReport.jsp";}

    /**
     * APP激励视频调度分配
     */
    @RequestMapping(value = "appAssign" , method= RequestMethod.GET)
    @ApiOperation(value = "激励视频调度分配", notes = "激励视频调度分配", httpMethod = "GET")
    public String appAssign(){
        return "/html/app/appAssign.jsp";
    }

    /**
     * APP添加数据统计
     */
    @RequestMapping(value = "appStatisticsAdd" , method= RequestMethod.GET)
    @ApiOperation(value = "添加APP数据统计", notes = "添加APP数据统计", httpMethod = "GET")
    public String appStatisticsAdd(){ return "/html/app/appStatisticsAdd.jsp";}

    /**
     * APP数据统计列表-管理
     */
    @RequestMapping(value = "appStatisticsManage" , method= RequestMethod.GET)
    @ApiOperation(value = "数据统计列表", notes = "数据统计列表", httpMethod = "GET")
    public String appStatisticsManage(){
        return "/html/app/appStatisticsManage.jsp";
    }


    /**
     * APP数据统计列表-客户
     */
    @RequestMapping(value = "appStatisticsUser" , method= RequestMethod.GET)
    @ApiOperation(value = "数据统计列表", notes = "数据统计列表", httpMethod = "GET")
    public String appStatisticsUser(){
        return "/html/app/appStatisticsUser.jsp";
    }


    /**
     * APP上报统计列表
     */
    @RequestMapping(value = "appReportList" , method= RequestMethod.GET)
    @ApiOperation(value = "APP上报统计列表", notes = "APP上报统计列表", httpMethod = "GET")
    public String appReportList(){
        return "/html/app/appReportList.jsp";
    }

    /**
     * APP上游列表
     */
    @RequestMapping(value = "appUpstreamList" , method= RequestMethod.GET)
    @ApiOperation(value = "APP上游列表", notes = "APP上游列表", httpMethod = "GET")
    public String appUpstreamList(){
        return "/html/app/appUpstreamList.jsp";
    }

    /**
     * APP添加新上游
     */
    @RequestMapping(value = "appUpstreamAdd" , method= RequestMethod.GET)
    @ApiOperation(value = "APP添加新上游", notes = "APP添加新上游", httpMethod = "GET")
    public String appUpstreamAdd(){
        return "/html/app/appUpstreamAdd.jsp";
    }

    /**
     * APP上游广告位列表
     */
    @RequestMapping(value = "appUpstreamIdList" , method= RequestMethod.GET)
    @ApiOperation(value = "APP上游广告位列表", notes = "APP上游广告位列表", httpMethod = "GET")
    public String appUpstreamIdList(){
        return "/html/app/appUpstreamIdList.jsp";
    }

    /**
     * 上传其他Excel
     */
    @RequestMapping(value = "appUploadExcel" , method= RequestMethod.GET)
    @ApiOperation(value = "上传其他Excel", notes = "上传其他Excel", httpMethod = "GET")
    public String appUploadExcel(){
        return "/html/app/appUploadExcel.jsp";
    }

    /**
     * 上传UCExcel
     */
    @RequestMapping(value = "appUploadUCExcel" , method= RequestMethod.GET)
    @ApiOperation(value = "上传UCExcel", notes = "上传UCExcel", httpMethod = "GET")
    public String appUploadUCExcel(){
        return "/html/app/appUploadUCExcel.jsp";
    }

    /**
     * 上传UCExcel
     */
    @RequestMapping(value = "appUploadOtherExcel" , method= RequestMethod.GET)
    @ApiOperation(value = "上传UCExcel", notes = "上传UCExcel", httpMethod = "GET")
    public String appUploadOtherExcel(){
        return "/html/app/appUploadOtherExcel.jsp";
    }

    /**
     * APP上游广告位编辑
     */
    @RequestMapping(value = "appUpstreamIdEdit" , method= RequestMethod.GET)
    @ApiOperation(value = "APP上游广告位编辑", notes = "APP上游广告位编辑", httpMethod = "GET")
    public String appUpstreamIdEdit(){
        return "/html/app/appUpstreamIdEdit.jsp";
    }

    /**
     * httpRequest
     */
    @RequestMapping(value = "httpRequest" , method= RequestMethod.GET)
    @ApiOperation(value = "httpRequest", notes = "httpRequest", httpMethod = "GET")
    public String httpRequest(){
        return "/html/app/httpRequest.jsp";
    }


    /**
     * WEB列表页
     */
    @RequestMapping(value = "webList" , method= RequestMethod.GET)
    @ApiOperation(value = "web列表页", notes = "web列表页", httpMethod = "GET")
    public String webList(){ return "/html/web/webList.jsp";}

    /**
     * WEB详情页
     */
    @RequestMapping(value = "webDetail" , method= RequestMethod.GET)
    @ApiOperation(value = "web详情页", notes = "web详情页", httpMethod = "GET")
    public String webDetail(){ return "/html/web/webDetail.jsp";}

    /**
     * WEB添加代码位信息
     */
    @RequestMapping(value = "webAdspaceAdd" , method= RequestMethod.GET)
    @ApiOperation(value = "添加WEB代码位信息", notes = "添加WEB代码位信息", httpMethod = "GET")
    public String webAdspaceAdd(){ return "/html/web/webAdspaceAdd.jsp";}

    /**
     * WEB广告位列表
     */
    @RequestMapping(value = "webAdspaceList" , method= RequestMethod.GET)
    @ApiOperation(value = "WEB广告位列表", notes = "WEB广告位列表", httpMethod = "GET")
    public String webAdspaceList(){ return "/html/web/webAdspaceList.jsp";}

    /**
     * WEB上游列表
     */
    @RequestMapping(value = "webUpstreamTypeList" , method= RequestMethod.GET)
    @ApiOperation(value = "WEB上游列表", notes = "WEB上游列表", httpMethod = "GET")
    public String webUpstreamTypeList(){ return "/html/web/webUpstreamTypeList.jsp";}

    /**
     * WEB添加数据统计
     */
    @RequestMapping(value = "webStatisticsAdd" , method= RequestMethod.GET)
    @ApiOperation(value = "添加WEB数据统计", notes = "添加WEB数据统计", httpMethod = "GET")
    public String webStatisticsAdd(){ return "/html/web/webStatisticsAdd.jsp";}

    /**
     * WEB数据统计列表
     */
    @RequestMapping(value = "webStatistics" , method= RequestMethod.GET)
    @ApiOperation(value = "数据统计列表", notes = "数据统计列表", httpMethod = "GET")
    public String webStatistics(){
        Object userLevel = request.getSession().getAttribute("userLevel");
        if(null != userLevel && (int)userLevel == 3){
            return "/html/web/webStatisticsUser.jsp";
        }else{
            return "/html/web/webStatisticsManage.jsp";
        }
    }

    /**
     * 上传excel
     */
    @RequestMapping(value = "webReadExcel" , method= RequestMethod.GET)
    @ApiOperation(value = "上传excel", notes = "上传excel", httpMethod = "GET")
    public String webReadExcel(){
        return "/html/web/webReadExcel.jsp";
    }

    /**
     * 上传excel
     */
    @RequestMapping(value = "webUploadExcel" , method= RequestMethod.GET)
    @ApiOperation(value = "上传excel", notes = "上传excel", httpMethod = "GET")
    public String webUploadExcel(){
        return "/html/web/webUploadExcel.jsp";
    }

    /**
     * ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */

    /**
     * 临时报表
     */
    @RequestMapping(value = "temporaryList" , method= RequestMethod.GET)
    @ApiOperation(value = "展示报表", notes = "展示报表", httpMethod = "GET")
    public String temporaryList(){ return "/html/temporary/temporaryList.jsp";}

    /**
     * 临时报表
     */
    @RequestMapping(value = "temporaryAdd" , method= RequestMethod.GET)
    @ApiOperation(value = "添加报表", notes = "添加报表", httpMethod = "GET")
    public String temporaryAdd(){ return "/html/temporary/temporaryAdd.jsp";}

    /**
     * 临时报表2
     */
    @RequestMapping(value = "copyList" , method= RequestMethod.GET)
    @ApiOperation(value = "展示报表", notes = "展示报表", httpMethod = "GET")
    public String copyList(){ return "/html/temporary/copyList.jsp";}

    /**
     * 临时报表2
     */
    @RequestMapping(value = "copyAdd" , method= RequestMethod.GET)
    @ApiOperation(value = "添加报表", notes = "添加报表", httpMethod = "GET")
    public String copyAdd(){ return "/html/temporary/copyAdd.jsp";}

    /**
     * 隐私协议
     */
    @RequestMapping(value = "privacy" , method= RequestMethod.GET)
    @ApiOperation(value = "添加报表", notes = "添加报表", httpMethod = "GET")
    public String privacy(){ return "/html/user/privacy.jsp";}


}
