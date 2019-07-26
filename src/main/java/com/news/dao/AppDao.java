package com.news.dao;

import com.news.entity.App;
import com.news.entity.Industy;
import com.news.entity.User;
import com.news.vo.AppListVo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * APP模块
 */
@Repository("appDao")
public interface AppDao {

    /**
     * 查看行业分类大类
     */
    List<Industy> rootType();

    /**
     * 查看行业分类小类
     */
    List<Industy> subType();

    /**
     * 查询此管理下的用户
     */
    List<User> beLongUser(Long userId);

    /**
     * 添加APP信息
     */
    void createApp(App app);

    /**
     * app名称验重
     */
    int appName(String appName);

    /**
     * app列表
     */
    List<AppListVo> appList(Map<String,Object> map);

    /**
     * app列表数量
     */
    int appListNum(Map<String,Object> map);

    /**
     * 查看当前app的上级id
     */
    Long appParent(Long appId);

    /**
     * 修改app状态
     */
    void updateAppStatus(Map<String,Object> map);

}
