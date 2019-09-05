package com.news.service.impl;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.news.dao.AppDao;
import com.news.dao.UserDao;
import com.news.entity.*;
import com.news.service.AppService;
import com.news.vo.AppAdspaceListVo;
import com.news.vo.AppListVo;
import com.news.vo.AppStatisticsListVo;
import com.news.vo.UserListVo;
import com.utils.id.AppIdUtil;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
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
        int appName = appDao.appName(app.getAppName());
        if(appName > 0){
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("此APP名称已经存在");
            return req;
        }
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
    public ReqResponse appList(Long userId, String appId, String appName, Integer appStatus, Integer currentPage, Integer pageSize) {
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
        //查看当前用户身份
        int userLevel = userDao.userLevel(userId);
        map.put("userLevel",userLevel);
        map.put("userId",userId);
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
                //查看此app是否拥有同类型广告位(app每一种广告位只能有一种)
                int appSpaceNum = appDao.appSpaceNum(ad);
                if(appSpaceNum == 0){
                    appDao.createAdspace(ad);
                    req.setCode(ErrorMessage.SUCCESS.getCode());
                    req.setMessage("创建成功");
                }else{
                    req.setCode(ErrorMessage.FAIL.getCode());
                    req.setMessage("该类型广告位已存在");
                }

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
    public ReqResponse appAdspaceList(Long userId, String appName, String spaceName, int spaceType, Integer currentPage, Integer pageSize) {
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
    public ReqResponse appAdUpstream(Long userId, String spaceId, String upstreamId, String upstreamAppId, int upstreamType) {
        ReqResponse req = new ReqResponse();
        //查看广告位所属app的上级id
        Map<String,Object> parent = appDao.adParentId(spaceId);
        if(userId.longValue() == (Long)parent.get("parentId")){
            //添加上游广告位信息
            AppUpstream appUpstream = new AppUpstream();
            appUpstream.setCreateTime(new Date());
            appUpstream.setSpaceId(spaceId);
            appUpstream.setUpstreamId(upstreamId);
            appUpstream.setUpstreamAppId(upstreamAppId);
            appUpstream.setUpstreamType(upstreamType);
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
    public ReqResponse addAppStatistics(Long userId, String statisticsList) throws Exception {
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
            if(userId.longValue() == (Long)parent.get("parentId")){
                //计算点击率和ecmp
                //点击率=点击数/展现pv（以百分数形式呈现）
                //ecpm=收益*1000/展现pv
                for(int i = 0; i < list.size(); i++){
                    AppStatistics as = list.get(i);
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
    public ReqResponse appStatisticsList(Long userId, String spaceName, String appName, Integer currentPage, Integer pageSize) {
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
    public ReqResponse appStatisticsUserList(Long userId, String spaceName, String appName, Integer currentPage, Integer pageSize) {
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
     * 调度分配展示
     */
    @Override
    public ReqResponse selectAppAssign(String spaceId) {
        ReqResponse req = new ReqResponse();
        List<AppAssign> list = appDao.selectAppAssign(spaceId);
        Map<String,Object> map = new HashMap<>();
        for(int i=0;i<list.size();i++){
            AppAssign aa = list.get(i);
            //正式
            if(aa.getType() == 1){
                if(aa.getUpstreamType() == 1){
                    map.put("dfz",aa.getProbability());
                    continue;
                }else if(aa.getUpstreamType() == 2){
                    map.put("wkz",aa.getProbability());
                    continue;
                }else if(aa.getUpstreamType() == 3){
                    map.put("jgz",aa.getProbability());
                    continue;
                }else if(aa.getUpstreamType() == 4){
                    map.put("ylz",aa.getProbability());
                    continue;
                }else if(aa.getUpstreamType() == 5){
                    map.put("ydtz",aa.getProbability());
                    continue;
                }else{
                    continue;
                }

            //测试
            }else if(aa.getType() == 2){
                if(aa.getUpstreamType() == 1){
                    map.put("dfc",aa.getProbability());
                    continue;
                }else if(aa.getUpstreamType() == 2){
                    map.put("wkc",aa.getProbability());
                    continue;
                }else if(aa.getUpstreamType() == 3){
                    map.put("jgc",aa.getProbability());
                    continue;
                }else if(aa.getUpstreamType() == 4){
                    map.put("ylc",aa.getProbability());
                    continue;
                }else if(aa.getUpstreamType() == 5){
                    map.put("ydtc",aa.getProbability());
                    continue;
                }else{
                    continue;
                }

            }
        }
        req.setResult(map);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        return req;
    }

    /**
     * 修改调度数据
     */
    @Override
    public ReqResponse assignSubmit(int df, int wk, int jg, int yl, int ydt, int type) {
        ReqResponse req = new ReqResponse();
        if(df + wk + jg + yl + ydt == 100){
            List<AppAssign> aList = new ArrayList<>();

            AppAssign dfa = new AppAssign();
            dfa.setUpstreamType(1);
            dfa.setProbability(df);
            aList.add(dfa);

            AppAssign wka = new AppAssign();
            wka.setUpstreamType(2);
            wka.setProbability(wk);
            aList.add(wka);

            AppAssign jga = new AppAssign();
            jga.setUpstreamType(3);
            jga.setProbability(jg);
            aList.add(jga);

            AppAssign yla = new AppAssign();
            yla.setUpstreamType(4);
            yla.setProbability(yl);
            aList.add(yla);

            AppAssign ydta = new AppAssign();
            ydta.setUpstreamType(5);
            ydta.setProbability(ydt);
            aList.add(ydta);
            System.out.println(aList.size());
            //批量修改
            if(type == 1){
                appDao.updateAssignZ(aList);
                req.setCode(ErrorMessage.SUCCESS.getCode());
                req.setMessage("修改成功");
            }else if(type == 2){
                appDao.updateAssignC(aList);
                req.setCode(ErrorMessage.SUCCESS.getCode());
                req.setMessage("修改成功");
            }else{
                req.setCode(ErrorMessage.PARAMETER_ILLEGAL.getCode());
                req.setMessage("参数不合法");
            }
        }else{
            req.setCode(ErrorMessage.PARAMETER_ILLEGAL.getCode());
            req.setMessage("设置概率错误");
        }
        return req;
    }
}
