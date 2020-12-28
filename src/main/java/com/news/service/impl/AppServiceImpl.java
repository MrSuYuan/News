package com.news.service.impl;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.news.dao.AppDao;
import com.news.dao.UserDao;
import com.news.entity.*;
import com.news.service.AppService;
import com.news.vo.*;
import com.utils.id.AppIdUtil;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * APP模块
 */
@Service("appService")
public class AppServiceImpl implements AppService {

    @Resource
    private UserDao userDao;

    @Resource
    private AppDao appDao;

    /**
     * 行业分类
     */
    @Override
    public ReqResponse industy() {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        //大类
        List<Industy> rootType = appDao.rootType();
        //小类
        List<Industy> subType = appDao.subType();
        map.put("rootType",rootType);
        map.put("subType",subType);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("分类加载完成");
        req.setResult(map);
        return req;
    }

    /**
     * 查看归属用户
     */
    @Override
    public ReqResponse beLongUser(Long userId) {
        ReqResponse req = new ReqResponse();
        List<User> userList;
        if (userId == 1){
            userList = appDao.allUser();
        }else{
            userList = appDao.beLongUser(userId);
        }

        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("数据加载完成");
        req.setResult(userList);
        return req;
    }

    /**
     * 创建APP信息
     */
    @Override
    public ReqResponse createApp(Long currentUserId, Integer currentUserLevel, App app) {
        ReqResponse req = new ReqResponse();
        String appId = AppIdUtil.getAppId();
        System.out.println(appId);
        app.setAppId(appId);
        //查看app用户名是否可用
        /*int appName = appDao.appName(app.getAppName());
        if(appName > 0){
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("此APP名称已经存在");
            return req;
        }*/
        //封装剩余信息
        app.setAccessMethod(1);
        //个人填写app信息
        if(currentUserLevel == 3 || currentUserLevel == 1){
            appDao.createApp(app);
            req.setCode(ErrorMessage.SUCCESS.getCode());
            req.setMessage("添加成功");
        //管理员为下级填写app信息
        }else{
            //查看登录用户和app所属用户关系
            Map<String,Object> map = new HashMap<>();
            map.put("currentUserId",currentUserId);
            map.put("userId",app.getUserId());
            int count = userDao.userAndParent(map);
            if(count == 0){
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您没有操作权限");
            }else{
                appDao.createApp(app);
                req.setCode(ErrorMessage.SUCCESS.getCode());
                req.setMessage("添加成功");
            }
        }
        return req;
    }

