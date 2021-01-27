package com.news.service.impl;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.news.dao.TemporaryDao;
import com.news.entity.Copy;
import com.news.entity.Report;
import com.news.entity.YKAd;
import com.news.entity.YKAdvertiser;
import com.news.entity.youku.uploadad.Material;
import com.news.entity.youku.uploadad.Native;
import com.news.entity.youku.uploadad.UploadAdData;
import com.news.entity.youku.uploadadvertiser.Advertiser;
import com.news.entity.youku.uploadadvertiser.Qualifications;
import com.news.entity.youku.uploadadvertiser.UploadAdvertiserData;
import com.news.service.TemporaryService;
import com.news.vo.CopyVo;
import com.news.vo.ReportVo;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import javax.swing.plaf.metal.MetalRadioButtonUI;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service("temporaryService")
public class TemporaryServiceImpl implements TemporaryService {

    @Resource
    private TemporaryDao temporaryDao;

    @Override
    public ReqResponse addReport(String reportList) throws Exception {
        ReqResponse req = new ReqResponse();
        if(null != reportList && !"".equals(reportList)){
            //解析前端传过来的集合数据
            ObjectMapper mapper = new ObjectMapper();
            JavaType jt = mapper.getTypeFactory().constructParametricType(ArrayList.class, Report.class);
            List<Report> list =  mapper.readValue(reportList, jt);
            for(int i = 0; i < list.size(); i++){
                Report r = list.get(i);
                r.setClickProbability((double)r.getClickNum()/(double)r.getLookPv()*100);
                r.setEcpm(r.getIncome()*1000/(double)r.getLookPv());
                if (r.getClickNum() == 0){
                    r.setCpc(0);
                }else{
                    r.setCpc(r.getIncome()/(double)r.getClickNum());
                }
            }
            temporaryDao.addReport(list);
            req.setCode(ErrorMessage.SUCCESS.getCode());
            req.setMessage("添加成功");
        }else{
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("参数错误");
        }
        return req;
    }

    @Override
    public ReqResponse reportList(String adId, String startTime, String endTime, Integer currentPage, Integer pageSize) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        map.put("adId",adId);
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

        //list数据
        List<ReportVo> reportList = temporaryDao.reportList(map);
        DecimalFormat df = new DecimalFormat("######0.00");
        for(int i = 0; i < reportList.size(); i++){
            ReportVo r = reportList.get(i);
            if (r.getEcpm() == 0){
                r.setEcpm2("0");
            }else{
                r.setEcpm2(df.format(r.getEcpm()));
            }
            if (r.getCpc() == 0){
                r.setCpc2("0");
            }else{
                r.setCpc2(df.format(r.getCpc()));
            }
            r.setClickProbability2(df.format(r.getClickProbability()));
        }

        //总和
        int sumData = temporaryDao.reportListNum(map);

        //总页数
        int sumPage = 0;
        if(sumData%Integer.valueOf(pageSize) == 0){
            sumPage = (sumData/Integer.valueOf(pageSize));
        }else{
            sumPage = (sumData/Integer.valueOf(pageSize)) + 1;
        }

        Map<String,Object> result = new HashMap<>();
        result.put("list",reportList);
        result.put("currentPage",currentPage);
        result.put("pageSize",pageSize);
        result.put("sumPage",sumPage);
        result.put("sumData",sumData);


