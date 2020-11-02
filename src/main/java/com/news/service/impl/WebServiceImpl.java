package com.news.service.impl;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.news.dao.TaskDao;
import com.news.dao.UserDao;
import com.news.dao.WebDao;
import com.news.entity.*;
import com.news.service.WebService;
import com.news.vo.*;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * WEB模块逻辑层实现
 */
@Service("webService")
public class WebServiceImpl implements WebService {

    @Resource
    private WebDao webDao;

    @Resource
    private UserDao userDao;

    /**
     * 新加web网站信息
     */
    @Override
    public ReqResponse createWeb(Long currentUserId, int currentUserLevel, Web web) {
        ReqResponse req = new ReqResponse();
        //查看web用户名是否可用
        int webName = webDao.webName(web.getWebName());
        if(webName > 0){
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("此网站名称已经存在");
            return req;
        }
        //查看webUrl是否可用
        int webUrl = webDao.webUrl(web.getWebUrl());
        if(webUrl > 0){
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("此网址已经存在");
            return req;
        }

        //个人填写信息 和 最高权限填写
        if(currentUserLevel == 3 || currentUserLevel == 1){
            webDao.insertWeb(web);
            req.setCode(ErrorMessage.SUCCESS.getCode());
            req.setMessage("添加成功");
        //管理员为下级填写app信息
        }else{
            //查看登录用户和web所属用户关系
            Map<String,Object> map = new HashMap<>();
            map.put("currentUserId",currentUserId);
            map.put("userId",web.getUserId());
            int count = userDao.userAndParent(map);
            if(count == 0){
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您没有操作权限");
            }else{
                webDao.insertWeb(web);
                req.setCode(ErrorMessage.SUCCESS.getCode());
                req.setMessage("添加成功");
            }
        }
        return req;
    }

    /**
     * WEB列表
     */
    @Override
    public ReqResponse webList(Long userId, String loginName, String nickName, String webName, Integer webStatus, Integer currentPage, Integer pageSize) {
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
        map.put("loginName",loginName);
        map.put("nickName",nickName);
        map.put("webName",webName);
        map.put("webStatus",webStatus);
        //查看当前用户身份
        int userLevel = userDao.userLevel(userId);
        map.put("userLevel",userLevel);
        map.put("userId",userId);
        //最高权限能看到所有的app信息,管理只能看到自己下级,普通用户只能看到自己的
        //app列表
        List<WebListVo> webList = webDao.webList(map);
        //app数量
        int sumData = webDao.webListNum(map);
        //总页数
        int sumPage = 0;
        if(sumData%Integer.valueOf(pageSize) == 0){
            sumPage = (sumData/Integer.valueOf(pageSize));
        }else{
            sumPage = (sumData/Integer.valueOf(pageSize)) + 1;
        }
        Map<String,Object> result = new HashMap<>();
        result.put("webList",webList);
        result.put("currentPage",currentPage);
        result.put("pageSize",pageSize);
        result.put("sumPage",sumPage);
        result.put("sumData",sumData);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("数据加载完成");
        req.setResult(result);
        return req;
    }

    /**
     * 修改web状态
     */
    @Override
    public ReqResponse webStatus(Long userId, Long webId, Integer webStatus) {
        ReqResponse req = new ReqResponse();
        //查看当前app的上级id
        Long webParentId = webDao.webParent(webId);
        if(null != webParentId && userId.longValue() == webParentId.longValue()){
            //修改状态
            Map<String,Object> map = new HashMap<>();
            map.put("webId",webId);
            map.put("webStatus",webStatus);
            webDao.updateWebStatus(map);
            req.setCode(ErrorMessage.SUCCESS.getCode());
            req.setMessage("修改成功");
        }else{
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("您没有操作权限");
        }
        return req;
    }

