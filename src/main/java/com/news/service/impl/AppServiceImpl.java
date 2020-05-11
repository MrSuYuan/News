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
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
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
        List<User> userList = appDao.beLongUser(userId);
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
        if(currentUserLevel == 3){
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
    public ReqResponse appList(Long currentUserId, String appId, String appName, Integer appStatus, String nickName, Integer currentPage, Integer pageSize) {
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
    public ReqResponse createAdspace(Long userId, String appId, int spaceType, String spaceName, int width, int height) {
        ReqResponse req = new ReqResponse();
        //广告位名称验重
        int spaceNameNum = appDao.spaceNameNum(spaceName);
        if(spaceNameNum == 0){
            //查看app上级id
            Long appParentId = appDao.appParent(appId);
            //查看app所属用户id
            Long appUserId = appDao.appUserId(appId);
            //自己和上级都有资格添加广告位
            if(userId.longValue() == appParentId.longValue() || userId.longValue() == appUserId.longValue()){
                AppAdspace ad = new AppAdspace();
                ad.setAppId(appId);
                ad.setSpaceType(spaceType);
                ad.setSpaceName(spaceName);
                ad.setWidth(width);
                ad.setHeight(height);
                ad.setSpaceId(AppIdUtil.getSpaceId());
                appDao.createAdspace(ad);
                req.setCode(ErrorMessage.SUCCESS.getCode());
                req.setMessage("创建成功");

                /*//查看此app是否拥有同类型广告位(app每一种广告位只能有一种)
                int appSpaceNum = appDao.appSpaceNum(ad);
                if(appSpaceNum == 0){

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
    public ReqResponse appAdspaceList(Long userId, String nickName, String appName, String spaceName, int spaceType, Integer currentPage, Integer pageSize) {
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
        map.put("appName",appName);
        map.put("spaceName",spaceName);
        map.put("spaceType",spaceType);
        map.put("nickName",nickName);
        //查看当前用户身份
        int userLevel = userDao.userLevel(userId);
        map.put("userLevel",userLevel);
        map.put("userId",userId);
        //最高权限能看到所有的app信息,管理只能看到自己下级,普通用户只能看到自己的
        //app列表
        List<AppAdspaceListVo> adspaceList = appDao.appAdspaceList(map);
        //app数量
        int sumData = appDao.appAdspaceListNum(map);
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

    /**
     * 添加上游广告位信息
     */
    @Override
    public ReqResponse appAdUpstream(Long userId, String spaceId, String upstreamId, String upstreamAppId, String upstreamPackageName, int upstreamType) {
        ReqResponse req = new ReqResponse();
        //查看广告位所属app的上级id
        Map<String,Object> parent = appDao.adParentId(spaceId);
        if(userId.longValue() == (Long)parent.get("parentId")){
            //查询此上游广告位id是否存在
            int upstreamIdNum = appDao.upstreamIdNum(upstreamId);
            if (upstreamIdNum > 0){
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("此上游广告位ID已经存在");
                return req;
            }

            //添加上游广告位信息
            AppUpstream appUpstream = new AppUpstream();
            appUpstream.setCreateTime(new Date());
            appUpstream.setSpaceId(spaceId);
            appUpstream.setUpstreamId(upstreamId);
            appUpstream.setUpstreamAppId(upstreamAppId);
            appUpstream.setUpstreamType(upstreamType);
            appUpstream.setUpstreamPackageName(upstreamPackageName);
            //查看此广告位有没有重复上游类型
            int appUpstreamNum = appDao.appUpstreamNum(appUpstream);
            if(appUpstreamNum == 0){
                //添加广告位信息
                appDao.insertAppUpstream(appUpstream);
                //如果是第一家,就添加调度信息100%,其余家都是0
                int assignNum = appDao.assignNum(spaceId);
                if(assignNum == 0){
                    AppAssign appAssign = new AppAssign();
                    appAssign.setSpaceId(spaceId);
                    appAssign.setProbability(100);
                    appAssign.setUpstreamType(upstreamType);
                    appDao.insertAssign(appAssign);
                }else{
                    AppAssign appAssign = new AppAssign();
                    appAssign.setSpaceId(spaceId);
                    appAssign.setProbability(0);
                    appAssign.setUpstreamType(upstreamType);
                    appDao.insertAssign(appAssign);
                }
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
    public ReqResponse appUpstreamList(String spaceId) {
        ReqResponse req = new ReqResponse();
        List<AppUpstream> list = appDao.appUpstreamList(spaceId);
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
                    as.setEcmp(as.getIncome()*1000/(double)as.getLookPV());
                    as.setAppId(appId);
                    as.setSpaceId(parent.get("spaceId").toString());
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
    public ReqResponse appStatisticsList(String startTime, String endTime, Long userId, String spaceName, String appName, Integer currentPage, Integer pageSize) {
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
        map.put("appName",appName);
        map.put("parentId",userId);
        map.put("startTime",startTime);
        map.put("endTime",endTime);
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
    public ReqResponse appStatisticsUserList(int userLevel, String startTime, String endTime, Long userId, String spaceName, String appName, Integer currentPage, Integer pageSize) {
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
            as.setEcmp(Double.parseDouble(df.format(as.getIncome()*1000/(double)as.getLookPV())));
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
            map.put("spaceId",map.get("spaceId"));
            map.put("upstreamId",upstreamId);
            map.put("upstreamType",map.get("upstreamType"));
            map.put("newUpstreamId",newUpstreamId);
            map.put("newUpstreamAppId",newUpstreamAppId);
            map.put("newUpstreamType",newUpstreamType);
            map.put("newUpstreamPackageName",newUpstreamPackageName);
            appDao.updateUpstream(map);
            appDao.updateAssign(map);
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
        AppUpstream appUpstream = appDao.appUpstream(upstreamId);
        appDao.deleteUpstream(upstreamId);
        appDao.deleteAssign(appUpstream);
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
     * 调度分配展示
     */
    @Override
    public ReqResponse selectAppAssign(String spaceId) {
        ReqResponse req = new ReqResponse();
        List<AppAssign> list = appDao.selectAppAssign(spaceId);
        Map<String,Object> map = new HashMap<>();
        for(int i=0;i<list.size();i++){
            AppAssign aa = list.get(i);
            if(aa.getUpstreamType() == 1){
                map.put("df",aa.getProbability());
                continue;
            }else if(aa.getUpstreamType() == 2){
                map.put("wk",aa.getProbability());
                continue;
            }else if(aa.getUpstreamType() == 3){
                map.put("jg",aa.getProbability());
                continue;
            }else if(aa.getUpstreamType() == 4){
                map.put("yl",aa.getProbability());
                continue;
            }else if(aa.getUpstreamType() == 5){
                map.put("ydt",aa.getProbability());
                continue;
            }else if(aa.getUpstreamType() == 6){
                map.put("xz",aa.getProbability());
                continue;
            }else if(aa.getUpstreamType() == 7){
                map.put("wm",aa.getProbability());
                continue;
            }else if(aa.getUpstreamType() == 8){
                map.put("yq",aa.getProbability());
                continue;
            }else if(aa.getUpstreamType() == 9){
                map.put("dk",aa.getProbability());
                continue;
            }else if(aa.getUpstreamType() == 10){
                map.put("mjk",aa.getProbability());
                continue;
            }else if(aa.getUpstreamType() == 11){
                map.put("jl",aa.getProbability());
                continue;
            }else if(aa.getUpstreamType() == 12){
                map.put("zm",aa.getProbability());
                continue;
            }else if(aa.getUpstreamType() == 13){
                map.put("hy",aa.getProbability());
                continue;
            }else{
                continue;
            }
        }
        req.setResult(list);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        return req;
    }

    /**
     * 广告位统计
     */
    @Override
    public ReqResponse appReportList(String appId, String slotId, String startTime, String endTime, Integer currentPage, Integer pageSize) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        map.put("appId",appId);
        map.put("slotId",slotId);
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
        List<AdStatisticsListVo> list = appDao.appReportList(map);
        int sumData = appDao.appReportListNum(map);

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

    @Override
    public ReqResponse appUpstreamReport(String downstreamReportId) {
        ReqResponse req = new ReqResponse();
        List<AdReportUpstreamListVo> appReportDetail = appDao.appUpstreamReport(downstreamReportId);
        req.setMessage("数据加载完成");
        req.setResult(appReportDetail);
        req.setCode("200");
        return req;
    }

    /**
     * 广告位统计
     */
    @Override
    public ReqResponse appReportNewList(String startTime, String endTime, String appId, String slotId, Integer currentPage, Integer pageSize) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        map.put("appId",appId);
        map.put("slotId",slotId);
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
        //总和
        List<AdStatisticsListVo> list = appDao.appReportNewList(map);
        int sumData = appDao.appReportNewListNum(map);

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

    @Override
    public ReqResponse appReportDetail(String appId, String slotId, String createTime) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        map.put("appId",appId);
        map.put("slotId",slotId);
        map.put("createTime",createTime);
        List<AdReportUpstreamListVo> appReportDetail = appDao.appReportDetail(map);
        req.setMessage("数据加载完成");
        req.setResult(appReportDetail);
        req.setCode("200");
        return req;
    }

    /**
     * 修改调度数据
     */
    @Override
    public ReqResponse assignSubmit(String list, String spaceId){
        ReqResponse req = new ReqResponse();
        try{
            //解析前端传过来的集合数据
            ObjectMapper mapper = new ObjectMapper();
            JavaType jt = mapper.getTypeFactory().constructParametricType(ArrayList.class, AppAssignVo.class);
            List<AppAssignVo> assignList =  mapper.readValue(list, jt);
            int sumProbability = 0;
            List<AppAssign> aList = new ArrayList<>();
            for (int i = 0; i < assignList.size(); i++){
                sumProbability += assignList.get(i).getProbability();
                AppAssign dfa = new AppAssign();
                dfa.setUpstreamType(assignList.get(i).getUpstreamType());
                dfa.setProbability(assignList.get(i).getProbability());
                dfa.setSpaceId(spaceId);
                aList.add(dfa);
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
    public ReqResponse adspaceDetail(String spaceId) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = appDao.adspaceDetail(spaceId);
        req.setResult(map);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("成功");
        return req;
    }

    /**
     * 广告位divided
     */
    @Override
    public ReqResponse updateSpaceDivided(String spaceId, double dividedY, double dividedZ) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        map.put("spaceId",spaceId);
        map.put("dividedY",dividedY);
        map.put("dividedZ",dividedZ);
        appDao.updateSpaceDivided(map);
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
     * 填补upsteram表assign概率
     */
    @Override
    public ReqResponse assign() {
        ReqResponse resp = new ReqResponse();
        /**
         * 查询所有a_assign表数据
         */
        List<AppAssign> assignList = appDao.assignList();

        /**
         * 修改a_upstream表assign概率数据
         */
        appDao.upstreamAssign(assignList);
        resp.setCode("200");
        return resp;
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
                row.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
                Date c1 = row.getCell(0).getDateCellValue();
                double c2 = Double.parseDouble(row.getCell(1).getStringCellValue());
                String c3 = row.getCell(2).getStringCellValue();
                String c4 = row.getCell(3).getStringCellValue();
                String c5 = row.getCell(4).getStringCellValue();
                int c6 = Integer.valueOf(row.getCell(5).getStringCellValue());
                UCStatisticsList uc = new UCStatisticsList();
                uc.setCreate_Time(sdf.format(c1));
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
                if (uc.getUpstreamId().equals(app.getUpstreamId())){
                    uc.setNickName(app.getNickName());
                    uc.setAppId(app.getAppId());
                    uc.setAppName(app.getAppName());
                    uc.setSpaceId(app.getSpaceId());
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
            System.out.println(list.get(0).getLookPV());
            appDao.addAppStatistics(list);
            req.setCode(ErrorMessage.SUCCESS.getCode());
            req.setMessage("添加成功");
        }else{
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("参数错误");
        }
        return req;
    }


}