        req.setResult(result);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("成功");
        return req;
    }

    @Override
    public ReqResponse deleteReport(long id) {
        ReqResponse req = new ReqResponse();
        temporaryDao.deleteReport(id);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("成功");
        return req;
    }

    /**
     * 读取表格数据
     */
    @Override
    public ReqResponse readBDExcel(Sheet sheet) {
        ReqResponse req = new ReqResponse();
        int rowsOfSheet = sheet.getPhysicalNumberOfRows();
        List<Report> list = new ArrayList<>();
        // 第2行+--数据行
        for (int r = 1; r < rowsOfSheet; r++) {
            Row row = sheet.getRow(r);
            if (row == null) {
                continue;
            } else {
                Report report = new Report();
                int rowNum = row.getRowNum() + 1;//行数
                System.out.println(rowNum);
                row.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(8).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(9).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(10).setCellType(Cell.CELL_TYPE_STRING);
                Date c0 = row.getCell(0).getDateCellValue();//日期
                if (c0 == null){
                    continue;
                }
                report.setCreateTime(c0);
                String c1 = row.getCell(1).getStringCellValue();//代码位
                report.setAdId(c1);
                String c2 = row.getCell(2).getStringCellValue();//尺寸
                report.setAdSize(c2);
                String c3 = row.getCell(3).getStringCellValue();//媒体
                report.setAdName(c3);
                String c4 = row.getCell(4).getStringCellValue();//计费名
                report.setAddress(c4);
                String c5 = row.getCell(5).getStringCellValue();//展现
                report.setLookPv(Integer.valueOf(c5));
                String c6 = row.getCell(6).getStringCellValue();//收入
                report.setIncome(Double.parseDouble(c6));
                String c7 = row.getCell(7).getStringCellValue();//点击
                report.setClickNum(Integer.valueOf(c7));
                String c8 = row.getCell(8).getStringCellValue();//ecpm
                report.setEcpm(Double.parseDouble(c8));
                String c9 = row.getCell(9).getStringCellValue();//点击率
                report.setClickProbability((double)report.getClickNum()/(double)report.getLookPv()*100);
                String c10 = row.getCell(10).getStringCellValue();//cpc
                report.setCpc(Double.parseDouble(c10));
                list.add(report);
            }
        }
        temporaryDao.addReport(list);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("添加成功");
        return req;
    }

    @Override
    public ReqResponse addCopy(String copyList) throws Exception {
        ReqResponse req = new ReqResponse();
        if(null != copyList && !"".equals(copyList)){
            //解析前端传过来的集合数据
            ObjectMapper mapper = new ObjectMapper();
            JavaType jt = mapper.getTypeFactory().constructParametricType(ArrayList.class, Copy.class);
            List<Copy> list =  mapper.readValue(copyList, jt);
            for(int i = 0; i < list.size(); i++){
                Copy r = list.get(i);
                r.setClickProbability((double)r.getClickNum()/(double)r.getLookPv()*100);
                r.setEcpm(r.getIncome()*1000/(double)r.getLookPv());
                if (r.getClickNum() == 0){
                    r.setCpc(0);
                }else{
                    r.setCpc(r.getIncome()/(double)r.getClickNum());
                }
            }
            temporaryDao.addCopy(list);
            req.setCode(ErrorMessage.SUCCESS.getCode());
            req.setMessage("添加成功");
        }else{
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("参数错误");
        }
        return req;
    }

    /**
     * 读取表格数据
     */
    @Override
    public ReqResponse readBDExcelCopy(Sheet sheet) throws Exception{
        ReqResponse req = new ReqResponse();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        int rowsOfSheet = sheet.getPhysicalNumberOfRows();
        List<Copy> list = new ArrayList<>();
        // 第2行+--数据行
        for (int r = 1; r < rowsOfSheet; r++) {
            Row row = sheet.getRow(r);
            if (row == null) {
                continue;
            } else {
                Copy copy = new Copy();
                int rowNum = row.getRowNum() + 1;//行数
                System.out.println(rowNum);

                row.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(8).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(9).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(10).setCellType(Cell.CELL_TYPE_STRING);
                String c0 = row.getCell(0).getStringCellValue();//代码位id
                copy.setAdId(c0);
                String c1 = row.getCell(1).getStringCellValue();//代码位名称
                copy.setAdName(c1);
                String c2 = row.getCell(2).getStringCellValue();//日期
                copy.setCreateTime(sdf.parse(c2));
                String c3 = row.getCell(3).getStringCellValue();//展现
                copy.setLookPv(Integer.valueOf(c3));
                String c4 = row.getCell(4).getStringCellValue();//点击
                copy.setClickNum(Integer.valueOf(c4));
                String c5 = row.getCell(5).getStringCellValue();//收入
                copy.setIncome(Double.parseDouble(c5));
                String c6 = row.getCell(6).getStringCellValue();//epcm
                copy.setEcpm(Double.parseDouble(c6));
                String c7 = row.getCell(7).getStringCellValue();//cpc
                copy.setCpc(Double.parseDouble(c7));
                String c8 = row.getCell(8).getStringCellValue();//点击率
                copy.setClickProbability(Double.parseDouble(c8));
                String c9 = row.getCell(9).getStringCellValue();//到访pv
                copy.setAccessPv(Integer.valueOf(c9));
                String c10 = row.getCell(10).getStringCellValue();//详情页pv
                copy.setDetailPv(Integer.valueOf(c10));
                list.add(copy);
            }
        }
        temporaryDao.addCopy(list);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("添加成功");
        return req;
    }

    @Override
    public ReqResponse copyList(String adId, String startTime, String endTime, Integer currentPage, Integer pageSize) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        map.put("adId",adId);
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

        //list数据
        List<CopyVo> reportList = temporaryDao.copyList(map);
        DecimalFormat df = new DecimalFormat("######0.00");
        for(int i = 0; i < reportList.size(); i++){
            CopyVo r = reportList.get(i);
            if (r.getEcpm() == 0){
                r.setEcpm2("0");
            }else{
                r.setEcpm2(df.format(r.getEcpm()));
            }
            if (r.getCpc() == 0){
                r.setCpc2("0");
            }else{
                r.setCpc2(df.format(r.getCpc()));
            }
            r.setClickProbability2(df.format(r.getClickProbability()));
            //计算星期几
            String datetime = r.getCreateTime2();
            SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
            String[] weekDays = { "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" };
            Calendar cal = Calendar.getInstance(); // 获得一个日历
            Date datet = null;
            try {
                datet = f.parse(datetime);
                cal.setTime(datet);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            int w = cal.get(Calendar.DAY_OF_WEEK) - 1; // 指示一个星期中的某天。
            if (w < 0)
                w = 0;
            r.setWeekTime(weekDays[w]);

        }

        //总和
        int sumData = temporaryDao.copyListNum(map);

        //总页数
        int sumPage = 0;
        if(sumData%Integer.valueOf(pageSize) == 0){
            sumPage = (sumData/Integer.valueOf(pageSize));
        }else{
            sumPage = (sumData/Integer.valueOf(pageSize)) + 1;
        }

        Map<String,Object> result = new HashMap<>();
        result.put("list",reportList);
        result.put("currentPage",currentPage);
        result.put("pageSize",pageSize);
        result.put("sumPage",sumPage);
        result.put("sumData",sumData);
        req.setResult(result);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("成功");
        return req;
    }

    @Override
    public ReqResponse ykAdvertiserList() {
        ReqResponse req = new ReqResponse();
        List<YKAdvertiser> list = temporaryDao.ykAdvertiserList();
        req.setResult(list);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("成功");
        return req;
    }

    @Override
    public ReqResponse addAdvertiser(YKAdvertiser adver) throws Exception {
        ReqResponse req = new ReqResponse();

        /**
         * 向优酷提交
         */
        UploadAdvertiserData data = new UploadAdvertiserData();
        data.setDspid("11299");
        data.setToken("dd330ad07f3348638d9c4bad6540eeba");
        data.setType("RTB");
        //基本信息
        Advertiser advertiser = new Advertiser();
        advertiser.setName(adver.getName());//广告主名称
        advertiser.setBrand(adver.getBrand());//品牌名称
        advertiser.setAddress(adver.getAddress());//广告主公司地址
        advertiser.setContacts(adver.getUser());//广告主联系人
        advertiser.setTel(adver.getTel());//广告主联系电话
        advertiser.setFirstindustry(0);//一级统计行业--查询填写
        advertiser.setSecondindustry(0);//二级统计行业--查询填写
        //资质信息
        Qualifications qualifications = new Qualifications();
        qualifications.setName(adver.getCertificate());//资质证书名称（全名）-营业执照
        qualifications.setUrl(adver.getCertificateUrl());//资质文件的URL地址，由DSP提供可访问的资质文件URL地址
        qualifications.setMd5("");//资质文件内容的MD5值，即对图片二进制内容求md5值，MD5值采用32位小写格式
        qualifications.setOperation("add");//针对资质文件的操作(add/update/delete)
        List<Qualifications> qList = new ArrayList<>();
        qList.add(qualifications);
        advertiser.setQualifications(qList);
        data.setAdvertiser(advertiser);

        //向优酷提交信息
        String request = net.sf.json.JSONObject.fromObject(data).toString();
        String url = "http://api.yes.youku.com/dsp/api/uploadadvertiser";
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(url);
        httpPost.addHeader("Content-Type","application/json");
        httpPost.addHeader("Host","api.yes.youku.com");
        StringEntity entity = new StringEntity(request,"utf-8");
        httpPost.setEntity(entity);
        CloseableHttpResponse resp = httpClient.execute(httpPost);
        HttpEntity result = resp.getEntity();
        String str = EntityUtils.toString(result, "utf-8");
        System.out.println(str);

        /**
         * 本地数据库
         */
        temporaryDao.addAdvertiser(adver);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("成功");
        return req;
    }

    @Override
    public ReqResponse deleteAdvertiser(int id) throws Exception {
        ReqResponse req = new ReqResponse();

        YKAdvertiser adver = temporaryDao.ykAdvertiser(id);

        /**
         * 向优酷提交
         */
        UploadAdvertiserData data = new UploadAdvertiserData();
        data.setType("RTB");
        //基本信息
        Advertiser advertiser = new Advertiser();
        advertiser.setName(adver.getName());//广告主名称
        advertiser.setBrand(adver.getBrand());//品牌名称
        advertiser.setAddress(adver.getAddress());//广告主公司地址
        advertiser.setContacts(adver.getUser());//广告主联系人
        advertiser.setTel(adver.getTel());//广告主联系电话
        advertiser.setFirstindustry(0);//一级统计行业--查询填写
        advertiser.setSecondindustry(0);//二级统计行业--查询填写
        //资质信息
        Qualifications qualifications = new Qualifications();
        qualifications.setName(adver.getCertificate());//资质证书名称（全名）-营业执照
        qualifications.setUrl(adver.getCertificateUrl());//资质文件的URL地址，由DSP提供可访问的资质文件URL地址
        qualifications.setMd5("");//资质文件内容的MD5值，即对图片二进制内容求md5值，MD5值采用32位小写格式
        qualifications.setOperation("delete");//针对资质文件的操作(add/update/delete)
        List<Qualifications> qList = new ArrayList<>();
        qList.add(qualifications);
        advertiser.setQualifications(qList);
        data.setAdvertiser(advertiser);

        //向优酷提交信息
        String request = net.sf.json.JSONObject.fromObject(data).toString();
        String url = "http://api.yes.youku.com/dsp/api/uploadadvertiser";
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(url);
        httpPost.addHeader("Content-Type","application/json");
        StringEntity entity = new StringEntity(request,"utf-8");
        httpPost.setEntity(entity);
        CloseableHttpResponse resp = httpClient.execute(httpPost);
        HttpEntity result = resp.getEntity();
        String str = EntityUtils.toString(result, "utf-8");
        System.out.println(str);

        temporaryDao.deleteAdvertiser(id);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("成功");
        return req;
    }

    @Override
    public ReqResponse ykAdList() {
        ReqResponse req = new ReqResponse();
        List<YKAd> list = temporaryDao.ykAdList();
        req.setResult(list);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("成功");
        return req;
    }

    @Override
    public ReqResponse addYKAd(YKAd ykAd) throws Exception {
        ReqResponse req = new ReqResponse();

        List<YKAd> list = temporaryDao.ykAdList();
        int crid = list.size() + 1;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date sDate = new Date();
        ykAd.setCrid(crid);
        ykAd.setStartdate(sdf.format(sDate));
        Calendar calendar =Calendar.getInstance();
        calendar.setTime(sDate);
        calendar.add(calendar.YEAR, 1);//把日期往后增加一年.整数往后推,负数往前移动
        Date eDate = calendar.getTime();
        ykAd.setEnddate(sdf.format(eDate));

        /**
         * 向优酷提交
         */
        UploadAdData data = new UploadAdData();
        data.setType("RTB");

        int adType = ykAd.getAdType();
        if (adType == 1){
            //banner
            List<Material> material = new ArrayList<>();
            Material m = new Material();
            m.setCrid(crid+"");
            m.setUrl(ykAd.getImage_url());
            m.setLandingpage(ykAd.getLandingpage());
            m.setDeeplink(ykAd.getDeeplink());
            m.setAdvertiser(ykAd.getAdvertiser());
            m.setStartdate(sdf.format(sDate));
            m.setEnddate(sdf.format(eDate));
            material.add(m);
            data.setMaterial(material);
        }

        else {
            //信息流
            List<Native> aNative = new ArrayList<>();
            Native n = new Native();
            n.setCrid(crid+"");
            n.setTitle(ykAd.getTitle());
            n.setImage_url(ykAd.getImage_url());
            n.setVideo_url(ykAd.getVideo_url());
            n.setLogo_url(ykAd.getLogo_url());
            n.setBrand(ykAd.getBrand());
            n.setAdvertiser(ykAd.getAdvertiser());
            n.setStartdate(sdf.format(sDate));
            n.setEnddate(sdf.format(eDate));
            n.setLandingpage(ykAd.getLandingpage());
            aNative.add(n);
            data.setaNative(aNative);
        }

        //向优酷提交信息
        String request = net.sf.json.JSONObject.fromObject(data).toString();
        String url = "http://api.yes.youku.com/dsp/api/upload";
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(url);
        httpPost.addHeader("Content-Type","application/json");
        StringEntity entity = new StringEntity(request,"utf-8");
        httpPost.setEntity(entity);
        CloseableHttpResponse resp = httpClient.execute(httpPost);
        HttpEntity result = resp.getEntity();
        String str = EntityUtils.toString(result, "utf-8");
        System.out.println(str);

        /**
         * 本地数据库
         */
        temporaryDao.addYKAd(ykAd);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("成功");
        return req;
    }

    @Override
    public ReqResponse deleteAd(int crid) {
        ReqResponse req = new ReqResponse();
        temporaryDao.deleteAd(crid);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("成功");
        return req;
    }


}