    /**
     * 创建代码位信息
     */
    @Override
    public ReqResponse createAdspace(Long userId, Long webId, int terminal, String spaceName, int spaceType, String remark, int width, int height, String upstreamId, int upstreamType) {
        ReqResponse req = new ReqResponse();
        Long webParentId = webDao.webParent(webId);
        if(null != webParentId && userId.longValue() == webParentId.longValue() || userId == 1){
            //1查看此id有没有使用
            List<Integer> upstreamIdList = webDao.upstreamIdStatus(upstreamId);
            for (int i = 0; i < upstreamIdList.size(); i++){
                int status = upstreamIdList.get(i);
                if (status == 1){
                    req.setCode(ErrorMessage.FAIL.getCode());
                    req.setMessage("该ID被占用,请详查后再设置");
                    return req;
                }
            }
            //2查询上游id表有没有记录此id
            int upstreamIdNum = webDao.upstreamIdNum(upstreamId);
            if (upstreamIdNum == 0){
                //添加上游id
                WebUpstream webUpstream = new WebUpstream();
                webUpstream.setUpstreamId(upstreamId);
                webUpstream.setUpstreamType(spaceType);
                webUpstream.setCreateTime(new Date());
                webUpstream.setStatus(1);
                webDao.insertUpstream(webUpstream);
            }
            //3添加广告位信息,并绑定上游id
            WebAdspace ad = new WebAdspace();
            ad.setWebId(webId);
            ad.setUpstreamId(upstreamId);
            ad.setUpstreamType(upstreamType);
            ad.setTerminal(terminal);
            ad.setSpaceType(spaceType);
            ad.setSpaceName(spaceName);
            ad.setWidth(width);
            ad.setHeight(height);
            ad.setRemark(remark);
            ad.setStatus(1);
            webDao.createAdspace(ad);
            //4添加w_adspace_upstream表记录
            WebAdspaceUpstream wau = new WebAdspaceUpstream();
            wau.setSpaceId(ad.getSpaceId());
            wau.setUpstreamId(upstreamId);
            wau.setStartTime(new Date());
            webDao.insertAdspaceUpstream(wau);
            req.setCode(ErrorMessage.SUCCESS.getCode());
            req.setMessage("创建成功");
        }else{
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("您没有操作权限");
        }
        return req;
    }

    /**
     * 广告位列表
     */
    @Override
    public ReqResponse webAdspaceList(Long userId, String loginName, String nickName, String webId, String webName, String slotId, int terminal, int spaceType, Integer currentPage, Integer pageSize) {
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
        map.put("loginName",loginName);
        map.put("nickName",nickName);
        map.put("webId",webId);
        map.put("webName",webName);
        map.put("slotId",slotId);
        map.put("terminal",terminal);
        map.put("spaceType",spaceType);
        //查看当前用户身份
        int userLevel = userDao.userLevel(userId);
        map.put("userLevel",userLevel);
        map.put("userId",userId);
        //最高权限能看到所有的app信息,管理只能看到自己下级,普通用户只能看到自己的
        //app列表
        List<WebAdSpaceListVo> adspaceList = webDao.webAdspaceList(map);
        //app数量
        int sumData = webDao.webAdspaceListNum(map);
        //总页数
        int sumPage = 0;
        if(sumData%Integer.valueOf(pageSize) == 0){
            sumPage = (sumData/Integer.valueOf(pageSize));
        }else{
            sumPage = (sumData/Integer.valueOf(pageSize)) + 1;
        }
        Map<String,Object> result = new HashMap<>();
        result.put("adspaceList",adspaceList);
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
    public ReqResponse webDivided(int spaceId) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> webDivided = webDao.webDivided(spaceId);
        req.setResult(webDivided);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("成功");
        return req;
    }

