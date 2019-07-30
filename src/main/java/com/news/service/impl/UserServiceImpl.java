package com.news.service.impl;

import com.news.dao.UserDao;
import com.news.entity.Login;
import com.news.entity.User;
import com.news.service.UserService;
import com.news.vo.UserListVo;
import com.utils.MD5.MD5Util;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 用户模块
 */
@Service("userService")
public class UserServiceImpl implements UserService {

    @Resource
    private UserDao userDao;


    /**
     * 用户登录方法
     */
    @Override
    public ReqResponse userLogin(Login login) {
        ReqResponse req = new ReqResponse();
        User user = userDao.user(login.getLoginName());
        if(null == user){
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("用户信息不存在");
            return req;
        }else{
            if(user.getPassWord().equals(MD5Util.hexSALT(login.getPassWord(),"zghd"))){
                if(user.getUserStatus() == 2){
                    req.setCode(ErrorMessage.FAIL.getCode());
                    req.setMessage("当前帐号被禁用,请联系管理员");
                    return req;
                }else{
                    req.setCode(ErrorMessage.SUCCESS.getCode());
                    req.setMessage("登录成功");
                    req.setResult(user);
                    return req;
                }
            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("密码错误");
                return req;
            }
        }
    }

    /**
     * 修改密码
     */
    @Override
    public ReqResponse updatePassWord(Long userId, String oldPassWord, String passWord, String confirmPassWord) {
        ReqResponse req = new ReqResponse();
        if(passWord.equals(confirmPassWord)){
            //查询原密码
            String p = userDao.passWord(userId);
            if(MD5Util.hexSALT(oldPassWord,"zghd").equals(p)){
                //修改新密码
                User user = new User();
                user.setUserId(userId);
                user.setPassWord(MD5Util.hexSALT(passWord,"zghd"));
                userDao.updatePassWord(user);
                req.setCode(ErrorMessage.SUCCESS.getCode());
                req.setMessage("密码修改成功");

            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("旧密码输入错误");
            }

        }else{
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("两次输入的密码不一致");
        }
        return req;
    }

    /**
     * 创建新用户
     */
    @Override
    public ReqResponse createUser(Long userId, String loginName, String passWord, String confirmPassWord, String nickName) {
        ReqResponse req = new ReqResponse();
        if(passWord.equals(confirmPassWord)){
            //查询账号是否存在
            User u = userDao.user(loginName);
            if(null == u){
                //添加用户信息
                User user = new User();
                //查询当前用户身份
                int currentUserLevel = userDao.userLevel(userId);
                if(currentUserLevel == 1){
                    user.setUserLevel(2);
                }else if(currentUserLevel == 2){
                    user.setUserLevel(3);
                }else{
                    req.setCode(ErrorMessage.FAIL.getCode());
                    req.setMessage("当前用户身份获取失败");
                    return req;
                }
                user.setLoginName(loginName);
                user.setPassWord(MD5Util.hexSALT(passWord,"zghd"));
                user.setNickName(nickName);
                user.setParentId(userId);
                //添加新用户信息
                userDao.createUser(user);
                req.setCode(ErrorMessage.SUCCESS.getCode());
                req.setMessage("创建新用户成功");

            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("账号信息已存在");
            }

        }else{
            req.setCode(ErrorMessage.FAIL.getCode());
            req.setMessage("两次输入的密码不相同");
        }
        return req;
    }

    /**
     * 用户列表
     */
    @Override
    public ReqResponse userList(Long userId, String loginName, String nickName, Integer userLevel, Integer userStatus, Integer currentPage, Integer pageSize) {
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
        map.put("userStatus",userStatus);
        map.put("userLevel",userLevel);
        map.put("parentId",userId);
        //先查询当前用户身份
        int currentUserLevel = userDao.userLevel(userId);
        map.put("currentUserLevel",currentUserLevel);

        List<UserListVo> userList = userDao.userList(map);
        int sumData = userDao.userListSumData(map);
        //总页数
        int sumPage = 0;
        if(sumData%Integer.valueOf(pageSize) == 0){
            sumPage = (sumData/Integer.valueOf(pageSize));
        }else{
            sumPage = (sumData/Integer.valueOf(pageSize)) + 1;
        }

        Map<String,Object> result = new HashMap<>();
        result.put("userList",userList);
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
     * 禁用/启用用户状态
     */
    @Override
    public ReqResponse userStatus(Long currentUserId, Long userId, Integer userStatus) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        map.put("currentUserId",currentUserId);
        map.put("userId",userId);
        map.put("userStatus",userStatus);
        //查看当前登录用户的权限
        int userLevel = userDao.userLevel(currentUserId);
        //最高权限,可以修改
        if(userLevel == 1){
            userDao.userStatus(map);
        }else{
            //查看被操作用户和当前用户的绑定关系
            int count = userDao.userAndParent(map);
            if (count == 0){
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("对不起,您没有操作权限");
            }else{
                userDao.userStatus(map);
            }
        }
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("修改成功");
        return req;
    }

    public static void main(String[] args) {
        //点击率=点击数/展现pv（以百分数形式呈现）
        //ecpm=收益*1000/展现pv
        int i = 156;
        int j = 265;
        //点击率
        System.out.println((double)i/(double)j*100);

        double a = 10.56 * 1000;
        double b = 8.74;
        System.out.println(a/b);

        //System.out.println(MD5Util.hexSALT("zghd","zghd"));
    }

}
