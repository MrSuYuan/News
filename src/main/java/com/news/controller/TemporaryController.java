package com.news.controller;

import com.news.service.AppService;
import com.news.service.TemporaryService;
import com.utils.base.BaseController;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.util.Iterator;

@Controller
@RequestMapping("temporary")
@Api(value = "/temporary", tags = "临时统计")
public class TemporaryController extends BaseController {

    @Autowired
    TemporaryService temporaryService;

    @RequestMapping(value="addReport", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "假-统计信息-添加", notes = "假-统计信息-添加", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="reportList" , value="参数集合" ,required = true , paramType = "query" ,dataType = "List")
    })
    @CrossOrigin
    public ReqResponse addReport(@RequestParam("reportList")String reportList)throws Exception{
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = temporaryService.addReport(reportList);
        }
        return req;
    }

    @RequestMapping(value="reportList", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "假-统计列表", notes = "假-统计列表", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="startTime" , value="起始时间" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="endTime" , value="结束时间" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="adId" , value="adId" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页码容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse reportList(String adId, String startTime, String endTime, Integer currentPage, Integer pageSize){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = temporaryService.reportList(adId, startTime, endTime, currentPage, pageSize);
        }
        return req;
    }

    /**
     * 上传百度excel
     */
    @RequestMapping(value = "/uploadBDExcel", method = RequestMethod.POST)
    @ResponseBody
    public ReqResponse uploadBDExcel(HttpServletRequest request) throws Exception {
        ReqResponse req = new ReqResponse();
        // 创建一个通用的多部分解析器
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver( request.getSession().getServletContext());
        // 判断 request 是否有文件上传,即多部分请求
        if (multipartResolver.isMultipart(request)) {
            // 转换成多部分request
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            // 取得request中的所有文件名
            Iterator<String> iter = multiRequest.getFileNames();
            while (iter.hasNext()) {
                // 取得上传文件
                MultipartFile file = multiRequest.getFile(iter.next());
                InputStream inputStream = file.getInputStream(); // 获取文件的输入流
                Workbook workbook = WorkbookFactory.create(inputStream);
                int numberOfSheets = workbook.getNumberOfSheets();
                if (numberOfSheets > 0){
                    // sheet工作表
                    Sheet sheet = workbook.getSheetAt(0);
                    req = temporaryService.readBDExcel(sheet);
                    req.setCode("200");
                    req.setMessage("成功");
                }else{
                    req.setCode("300");
                    req.setMessage("表格数据错误");
                }
            }

        }else{
            req.setCode("300");
            req.setMessage("检测不到文件");
        }
        return req;
    }

    @RequestMapping(value="addCopy", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "假-统计信息-添加", notes = "假-统计信息-添加", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="copyList" , value="参数集合" ,required = true , paramType = "query" ,dataType = "List")
    })
    @CrossOrigin
    public ReqResponse addCopy(@RequestParam("copyList")String copyList)throws Exception{
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = temporaryService.addCopy(copyList);
        }
        return req;
    }

    /**
     * 上传百度excel
     */
    @RequestMapping(value = "/uploadBDExcelCopy", method = RequestMethod.POST)
    @ResponseBody
    public ReqResponse uploadBDExcelCopy(HttpServletRequest request) throws Exception {
        ReqResponse req = new ReqResponse();
        // 创建一个通用的多部分解析器
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver( request.getSession().getServletContext());
        // 判断 request 是否有文件上传,即多部分请求
        if (multipartResolver.isMultipart(request)) {
            // 转换成多部分request
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            // 取得request中的所有文件名
            Iterator<String> iter = multiRequest.getFileNames();
            while (iter.hasNext()) {
                // 取得上传文件
                MultipartFile file = multiRequest.getFile(iter.next());
                InputStream inputStream = file.getInputStream(); // 获取文件的输入流
                Workbook workbook = WorkbookFactory.create(inputStream);
                int numberOfSheets = workbook.getNumberOfSheets();
                if (numberOfSheets > 0){
                    // sheet工作表
                    Sheet sheet = workbook.getSheetAt(0);
                    req = temporaryService.readBDExcelCopy(sheet);
                    req.setCode("200");
                    req.setMessage("成功");
                }else{
                    req.setCode("300");
                    req.setMessage("表格数据错误");
                }
            }

        }else{
            req.setCode("300");
            req.setMessage("检测不到文件");
        }
        return req;
    }

    @RequestMapping(value="copyList", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "假-统计列表", notes = "假-统计列表", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="startTime" , value="起始时间" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="endTime" , value="结束时间" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="adId" , value="adId" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页码容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse copyList(String adId, String startTime, String endTime, Integer currentPage, Integer pageSize){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = temporaryService.copyList(adId, startTime, endTime, currentPage, pageSize);
        }
        return req;
    }

}