    /**
     * 上传统计信息
     */
    @Override
    public ReqResponse addWebStatistics(Long userId, String statisticsList) throws Exception {
        ReqResponse req = new ReqResponse();
        if(null != statisticsList && !"".equals(statisticsList)){
            //解析前端传过来的集合数据
            ObjectMapper mapper = new ObjectMapper();
            JavaType jt = mapper.getTypeFactory().constructParametricType(ArrayList.class, WebStatistics.class);
            List<WebStatistics> list =  mapper.readValue(statisticsList, jt);
            int spaceId = list.get(0).getSpaceId();

            //查看广告位所属app的上级id
            Long parentId = webDao.adParentId(spaceId);
            if(userId.longValue() == parentId.longValue() || userId.longValue() == 1){
                //先查询分润比例
                Map<String,Object> webDivided = webDao.webDivided(spaceId);
                double x = Double.parseDouble(webDivided.get("dividedX").toString());
                double y = Double.parseDouble(webDivided.get("dividedY").toString());
                double z = Double.parseDouble(webDivided.get("dividedZ").toString());
                //计算点击率和ecmp
                //点击率=点击数/展现pv（以百分数形式呈现）
                //ecpm=收益*1000/展现pv
                for(int i = 0; i < list.size(); i++){
                    WebStatistics as = list.get(i);
                    as.setLookPV((int)(as.getBeforeLookPV() * z));
                    as.setClickNum((int)(as.getBeforeClickNum() * z));
                    as.setIncome(as.getBeforeIncome() * x * y);
                    as.setClickProbability((double)as.getClickNum()/(double)as.getLookPV()*100);
                    as.setEcpm(as.getIncome()*1000/(double)as.getLookPV());
                }
                webDao.addWebStatistics(list);
                req.setCode(ErrorMessage.SUCCESS.getCode());
                req.setMessage("添加成功");
            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您无权操作此APP");
            }
        }else{
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("参数错误");
        }
        return req;
    }

    /**
     * 查看WEB统计列表
     */
    @Override
    public ReqResponse webStatisticsUser(String startTime, String endTime, Long userId, String spaceName, String webName, Integer currentPage, Integer pageSize) {
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
        map.put("spaceName",spaceName);
        map.put("webName",webName);
        map.put("parentId",userId);
        map.put("startTime",startTime);
        map.put("endTime",endTime);
        //先查询当前用户身份
        int currentUserLevel = userDao.userLevel(userId);
        map.put("currentUserLevel",currentUserLevel);

        //查询集合列表
        List<WebStatisticsUser> statisticsList = webDao.webStatisticsUser(map);
        //总数量
        int sumData = webDao.webStatisticsUserNum(map);
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

    /**
     * 查看WEB统计列表
     */
    @Override
    public ReqResponse webStatisticsManage(String startTime, String endTime, Long userId, String spaceName, String webName, Integer currentPage, Integer pageSize) {
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
        map.put("spaceName",spaceName);
        map.put("webName",webName);
        map.put("parentId",userId);
        map.put("startTime",startTime);
        map.put("endTime",endTime);
        //先查询当前用户身份
        int currentUserLevel = userDao.userLevel(userId);
        map.put("currentUserLevel",currentUserLevel);

        //查询集合列表
        List<WebStatisticsManage> statisticsList = webDao.webStatisticsManage(map);
        //总数量
        int sumData = webDao.webStatisticsManageNum(map);
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


    /**
     * 修改id状态
     */
    @Override
    public ReqResponse idStatus(int spaceId, int status) {
        ReqResponse req = new ReqResponse();
        try{
            //0停用 1正常 2禁用
            Map<String,Object> map = new HashMap<>();
            map.put("spaceId",spaceId);
            map.put("status",status);
            WebAdspaceUpstream wau = webDao.selectAdspaceUpstream(spaceId);
            if (status == 1){
                //1查看此id有没有使用
                List<Integer> upstreamIdList = webDao.upstreamIdStatus(wau.getUpstreamId());
                for (int i = 0; i < upstreamIdList.size(); i++){
                    int idStatus = upstreamIdList.get(i);
                    if (idStatus == 1){
                        req.setCode(ErrorMessage.FAIL.getCode());
                        req.setMessage("该ID被其他用户使用");
                        return req;
                    }
                }
            }

            webDao.idStatus(map);

            //停用和禁用时,如果结束时间为空,则添加结束时间
            if (status == 0 || status == 2){
                if (null == wau.getEndTime()){
                    webDao.updateEndTime(wau);
                }
            }
            //如果是启用,则添加一条新数据
            if (status == 1){
                wau.setStartTime(new Date());
                webDao.insertAdspaceUpstream(wau);
            }

            req.setCode(ErrorMessage.SUCCESS.getCode());
            req.setMessage("成功");
        }catch (Exception e){
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("失败");
        }
        return req;
    }

    /**
     * 通过/删除数据
     */
    @Override
    public ReqResponse webStatisticsStatus(int statisticsId, int status) {
        ReqResponse req = new ReqResponse();
        //查看此id有没有被禁用
        int idStatus = webDao.adspaceIdStatus(statisticsId);
        if (idStatus == 1){
            //status 0删除 1通过
            if (status == 0){
                webDao.deleteStatistics(statisticsId);
                req.setCode(ErrorMessage.SUCCESS.getCode());
                req.setMessage("删除成功");
            }else if (status == 1){
                webDao.updateStatisticsStatus(statisticsId);
                req.setCode(ErrorMessage.SUCCESS.getCode());
                req.setMessage("通过成功");
            }else{
                req.setCode(ErrorMessage.PARAMETER_ILLEGAL.getCode());
                req.setMessage("参数错误");
            }
        }else{
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("该id被禁用或停用");
        }
        return req;
    }

    /**
     * 广告位divided
     */
    @Override
    public ReqResponse spaceDivided(int spaceId, double dividedY, double dividedZ) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        map.put("spaceId",spaceId);
        map.put("dividedY",dividedY);
        map.put("dividedZ",dividedZ);
        webDao.spaceDivided(map);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("成功");
        return req;
    }

    /**
     * 上游列表
     */
    @Override
    public ReqResponse webUpstreamTypeList(Integer currentPage, Integer pageSize) {
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

        //列表
        List<WebUpstreamType> list = webDao.webUpstreamTypeList(map);
        //总数量
        int sumData = webDao.webUpstreamTypeListNum(map);
        //总页数
        int sumPage = 0;
        if(sumData%Integer.valueOf(pageSize) == 0){
            sumPage = (sumData/Integer.valueOf(pageSize));
        }else{
            sumPage = (sumData/Integer.valueOf(pageSize)) + 1;
        }

        Map<String,Object> result = new HashMap<>();
        result.put("list",list);
        result.put("currentPage",currentPage);
        result.put("pageSize",pageSize);
        result.put("sumPage",sumPage);
        result.put("sumData",sumData);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("数据加载完成");
        req.setResult(result);
        return req;
    }

    /**
     * 设置上游分成比例
     */
    @Override
    public ReqResponse webUpstreamDivided(Integer upstreamType, double upstreamDivided) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        map.put("upstreamType",upstreamType);
        map.put("upstreamDivided",upstreamDivided);
        webDao.webUpstreamDivided(map);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("成功");
        return req;
    }