    /**
     * APP列表
     */
    @Override
    public ReqResponse appList(Long currentUserId, String loginName, String nickName, String appId, String appName, Integer appStatus, Integer currentPage, Integer pageSize) {
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
        map.put("appId",appId);
        map.put("appName",appName);
        map.put("appStatus",appStatus);
        map.put("loginName",loginName);
        map.put("nickName",nickName);
        //查看当前用户身份
        int userLevel = userDao.userLevel(currentUserId);
        map.put("userLevel",userLevel);
        map.put("currentUserId",currentUserId);
        //最高权限能看到所有的app信息,管理只能看到自己下级,普通用户只能看到自己的
        //app列表
        List<AppListVo> appList = appDao.appList(map);
        //app数量
        int sumData = appDao.appListNum(map);
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

    /**
     * 修改app状态
     */
    @Override
    public ReqResponse appStatus(Long userId, String appId, Integer appStatus) {
        ReqResponse req = new ReqResponse();
        //查看当前app的上级id
        Long appParentId = appDao.appParent(appId);
        if(null != appParentId && userId.longValue() == appParentId.longValue()){
            //修改状态
            Map<String,Object> map = new HashMap<>();
            map.put("appId",appId);
            map.put("appStatus",appStatus);
            appDao.updateAppStatus(map);
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
    public ReqResponse createSlot(Long userId, String appId, int slotType, String slotName, int width, int height) {
        ReqResponse req = new ReqResponse();
        //广告位名称验重
        int slotNameNum = appDao.slotNameNum(slotName);
        if(slotNameNum == 0){
            //查看app上级id
            Long appParentId = appDao.appParent(appId);
            //查看app所属用户id
            Long appUserId = appDao.appUserId(appId);
            //自己,最高权限和上级都有资格添加广告位
            if(userId.longValue() == appParentId.longValue() || userId.longValue() == appUserId.longValue() || userId.longValue() == 1){
                AppSlot ad = new AppSlot();
                ad.setAppId(appId);
                ad.setSlotType(slotType);
                ad.setSlotName(slotName);
                ad.setWidth(width);
                ad.setHeight(height);
                ad.setSlotId(AppIdUtil.getSlotId());
                appDao.createSlot(ad);
                req.setCode(ErrorMessage.SUCCESS.getCode());
                req.setMessage("创建成功");

                /*//查看此app是否拥有同类型广告位(app每一种广告位只能有一种)
                int appSlotNum = appDao.appSlotNum(ad);
                if(appSlotNum == 0){

                }else{
                    req.setCode(ErrorMessage.FAIL.getCode());
                    req.setMessage("该类型广告位已存在");
                }*/

            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您没有操作权限");
            }
        }else{
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("广告位名称已存在");
        }
        return req;
    }

    /**
     * 广告位列表
     */
    @Override
    public ReqResponse appSlotList(Long userId, String loginName, String nickName, String appId, String slotId, int slotType, Integer currentPage, Integer pageSize) {
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
        map.put("slotType",slotType);
        map.put("loginName",loginName);
        map.put("nickName",nickName);
        map.put("appId",appId);
        map.put("slotId",slotId);
        //查看当前用户身份
        int userLevel = userDao.userLevel(userId);
        map.put("userLevel",userLevel);
        map.put("userId",userId);
        //最高权限能看到所有的app信息,管理只能看到自己下级,普通用户只能看到自己的
        //app列表
        List<AppSlotListVo> slotList = appDao.appSlotList(map);
        //app数量
        int sumData = appDao.appSlotListNum(map);
        //总页数
        int sumPage = 0;
        if(sumData%Integer.valueOf(pageSize) == 0){
            sumPage = (sumData/Integer.valueOf(pageSize));
        }else{
            sumPage = (sumData/Integer.valueOf(pageSize)) + 1;
        }
        Map<String,Object> result = new HashMap<>();
        result.put("slotList",slotList);
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
     * 放量
     * @param flowStatus 0停量 1放量
     */
    @Override
    public ReqResponse flowStatus(Long userId, String slotId, int flowStatus) {
        ReqResponse req = new ReqResponse();
        try{
            Map<String,Object> map = new HashMap<>();
            map.put("slotId",slotId);
            map.put("flowStatus",flowStatus);
            appDao.updateFlowStatus(map);
            req.setCode(ErrorMessage.SUCCESS.getCode());
            req.setMessage("设置成功");
        }catch(Exception e){
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("设置错误");
        }
        return req;
    }

    /**
     * 添加上游广告位信息
     */
    @Override
    public ReqResponse appAddUpstream(Long userId, String slotId, String upstreamId, String upstreamAppId, String upstreamAppName, String upstreamPackageName, int upstreamWidth, int upstreamHeight, int upstreamType, String vendorDivision) {
        ReqResponse req = new ReqResponse();
        //1.操作人员权限--查看广告位所属app的上级id
        Map<String,Object> parent = appDao.adParentId(slotId);
        if(userId.longValue() == (Long)parent.get("parentId") || userId.longValue() == 1){

            //添加上游广告位信息
            AppUpstream appUpstream = new AppUpstream();
            appUpstream.setCreateTime(new Date());
            appUpstream.setSlotId(slotId);
            appUpstream.setUpstreamId(upstreamId);
            appUpstream.setUpstreamAppId(upstreamAppId);
            appUpstream.setUpstreamType(upstreamType);
            appUpstream.setUpstreamPackageName(upstreamPackageName);
            appUpstream.setUpstreamAppName(upstreamAppName);
            appUpstream.setUpstreamWidth(upstreamWidth);
            appUpstream.setUpstreamHeight(upstreamHeight);
            //2.重复上游检测--查看此广告位有没有重复上游类型
            int appUpstreamNum = appDao.appUpstreamNum(appUpstream);
            if(appUpstreamNum == 0){

                //3.查看此上游id存不存在,有没有使用
                AppUpstream upstream = appDao.queryUpstream(upstreamId);
                //如果此id不存在,那就直接添加
                if (null == upstream){

                    //4-1.查看是不是划分机型的id,分机型
                    if (null != vendorDivision && !"".equals(vendorDivision)){

                        Map<String,Object> map = new HashMap<>();
                        map.put("slotId",slotId);
                        //查看有没有已经存在定向vendorDivision
                        map.put("vendorDivision",vendorDivision);
                        int slotVendorNum = appDao.slotVendor(map);
                        if (slotVendorNum > 0){
                            //比如已经存在了oppo定向id了,驳回新的oppo定向id申请
                            req.setCode(ErrorMessage.FAIL.getCode());
                            req.setMessage("此广告位已经包含指定机型定向ID");
                            return req;
                        }
                        appUpstream.setProbability(100);
                        appUpstream.setVendorDivision(vendorDivision);
                        //添加广告位信息
                        appDao.insertAppUpstream(appUpstream);
                        //将广告位改为分机型类型
                        map.put("vendorStatus",1);
                        appDao.updateVendorStatus(map);
                    }
                    //4-2.不分机型
                    else{
                        //如果是第一家(去除机型定向的id后),就添加调度信息100%,其余家都是0
                        int assignNum = appDao.assignNum(slotId);
                        if(assignNum == 0){
                            appUpstream.setProbability(100);
                        }else{
                            appUpstream.setProbability(0);
                        }
                        appUpstream.setVendorDivision(null);
                        //添加广告位信息
                        appDao.insertAppUpstream(appUpstream);

                    }

                }
                //id存在的时候分两种情况
                else{
                    //id存在未使用(如果此id已经存在,但是没有绑定平台信息,那就直接修改)
                    if (null == upstream.getSlotId() || "".equals(upstream.getSlotId())){

                        //4-1.查看是不是划分机型的id,分机型
                        if (null != vendorDivision && !"".equals(vendorDivision)){
                            Map<String,Object> map = new HashMap<>();
                            map.put("slotId",slotId);
                            //查看有没有已经存在定向vendorDivision
                            map.put("vendorDivision",vendorDivision);
                            int slotVendorNum = appDao.slotVendor(map);
                            if (slotVendorNum > 0){
                                //比如已经存在了oppo定向id了,驳回新的oppo定向id申请
                                req.setCode(ErrorMessage.FAIL.getCode());
                                req.setMessage("此广告位已经包含指定机型定向ID");
                                return req;
                            }
                            appUpstream.setProbability(100);
                            appUpstream.setVendorDivision(vendorDivision);
                            //修改广告位上游信息
                            appDao.updateAppUpstream(appUpstream);
                            //将广告位改为分机型类型
                            map.put("vendorStatus",1);
                            appDao.updateVendorStatus(map);
                        }
                        //4-2.不分机型
                        else{
                            //如果是第一家(去除机型定向的id后),就添加调度信息100%,其余家都是0
                            int assignNum = appDao.assignNum(slotId);
                            if(assignNum == 0){
                                appUpstream.setProbability(100);
                            }else{
                                appUpstream.setProbability(0);
                            }
                            appUpstream.setVendorDivision(null);
                            //修改广告位上游信息
                            appDao.updateAppUpstream(appUpstream);

                        }

                    }
                    //id存在已使用(如果此id已经存在,并且绑定了平台广告位,那就无法添加)
                    else{
                        req.setCode(ErrorMessage.FAIL.getCode());
                        req.setMessage("此上游广告位ID已经使用");
                        return req;
                    }
                }

                //添加广告位和上游的绑定信息(id使用记录)
                AppSlotUpstream au = new AppSlotUpstream();
                au.setSlotId(slotId);
                au.setUpstreamId(upstreamId);
                au.setUpstreamType(upstreamType);
                appDao.insertAppSlotUpstream(au);
                req.setCode(ErrorMessage.SUCCESS.getCode());
                req.setMessage("添加成功");

            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("该上游信息已经存在");
            }

        }else{
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("您无权操作此APP");
        }
        return req;
    }

    /**
     * 上游广告位列表
     */
    @Override
    public ReqResponse appUpstreamList(String slotId) {
        ReqResponse req = new ReqResponse();
        List<AppUpstream> list = appDao.appUpstreamList(slotId);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setResult(list);
        return req;
    }

    /**
     * 上传统计信息
     */
    @Override
    public ReqResponse addAppStatistics(Long userId,  int currentUserLevel, String statisticsList) throws Exception {
        ReqResponse req = new ReqResponse();
        if(null != statisticsList && !"".equals(statisticsList)){
            //解析前端传过来的集合数据
            ObjectMapper mapper = new ObjectMapper();
            JavaType jt = mapper.getTypeFactory().constructParametricType(ArrayList.class, AppStatistics.class);
            List<AppStatistics> list =  mapper.readValue(statisticsList, jt);
            String upstreamId = list.get(0).getUpstreamId();
            //查看广告位所属app的上级id
            Map<String,Object> parent = appDao.adParent(upstreamId);
            String appId = parent.get("appId").toString();
            if(currentUserLevel == 1 || userId.longValue() == (Long)parent.get("parentId")){
                //查看分润比例
                Map<String,Object> ud = appDao.divided(upstreamId);
                double x = Double.parseDouble(ud.get("dividedX").toString());
                double y = Double.parseDouble(ud.get("dividedY").toString());
                double z = Double.parseDouble(ud.get("dividedZ").toString());
                //计算点击率和ecmp
                //点击率=点击数/展现pv（以百分数形式呈现）
                //ecpm=收益*1000/展现pv
                for(int i = 0; i < list.size(); i++){
                    AppStatistics as = list.get(i);
                    as.setLookPV((int)(as.getBeforeLookPV() * z));
                    as.setClickNum((int)(as.getBeforeClickNum() * z));
                    as.setIncome(as.getBeforeIncome() * x * y);
                    as.setClickProbability((double)as.getClickNum()/(double)as.getLookPV()*100);
                    as.setEcpm(as.getIncome()*1000/(double)as.getLookPV());
                    as.setAppId(appId);
                    as.setSlotId(parent.get("slotId").toString());
                    as.setUpstreamId(upstreamId);
                }
                appDao.addAppStatistics(list);
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
     * 查看APP统计列表
     */
    @Override
    public ReqResponse appStatisticsList(String startTime, String endTime, Long userId, String slotName, String appName, Integer currentPage, Integer pageSize, Integer status) {
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
        map.put("slotName",slotName);
        map.put("appName",appName);
        //map.put("parentId",userId);
        map.put("startTime",startTime);
        map.put("endTime",endTime);
        map.put("status",status);
        //先查询当前用户身份
        int currentUserLevel = userDao.userLevel(userId);
        map.put("currentUserLevel",currentUserLevel);

        //查询集合列表
        List<AppStatisticsListVo> statisticsList = appDao.appStatisticsList(map);
        //总数量
        int sumData = appDao.appStatisticsListNum(map);
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
     * 查看APP统计列表-用户
     */
    @Override
    public ReqResponse appStatisticsUserList(int userLevel, String startTime, String endTime, Long userId, String slotName, String appName, Integer currentPage, Integer pageSize) {
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
        map.put("slotName",slotName);
        map.put("appName",appName);
        if (userLevel == 1 || userLevel == 2){
            map.put("parentId",null);
        }else{
            map.put("parentId",userId);
        }
        map.put("startTime",startTime);
        map.put("endTime",endTime);

        //查询集合列表
        List<AppStatisticsListVo> statisticsList = appDao.appStatisticsUserList(map);
        for(int i = 0; i < statisticsList.size(); i++){
            AppStatisticsListVo as = statisticsList.get(i);
            DecimalFormat df = new DecimalFormat("######0.00");
            as.setClickProbability(Double.parseDouble(df.format((double)as.getClickNum()/(double)as.getLookPV()*100)));
            as.setEcpm(Double.parseDouble(df.format(as.getIncome()*1000/(double)as.getLookPV())));
        }
        //总数量
        int sumData = appDao.appStatisticsUserListNum(map);
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
            appDao.examinationPassed(list);
            req.setCode(ErrorMessage.SUCCESS.getCode());
            req.setMessage("审核成功");
        } catch (Exception e) {
            e.printStackTrace();
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("审核失败");
        }
        return req;
    }

    /**
     * 上游列表
     */
    @Override
    public ReqResponse appUpstreamList(Integer currentPage, Integer pageSize) {
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

        //查询集合列表
        List<AppUpstreamType> appUpstreamTypeList = appDao.appUpstreamTypeList(map);
        int sumData = appDao.appUpstreamTypeNum(map);
        //总页数
        int sumPage = 0;
        if(sumData%Integer.valueOf(pageSize) == 0){
            sumPage = (sumData/Integer.valueOf(pageSize));
        }else{
            sumPage = (sumData/Integer.valueOf(pageSize)) + 1;
        }

        Map<String,Object> result = new HashMap<>();
        result.put("list",appUpstreamTypeList);
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
     * 全部上游
     */
    @Override
    public ReqResponse allAppUpstreamType() {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        map.put("num",0);
        map.put("pageSize",100);
        //查询集合列表
        List<AppUpstreamType> list = appDao.appUpstreamTypeList(map);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("数据加载完成");
        req.setResult(list);
        return req;
    }

    /**
     * 修改上游状态
     */
    @Override
    public ReqResponse updateUpstreamStatus(Integer id, Integer status) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        map.put("id",id);
        map.put("status",status);
        appDao.updateUpstreamStatus(map);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("数据加载完成");
        return req;
    }

    /**
     * 添加新上游
     */
    @Override
    public ReqResponse appUpstreamAdd(Integer type, String name, String shortName) {
        ReqResponse req = new ReqResponse();
        AppUpstreamType aut = new AppUpstreamType();
        aut.setType(type);
        aut.setName(name);
        aut.setShortName(shortName);
        aut.setCreateTime(new Date());
        aut.setStatus(0);
        appDao.appUpstreamAdd(aut);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("添加成功");
        return req;
    }

    /**
     * 上游广告位id列表
     */
    @Override
    public ReqResponse appUpstreamIdList(Integer currentPage, Integer pageSize, Integer type, String upstreamId) {
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
        map.put("type",type);
        map.put("upstreamId",upstreamId);

        //查询集合列表
        List<AppUpstreamIdList> appUpstreamIdList = appDao.appUpstreamIdList(map);
        int sumData = appDao.appUpstreamIdListNum(map);
        //总页数
        int sumPage = 0;
        if(sumData%Integer.valueOf(pageSize) == 0){
            sumPage = (sumData/Integer.valueOf(pageSize));
        }else{
            sumPage = (sumData/Integer.valueOf(pageSize)) + 1;
        }

        Map<String,Object> result = new HashMap<>();
        result.put("list",appUpstreamIdList);
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
     * 上游id对应详细信息
     */
    @Override
    public ReqResponse appUpstreamIdMsg(String upstreamId) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> result = new HashMap<>();
        AppUpstreamIdList msg = appDao.AppUpstreamIdMsg(upstreamId);
        Map<String,Object> divided = appDao.divided(upstreamId);
        result.put("msg",msg);
        result.put("divided",divided);
        req.setResult(result);
        req.setMessage("完成");
        req.setCode(ErrorMessage.SUCCESS.getCode());
        return req;
    }

    /**
     * 更换上游
     */
    @Override
    public ReqResponse changeUpstream(String upstreamId, String newUpstreamId, String newUpstreamAppId, Integer newUpstreamType, String newUpstreamPackageName) {
        ReqResponse req = new ReqResponse();
        try{
            //修改a_upstream表
            //修改a_ssign表
            Map<String,Object> map = appDao.check(upstreamId);
            String slotId = map.get("slotId").toString();
            map.put("slotId",slotId);
            map.put("upstreamId",upstreamId);
            map.put("upstreamType",map.get("upstreamType"));
            map.put("newUpstreamId",newUpstreamId);
            map.put("newUpstreamAppId",newUpstreamAppId);
            map.put("newUpstreamType",newUpstreamType);
            map.put("newUpstreamPackageName",newUpstreamPackageName);
            appDao.updateUpstream(map);
            //更新id结束的使用时间
            AppSlotUpstream au = new AppSlotUpstream();
            au.setSlotId(slotId);
            au.setUpstreamId(upstreamId);
            appDao.updateEndTime(au);
            //添加广告位和上游的绑定信息(id使用记录)
            AppSlotUpstream aau = new AppSlotUpstream();
            aau.setSlotId(slotId);
            aau.setUpstreamId(newUpstreamId);
            aau.setUpstreamType(newUpstreamType);
            appDao.insertAppSlotUpstream(aau);
            req.setMessage("更换成功");
            req.setCode(ErrorMessage.SUCCESS.getCode());
        }catch(Exception e){
            req.setMessage("系统错误");
            req.setCode(ErrorMessage.SERVER_ERROR.getCode());
        }
        return req;
    }

    /**
     * 删除上游ID
     */
    @Override
    public ReqResponse deleteUpstreamId(String upstreamId) {
        ReqResponse req = new ReqResponse();
        //删除上游id,假删除,解除绑定关系
        AppUpstream appUpstream = appDao.appUpstream(upstreamId);
        String vendorDivision = appUpstream.getVendorDivision();
        appDao.deleteUpstream(upstreamId);
        if (null != vendorDivision && !"".equals(vendorDivision)){
            String slotId = appUpstream.getSlotId();
            //解除绑定后看看这个id还没有绑定区分机型的id,没有就改变slot的机型区分状态
            System.out.println(slotId);
            int vendorIdNum = appDao.vendorIdNum(slotId);
            if (vendorIdNum == 0){
                //修改广告位机型区分的状态
                Map<String,Object> map = new HashMap<>();
                map.put("slotId",slotId);
                map.put("vendorStatus",0);
                appDao.updateVendorStatus(map);
            }
        }
        //更新id结束的使用时间
        AppSlotUpstream au = new AppSlotUpstream();
        au.setSlotId(appUpstream.getSlotId());
        au.setUpstreamId(upstreamId);
        appDao.updateEndTime(au);
        req.setMessage("删除成功");
        req.setCode(ErrorMessage.SUCCESS.getCode());
        return req;
    }

    /**
     * 设置上游分成比例
     */
    @Override
    public ReqResponse appUpstreamDivided(Integer upstreamType, double upstreamDivided) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        map.put("upstreamType",upstreamType);
        map.put("upstreamDivided",upstreamDivided);
        appDao.appUpstreamDivided(map);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("成功");
        return req;
    }

    /**
     * 调度分配展示(分流)
     */
    @Override
    public ReqResponse selectAppAssign(String slotId) {
        ReqResponse req = new ReqResponse();
        List<AppAssign> list = appDao.selectAppAssign(slotId);
        req.setResult(list);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        return req;
    }

    /**
     * 修改调度数据(分流)
     */
    @Override
    public ReqResponse assignSubmit(String list, String slotId){
        ReqResponse req = new ReqResponse();
        try{
            //解析前端传过来的集合数据
            ObjectMapper mapper = new ObjectMapper();
            JavaType jt = mapper.getTypeFactory().constructParametricType(ArrayList.class, AppAssignVo.class);
            List<AppAssignVo> assignList =  mapper.readValue(list, jt);
            int sumProbability = 0;
            List<AppUpstream> aList = new ArrayList<>();
            for (int i = 0; i < assignList.size(); i++){
                System.out.println(assignList.get(i).getVendorDivision());
                if (null == assignList.get(i).getVendorDivision() || "".equals(assignList.get(i).getVendorDivision())){
                    sumProbability += assignList.get(i).getProbability();
                    AppUpstream au = new AppUpstream();
                    au.setUpstreamType(assignList.get(i).getUpstreamType());
                    au.setProbability(assignList.get(i).getProbability());
                    au.setSlotId(slotId);
                    aList.add(au);
                }
            }
            if (sumProbability == 100){
                //批量修改
                appDao.updateAssignZ(aList);
                req.setCode(ErrorMessage.SUCCESS.getCode());
                req.setMessage("修改成功");
            }else{
                req.setCode(ErrorMessage.PARAMETER_ILLEGAL.getCode());
                req.setMessage("设置概率错误");
            }
        }catch(Exception e){
            req.setCode(ErrorMessage.SERVER_ERROR.getCode());
            req.setMessage("系统错误");
        }
        return req;
    }

    /**
     * 广告位详情
     */
    @Override
    public ReqResponse slotDetail(String slotId) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = appDao.slotDetail(slotId);
        req.setResult(map);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("成功");
        return req;
    }

    /**
     * 广告位divided
     */
    @Override
    public ReqResponse updateSlotDivided(String slotId, double dividedY, double dividedZ) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        map.put("slotId",slotId);
        map.put("dividedY",dividedY);
        map.put("dividedZ",dividedZ);
        appDao.updateSlotDivided(map);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("成功");
        return req;
    }

    /**
     * 数据统计状态修改 0删除 1通过
     */
    @Override
    public ReqResponse changeStatus(String statisticsId, int status) {
        ReqResponse resp = new ReqResponse();
        if (status == 0){
            appDao.deleteStatistics(statisticsId);
            resp.setCode(ErrorMessage.SUCCESS.getCode());
            resp.setMessage("删除成功");
        }else if (status == 1){
            appDao.changeStatus(statisticsId);
            resp.setCode(ErrorMessage.SUCCESS.getCode());
            resp.setMessage("通过成功");
        }else{
            resp.setCode(ErrorMessage.FAIL.getCode());
            resp.setMessage("参数错误");
        }
        return resp;
    }

    /**
     * 读取表格数据
     */
    @Override
    public ReqResponse readUCExcel(Sheet sheet) {
        ReqResponse req = new ReqResponse();
        DecimalFormat df = new DecimalFormat("######0.00");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        int rowsOfSheet = sheet.getPhysicalNumberOfRows();
        List<UCStatisticsList> list = new ArrayList<>();
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
                row.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
                Date c1 = row.getCell(0).getDateCellValue();
                double c2 = Double.parseDouble(row.getCell(1).getStringCellValue());
                String c3 = row.getCell(2).getStringCellValue();
                String c4 = row.getCell(3).getStringCellValue();
                String c5 = row.getCell(4).getStringCellValue();
                int c6 = Integer.valueOf(row.getCell(5).getStringCellValue());
                UCStatisticsList uc = new UCStatisticsList();
                uc.setCreate_Time(sdf.format(c1));
                uc.setCreateTime(c1);
                uc.setBeforeIncome(c2);
                uc.setUpstreamName(c3);
                uc.setUpstreamId(c5);
                uc.setBeforeLookPV(c6);
                double beforeEcpm = uc.getBeforeIncome()*1000/uc.getBeforeLookPV();
                uc.setBeforeEcpm(df.format(beforeEcpm));
                list.add(uc);
                upstreamIds.add(c5);
            }
        }
        //去数据库匹配数据
        List<UCStatisticsList> appList = appDao.queryExcel(upstreamIds);
        for(int i = 0; i < list.size(); i++){
            UCStatisticsList uc = list.get(i);
            for (int j = 0; j < appList.size(); j++){
                UCStatisticsList app = appList.get(j);
                if (uc.getUpstreamId().equals(app.getUpstreamId()) && uc.getCreateTime().getTime() >= app.getStartTime().getTime() && uc.getCreateTime().getTime() <= app.getEndTime().getTime()){
                    uc.setNickName(app.getNickName());
                    uc.setAppId(app.getAppId());
                    uc.setAppName(app.getAppName());
                    uc.setSlotId(app.getSlotId());
                    uc.setDividedY(app.getDividedY());
                    double afterIncome = Double.parseDouble(df.format(uc.getBeforeIncome() * app.getDividedY()));
                    uc.setIncome(afterIncome);
                    double afterEcpm = afterIncome * 1000 / uc.getBeforeLookPV();
                    uc.setAfterEcpm(df.format(afterEcpm));
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
    public ReqResponse addAppStatisticsUC(String statisticsList) throws Exception {
        ReqResponse req = new ReqResponse();
        if(null != statisticsList && !"".equals(statisticsList)){
            //解析前端传过来的集合数据
            ObjectMapper mapper = new ObjectMapper();
            JavaType jt = mapper.getTypeFactory().constructParametricType(ArrayList.class, AppStatistics.class);
            List<AppStatistics> list =  mapper.readValue(statisticsList, jt);
            for (AppStatistics a : list){
                if (a.getBeforeLookPV() != 0){
                    double d = a.getBeforeClickNum();
                    a.setClickProbability(d*100/a.getBeforeLookPV());
                }else{
                    a.setClickProbability(0);
                }
            }
            appDao.addAppStatistics(list);
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
    public ReqResponse readExcel(Sheet sheet) {
        ReqResponse req = new ReqResponse();
        DecimalFormat df = new DecimalFormat("######0.00");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        int rowsOfSheet = sheet.getPhysicalNumberOfRows();
        List<UCStatisticsList> list = new ArrayList<>();
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
                String c2 = row.getCell(1).getStringCellValue();  //媒体id
                int c3 = Integer.valueOf(row.getCell(2).getStringCellValue());  //曝光
                int c4 = Integer.valueOf(row.getCell(3).getStringCellValue());  //点击
                double c5 = Double.parseDouble(row.getCell(4).getStringCellValue());  //结算金额
                UCStatisticsList uc = new UCStatisticsList();
                uc.setCreate_Time(sdf.format(c1));
                uc.setCreateTime(c1);
                uc.setUpstreamId(c2);
                uc.setBeforeLookPV(c3);
                uc.setBeforeClickNum(c4);
                uc.setBeforeIncome(c5);
                double beforeEcpm = uc.getBeforeIncome()*1000/uc.getBeforeLookPV();
                uc.setBeforeEcpm(df.format(beforeEcpm));
                list.add(uc);
                upstreamIds.add(c2);
            }
        }
        //去数据库匹配数据
        List<UCStatisticsList> appList = appDao.matchId(upstreamIds);
        for(int i = 0; i < list.size(); i++){
            UCStatisticsList uc = list.get(i);
            for (int j = 0; j < appList.size(); j++){
                UCStatisticsList app = appList.get(j);
                if (uc.getUpstreamId().equals(app.getUpstreamId()) && uc.getCreateTime().getTime() >= app.getStartTime().getTime() && uc.getCreateTime().getTime() <= app.getEndTime().getTime()){
                    uc.setNickName(app.getNickName());
                    uc.setAppId(app.getAppId());
                    uc.setAppName(app.getAppName());
                    uc.setSlotId(app.getSlotId());
                    uc.setDividedY(app.getDividedY());
                    double afterIncome = Double.parseDouble(df.format(uc.getBeforeIncome() * app.getDividedY()));
                    uc.setIncome(afterIncome);
                    double afterEcpm = afterIncome * 1000 / uc.getBeforeLookPV();
                    uc.setAfterEcpm(df.format(afterEcpm));
                    break;
                }
            }
        }

        req.setResult(list);
        return req;
    }


    /**
     * 读取表格数据
     */
    @Override
    public ReqResponse readOtherExcel(Sheet sheet) {
        ReqResponse req = new ReqResponse();
        DecimalFormat df = new DecimalFormat("######0.00");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        int rowsOfSheet = sheet.getPhysicalNumberOfRows();
        List<UCStatisticsList> list = new ArrayList<>();
        List slotIds = new ArrayList();
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
                String c2 = row.getCell(1).getStringCellValue();  //平台id
                int c3 = Integer.valueOf(row.getCell(2).getStringCellValue());  //曝光
                int c4 = Integer.valueOf(row.getCell(3).getStringCellValue());  //点击
                double c5 = Double.parseDouble(row.getCell(4).getStringCellValue());  //结算金额
                UCStatisticsList uc = new UCStatisticsList();
                uc.setCreate_Time(sdf.format(c1));
                uc.setCreateTime(c1);
                System.out.println(c2.trim());
                uc.setSlotId(c2.trim());
                uc.setBeforeLookPV(c3);
                uc.setBeforeClickNum(c4);
                uc.setBeforeIncome(c5);
                double beforeEcpm = uc.getBeforeIncome()*1000/uc.getBeforeLookPV();
                uc.setBeforeEcpm(df.format(beforeEcpm));
                list.add(uc);
                slotIds.add(c2);
            }
        }
        //去数据库匹配数据
        List<UCStatisticsList> appList = appDao.AsSlotId(slotIds);
        for(int i = 0; i < list.size(); i++){
            UCStatisticsList uc = list.get(i);
            for (int j = 0; j < appList.size(); j++){
                UCStatisticsList app = appList.get(j);
                if (uc.getSlotId().equals(app.getSlotId()) && uc.getCreateTime().getTime() >= app.getStartTime().getTime() && uc.getCreateTime().getTime() <= app.getEndTime().getTime()){
                    uc.setNickName(app.getNickName());
                    uc.setAppId(app.getAppId());
                    uc.setAppName(app.getAppName());
                    uc.setUpstreamId(app.getUpstreamId());
                    uc.setDividedY(app.getDividedY());
                    double afterIncome = Double.parseDouble(df.format(uc.getBeforeIncome() * app.getDividedY()));
                    uc.setIncome(afterIncome);
                    double afterEcpm = afterIncome * 1000 / uc.getBeforeLookPV();
                    uc.setAfterEcpm(df.format(afterEcpm));
                    break;
                }
            }
        }

        req.setResult(list);
        return req;
    }

    @Override
    public void insertParam(String data){
        appDao.insertParam(data);
    }

    @Override
    public void excel(long userId, String startTime, String endTime, Integer currentPage, OutputStream out) {
        Map<String,Object> map = new HashMap<>();
        map.put("userId",userId);
        map.put("startTime",startTime);
        map.put("endTime",endTime);
        List<AppStatisticsListVo> list = appDao.excel(map);
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
        cell.setCellValue("时间");
        cell.setCellStyle(style);

        cell = row.createCell(1);
        cell.setCellValue("APPID");
        cell.setCellStyle(style);

        cell = row.createCell(2);
        cell.setCellValue("广告位ID");
        cell.setCellStyle(style);

        cell = row.createCell(3);
        cell.setCellValue("APP名称");
        cell.setCellStyle(style);

        cell = row.createCell(4);
        cell.setCellValue("广告位名称");
        cell.setCellStyle(style);

        cell = row.createCell(5);
        cell.setCellValue("展现");
        cell.setCellStyle(style);

        cell = row.createCell(6);
        cell.setCellValue("点击");
        cell.setCellStyle(style);

        cell = row.createCell(7);
        cell.setCellValue("收益");
        cell.setCellStyle(style);

        cell = row.createCell(8);
        cell.setCellValue("ecpm");
        cell.setCellStyle(style);

        // 循环将数据写入Excel
        for (int i = 0; i < list.size(); i++) {
            row = sheet.createRow(i + 1);
            AppStatisticsListVo alv= list.get(i);
            // 创建单元格，设置值
            row.createCell(0).setCellValue(alv.getCreateTime());
            row.createCell(1).setCellValue(alv.getAppId());
            row.createCell(2).setCellValue(alv.getSlotId());
            row.createCell(3).setCellValue(alv.getAppName());
            row.createCell(4).setCellValue(alv.getSlotName());
            row.createCell(5).setCellValue(alv.getLookPV());
            row.createCell(6).setCellValue(alv.getClickNum());
            row.createCell(7).setCellValue(alv.getIncome());
            DecimalFormat df = new DecimalFormat("######0.00");
            String ecpm = df.format(alv.getIncome()*1000/alv.getLookPV());
            row.createCell(8).setCellValue(ecpm);
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
