package com.news.service.impl;

import com.news.dao.UserDao;
import com.news.entity.Login;
import com.news.entity.User;
import com.news.service.UserService;
import com.utils.MD5.MD5Util;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * 用户模块
 */
@Service("userService")
public class UserServiceImpl implements UserService {

    @Resource
    private UserDao userDao;

    public static void main(String[] args) {
        System.out.println(MD5Util.hexSALT("zghd","zghd"));
    }

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
                if(user.getUserStatus() == 0){
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
}