    /**
     * 查询数据
     */
    @Override
    public ReqResponse webStatisticsOne(int statisticsId) {
        ReqResponse req = new ReqResponse();
        WebStatisticsManage data =  webDao.webStatisticsOne(statisticsId);
        req.setResult(data);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("成功");
        return req;
    }

    /**
     * 修改数据
     */
    @Override
    public ReqResponse updateStatistics(double dividedY, double dividedZ, Integer lookPV, Integer clickNum, double income, double clickProbability, double ecpm, Integer spaceId, Integer statisticsId) {
        ReqResponse req = new ReqResponse();

        //1改yx
        Map<String,Object> map = new HashMap<>();
        map.put("spaceId",spaceId);
        map.put("dividedY",dividedY);
        map.put("dividedZ",dividedZ);
        webDao.spaceDivided(map);

        //2改数据
        Map<String,Object> m = new HashMap<>();
        m.put("lookPV",lookPV);
        m.put("clickNum",clickNum);
        m.put("income",income);
        m.put("clickProbability",clickProbability);
        m.put("ecpm",ecpm);
        m.put("statisticsId",statisticsId);
        webDao.updateStatistics(m);

        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("成功");
        return req;
    }

    @Resource
    private TaskDao taskDao;


    /**
     * 百度Excel
     */
    @Override
    public ReqResponse baiDuExcel(Sheet sheetAt) {
        int rowsOfSheet = sheetAt.getPhysicalNumberOfRows();
        List<WebStatistics> list = new ArrayList<>();
        // 第2行+--数据行
        for (int r = 1; r < rowsOfSheet; r++) {
            Row row = sheetAt.getRow(r);
            if (row == null) {
                continue;
            } else {
                int rowNum = row.getRowNum() + 1;
                //System.out.println("当前行:" + rowNum);
                row.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(8).setCellType(Cell.CELL_TYPE_STRING);
                String c1 = row.getCell(1).getStringCellValue();//第2列-代码位
                String c5 = row.getCell(5).getStringCellValue();//第6列-时间
                String c6 = row.getCell(6).getStringCellValue();//第7列-展现
                String c7 = row.getCell(7).getStringCellValue();//第8列-点击
                String c8 = row.getCell(8).getStringCellValue();//第9列-收入
                //代码位-时间-展现-点击-收入
                Map<String,Object> map = new HashMap<>();
                map.put("upstreamId",c1);
                map.put("date",c5);
                DividedVo dv = taskDao.dividedVo(map);
                if (null == dv){
                    System.out.println("不存在ID---"+c1);
                    continue;
                }else{
                    //查看有没有当日数据
                    int spaceId = dv.getSpaceId();
                    map.put("spaceId",spaceId);
                    int num = taskDao.statisticsNum(map);
                    //没有昨日数据,添加数据
                    if (num == 0){
                        System.out.println("ID---"+c1+"..."+dv.getSpaceId());
                        int show = Integer.valueOf(c6);//展现
                        int click = Integer.valueOf(c7);//点击
                        double income = Double.parseDouble(c8);//收入
                        double upstreamDivided = dv.getUpstreamDivided();
                        double dividedY = dv.getDividedY();
                        double dividedZ = dv.getDividedZ();
                        WebStatistics as = new WebStatistics();
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        Date d = null;
                        try {
                            d = sdf.parse(c5);
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                        as.setCreateTime(d);
                        as.setSpaceId(dv.getSpaceId());
                        as.setBeforeLookPV(show);
                        as.setBeforeClickNum(click);
                        as.setBeforeIncome(income);
                        as.setLookPV((int)(as.getBeforeLookPV() * dividedZ));
                        as.setClickNum((int)(as.getBeforeClickNum() * dividedZ));
                        as.setIncome(as.getBeforeIncome() * upstreamDivided * dividedY);
                        as.setClickProbability((double)as.getClickNum()*100/(double)as.getLookPV());
                        as.setEcpm(as.getIncome()*1000/(double)as.getLookPV());
                        list.add(as);
                    }
                    //有数据,跳过无操作
                    else{

                    }
                }
            }
        }
        if (list.size()>0){
            webDao.addWebStatistics(list);
        }
        return null;
    }

    /**
     * 百度Excel
     */
    @Override
    public ReqResponse webUploadExcel(Sheet sheet) {
        ReqResponse req = new ReqResponse();
        DecimalFormat df = new DecimalFormat("######0.00");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        int rowsOfSheet = sheet.getPhysicalNumberOfRows();
        List<WebStatisticsManage> list = new ArrayList<>();
        List upstreamIds = new ArrayList();
        // 第2行+--数据行
        for (int r = 1; r < rowsOfSheet; r++) {
            Row row = sheet.getRow(r);
            if (row == null) {
                continue;
            } else {
                int rowNum = row.getRowNum() + 1;//行数
                row.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
                row.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
                Date c1 = row.getCell(0).getDateCellValue();      //日期
                if (null == c1){
                    break;
                }
                String c2 = row.getCell(1).getStringCellValue();  //媒体id-上游id
                int c3 = Integer.valueOf(row.getCell(2).getStringCellValue());  //曝光
                int c4 = Integer.valueOf(row.getCell(3).getStringCellValue());  //点击
                double c5 = Double.parseDouble(row.getCell(4).getStringCellValue());  //结算金额
                double income = (double)(Math.round(c5*100)/100.0);
                System.out.println(c5);
                WebStatisticsManage ws = new WebStatisticsManage();
                ws.setCreate_Time(sdf.format(c1));
                ws.setCreateTime(c1);
                ws.setUpstreamId(c2);
                ws.setBeforeLookPV(c3);
                ws.setBeforeClickNum(c4);
                ws.setBeforeIncome(income);
                double beforeEcpm = (Math.round(ws.getBeforeIncome()*1000/ws.getBeforeLookPV()*100)/100.0);
                ws.setBeforeEcpm(beforeEcpm);
                list.add(ws);
                upstreamIds.add(c2);
            }
        }
        //去数据库匹配数据
        List<WebStatisticsManage> webList = webDao.matchId(upstreamIds);
        for(int i = 0; i < list.size(); i++){
            WebStatisticsManage el = list.get(i);
            for (int j = 0; j < webList.size(); j++){
                WebStatisticsManage web = webList.get(j);
                if (el.getUpstreamId().equals(web.getUpstreamId()) && el.getCreateTime().getTime() >= web.getStartTime().getTime() && el.getCreateTime().getTime() <= web.getEndTime().getTime()){
                    el.setSpaceName(web.getSpaceName());
                    el.setSpaceId(web.getSpaceId());
                    el.setDividedX(web.getDividedX());
                    el.setDividedY(web.getDividedY());
                    double income = Double.parseDouble(df.format(el.getBeforeIncome() * web.getDividedY() * web.getDividedX()));
                    el.setIncome(income);
                    double ecpm = (Math.round(income * 1000 / el.getBeforeLookPV()*100)/100.0);
                    el.setEcpm(ecpm);
                    break;
                }
            }
        }

        req.setResult(list);
        return req;
    }

    /**
     * 上传统计信息
     */
    @Override
    public ReqResponse addExcelWebStatistics(String statisticsList) throws Exception {
        ReqResponse req = new ReqResponse();
        if(null != statisticsList && !"".equals(statisticsList)){
            //解析前端传过来的集合数据
            ObjectMapper mapper = new ObjectMapper();
            JavaType jt = mapper.getTypeFactory().constructParametricType(ArrayList.class, WebStatistics.class);
            List<WebStatistics> list =  mapper.readValue(statisticsList, jt);
            for (WebStatistics w : list){
                w.setClickProbability((double)(w.getClickNum()*100)/w.getLookPV());
            }
            webDao.addWebStatistics(list);
            req.setCode(ErrorMessage.SUCCESS.getCode());
            req.setMessage("添加成功");
        }else{
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("参数错误");
        }
        return req;
    }

    /**
     * 消息
     * @param userId
     * @return
     */
    @Override
    public ReqResponse message(Long userId) {
        ReqResponse req = new ReqResponse();
        //查看今天有没有消息
        Map<String,Object> map = webDao.messageNum();
        if (null != map){
            //查看今天有没有读
            int num = webDao.unReadMessage(userId);
            if (num == 0){
                //提示,并改为已读
                map.put("userId",userId);
                map.put("msgId",map.get("id"));
                webDao.readMessage(map);
                req.setCode("300");
                req.setMessage(map.get("content").toString());
            }else{
                req.setCode("200");
            }
        }else{
            req.setCode("200");
        }
        return req;
    }

    /**
     * 上游id对应详细信息
     */
    @Override
    public ReqResponse webUpstreamIdMsg(String upstreamId) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> result = new HashMap<>();
        Map<String,Object> divided = webDao.divided(upstreamId);
        result.put("divided",divided);
        req.setResult(result);
        req.setMessage("完成");
        req.setCode(ErrorMessage.SUCCESS.getCode());
        return req;
    }

    /**
     * 多选通过
     */
    @Override
    public ReqResponse examinationPassed(String ids) {
        ReqResponse req = new ReqResponse();
        //解析前端传过来的集合数据
        ObjectMapper mapper = new ObjectMapper();
        JavaType jt = mapper.getTypeFactory().constructParametricType(ArrayList.class, String.class);
        try{
            List<String> list =  mapper.readValue(ids, jt);
            webDao.examinationPassed(list);
            req.setCode(ErrorMessage.SUCCESS.getCode());
            req.setMessage("审核成功");
        } catch (Exception e) {
            e.printStackTrace();
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("审核失败");
        }
        return req;
    }

}

