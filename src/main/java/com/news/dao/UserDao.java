package com.news.dao;

import com.news.entity.User;
import com.news.entity.UserDivided;
import com.news.vo.UserListVo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 用户模块
 */
@Repository("userDao")
public interface UserDao {

    /**
     * 用户登录
     */
    User user(String loginName);

    /**
     * 查询密码
     */
    String passWord(Long userId);

    /**
     * 修改密码
     */
    void updatePassWord(User user);

    /**
     * 创建新用户
     */
    void createUser(User user);

    /**
     * 查询当前用户身份
     */
    int userLevel(Long userId);

    /**
     * 查询用户列表
     */
    List<UserListVo> userList(Map<String,Object> map);

    /**
     * 查询用户列表数量
     */
    int userListSumData(Map<String,Object> map);

    /**
     * 查看被操作用户和当前用户的绑定关系
     */
    int userAndParent(Map<String,Object> map);

    /**
     * 修改用户状态
     */
    void userStatus(Map<String,Object> map);

    /**
     * 创建分成比例
     */
    void insertUserDivided(Long userId);

    /**
     * 查看分成比例
     */
    UserDivided selectDivided(UserDivided userDivided);

    /**
     * 修改分成比例
     */
    void updateProportion(UserDivided userDivided);

    /**
     * 为老客户添加密码项
     */
    void updateMiMa(User user);

}
