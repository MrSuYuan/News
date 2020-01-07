package com.news.service.impl;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.news.dao.UserDao;
import com.news.dao.WebDao;
import com.news.entity.*;
import com.news.service.WebService;
import com.news.vo.*;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
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

        //个人填写信息
        if(currentUserLevel == 3){
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
    public ReqResponse webList(Long userId, Long webId, String webName, Integer webStatus, Integer currentPage, Integer pageSize) {
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
        map.put("webId",webId);
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
        if(null != webParentId && userId.longValue() == webParentId.longValue()){
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
    public ReqResponse webAdspaceList(Long userId, String webName, String spaceName, int terminal, int spaceType, Integer currentPage, Integer pageSize) {
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
        map.put("webName",webName);
        map.put("terminal",terminal);
        map.put("spaceName",spaceName);
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
            if(userId.longValue() == parentId.longValue()){
                //查看分润比例
                UserDivided ud = new UserDivided();
                ud.setType(2);
                ud.setUserId(userId);
                ud = userDao.selectDivided(ud);
                //计算点击率和ecmp
                //点击率=点击数/展现pv（以百分数形式呈现）
                //ecpm=收益*1000/展现pv
                for(int i = 0; i < list.size(); i++){
                    WebStatistics as = list.get(i);
                    as.setLookPV((int)(as.getBeforeLookPV() * ud.getLookProportion()));
                    as.setClickNum((int)(as.getBeforeClickNum() * ud.getClickProportion()));
                    as.setIncome(as.getBeforeIncome() * ud.getUpstreamProportion() * ud.getUserProportion());
                    as.setClickProbability((double)as.getClickNum()/(double)as.getLookPV()*100);
                    as.setEcmp(as.getIncome()*1000/(double)as.getLookPV());
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
            Map<String,Object> map = new HashMap<>();
            map.put("spaceId",spaceId);
            map.put("status",status);
            webDao.idStatus(map);
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
        //status 0删除 1通过
        if (status == 0){
            webDao.deleteStatistics(statisticsId);
            req.setCode(ErrorMessage.SUCCESS.getCode());
            req.setMessage("成功");
        }else if (status == 1){
            webDao.updateStatisticsStatus(statisticsId);
            req.setCode(ErrorMessage.SUCCESS.getCode());
            req.setMessage("成功");
        }else{
            req.setCode(ErrorMessage.PARAMETER_ILLEGAL.getCode());
            req.setMessage("参数错误");
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
    public ReqResponse updateStatistics(double dividedY, double dividedZ, Integer lookPV, Integer clickNum, double income, double clickProbability, double ecmp, Integer spaceId, Integer statisticsId) {
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
        m.put("ecmp",ecmp);
        m.put("statisticsId",statisticsId);
        webDao.updateStatistics(m);

        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("成功");
        return req;
    }
}
