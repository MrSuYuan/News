package com.news.service.impl;

import com.news.dao.ArticleDao;
import com.news.dao.UserDao;
import com.news.entity.article.Article;
import com.news.entity.article.ArticleStatisticsVo;
import com.news.entity.article.ArticleVo;
import com.news.service.ArticleService;
import com.news.vo.AppStatisticsListVo;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import org.apache.poi.hssf.usermodel.*;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 文章微信分享模块实现
 */
@Service("articleService")
public class ArticleServiceImpl implements ArticleService {

    @Resource
    private UserDao userDao;
    @Resource
    private ArticleDao articleDao;

    @Override
    public ReqResponse addArticle(Article article) {
        ReqResponse resp = new ReqResponse();
        int s = articleDao.articleNum() + 1;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
        String articleId = "A" + sdf.format(new Date()) + s;
        article.setArticleId(articleId);
        articleDao.insertArticle(article);
        resp.setCode("200");
        resp.setMessage("SUCCESS");
        return resp;
    }

    @Override
    public ReqResponse articleList(Long currentUserId, Integer currentPage, Integer pageSize) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        //页码格式化
        if(null == currentPage){
            currentPage = 1;
        }
        if(null == pageSize){
            pageSize = 20;
        }
        map.put("num",(currentPage - 1) * pageSize);
        map.put("pageSize",pageSize);
        //查看当前用户身份
        int userLevel = userDao.userLevel(currentUserId);
        map.put("userLevel",userLevel);
        map.put("currentUserId",currentUserId);
        //最高权限能看到所有的app信息,管理只能看到自己下级,普通用户只能看到自己的
        //app列表
        List<ArticleVo> appList = articleDao.articleList(map);
        //app数量
        int sumData = articleDao.articleListNum(map);
        //总页数
        int sumPage = 0;
        if(sumData%Integer.valueOf(pageSize) == 0){
            sumPage = (sumData/Integer.valueOf(pageSize));
        }else{
            sumPage = (sumData/Integer.valueOf(pageSize)) + 1;
        }
        Map<String,Object> result = new HashMap<>();
        result.put("appList",appList);
        result.put("currentPage",currentPage);
        result.put("pageSize",pageSize);
        result.put("sumPage",sumPage);
        result.put("sumData",sumData);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("数据加载完成");
        req.setResult(result);
        return req;
    }

    @Override
    public ReqResponse articleStatisticsList(Long currentUserId, String articleId, String startTime, String endTime, Integer currentPage, Integer pageSize) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        map.put("articleId",articleId);
        map.put("startTime",startTime);
        map.put("endTime",endTime);
        //页码格式化
        if(null == currentPage){
            currentPage = 1;
        }
        if(null == pageSize){
            pageSize = 20;
        }
        map.put("num",(currentPage - 1) * pageSize);
        map.put("pageSize",pageSize);
        //查看当前用户身份
        int userLevel = userDao.userLevel(currentUserId);
        map.put("userLevel",userLevel);
        map.put("currentUserId",currentUserId);
        //最高权限能看到所有的app信息,管理只能看到自己下级,普通用户只能看到自己的
        //app列表
        List<ArticleStatisticsVo> statisticsList = articleDao.articleStatisticsList(map);
        //app数量
        int sumData = articleDao.articleStatisticsListNum(map);
        //总页数
        int sumPage = 0;
        if(sumData%Integer.valueOf(pageSize) == 0){
            sumPage = (sumData/Integer.valueOf(pageSize));
        }else{
            sumPage = (sumData/Integer.valueOf(pageSize)) + 1;
        }
        Map<String,Object> result = new HashMap<>();
        result.put("statisticsList",statisticsList);
        result.put("currentPage",currentPage);
        result.put("pageSize",pageSize);
        result.put("sumPage",sumPage);
        result.put("sumData",sumData);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("数据加载完成");
        req.setResult(result);
        return req;
    }


    @Override
    public void excel(long userId, String startTime, String endTime, Integer currentPage, OutputStream out) {
        Map<String,Object> map = new HashMap<>();
        map.put("currentUserId",userId);
        map.put("startTime",startTime);
        map.put("endTime",endTime);
        List<ArticleStatisticsVo> list = articleDao.excel(map);
        /**
         * 以下为生成Excel操作
         */
        // 1.创建一个workbook，对应一个Excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 2.在workbook中添加一个sheet，对应Excel中的一个sheet
        HSSFSheet sheet = wb.createSheet("XXX表");
        // 3.在sheet中添加表头第0行，老版本poi对excel行数列数有限制short
        HSSFRow row = sheet.createRow((int) 0);
        // 4.创建单元格，设置值表头，设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        // 居中格式
        //style.setAlignment(HSSFCellStyle.ALIGN_CENTER);

        // 设置表头
        HSSFCell cell = row.createCell(0);
        cell.setCellValue("广告位ID");
        cell.setCellStyle(style);

        cell = row.createCell(1);
        cell.setCellValue("广告位名称");
        cell.setCellStyle(style);

        cell = row.createCell(2);
        cell.setCellValue("日期");
        cell.setCellStyle(style);

        cell = row.createCell(3);
        cell.setCellValue("分享人数");
        cell.setCellStyle(style);

        cell = row.createCell(4);
        cell.setCellValue("分享次数");
        cell.setCellStyle(style);

        cell = row.createCell(5);
        cell.setCellValue("回调次数");
        cell.setCellStyle(style);

        cell = row.createCell(6);
        cell.setCellValue("PV");
        cell.setCellStyle(style);

        cell = row.createCell(7);
        cell.setCellValue("UV");
        cell.setCellStyle(style);

        cell = row.createCell(8);
        cell.setCellValue("IP");
        cell.setCellStyle(style);

        cell = row.createCell(9);
        cell.setCellValue("收益");
        cell.setCellStyle(style);

        // 循环将数据写入Excel
        for (int i = 0; i < list.size(); i++) {
            row = sheet.createRow(i + 1);
            ArticleStatisticsVo alv= list.get(i);
            // 创建单元格，设置值
            row.createCell(0).setCellValue(alv.getArticleId());
            row.createCell(1).setCellValue(alv.getArticleName());
            row.createCell(2).setCellValue(alv.getCreateTime());
            row.createCell(3).setCellValue(alv.getShareUser());
            row.createCell(4).setCellValue(alv.getShareTimes());
            row.createCell(5).setCellValue(alv.getBackTimes());
            row.createCell(6).setCellValue(alv.getPv());
            row.createCell(7).setCellValue(alv.getUv());
            row.createCell(8).setCellValue(alv.getIp());
            row.createCell(9).setCellValue(alv.getIncome());
        }

        /*FileOutputStream out =new FileOutputStream("E:/XXX.xls");
        wb.write(out);
        out.close();*/
        try{
            wb.write(out);//保存Excel文件
            out.flush();
            out.close();//关闭文件流
            out.close();//关闭工作薄对象
            System.out.println("OK!");
        }catch (Exception e){
            System.out.println("NO!");
        }

    }

}
