package com.news.entity;

import java.util.Date;

public class User {
    /**
     * id
     */
    private Long userId;
    /**
     * 用户名
     */
    private String loginName;
    /**
     * 密码
     */
    private String passWord;
    /**
     * 昵称
     */
    private String nickName;
    /**
     * 性别(1男 2女)
     */
    private int sex;
    /**
     * 上级id
     */
    private Long parentId;
    /**
     * 用户等级(1超管 2管理员 3普通用户)
     */
    private int userLevel;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 用户状态 0正常 1禁用
     */
    private int userStatus;
    /**
     * 用户头像
     */
    private String userUrl;
    /**
     * 管理员Logo
     */
    private String logo;

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public int getSex() {
        return sex;
    }

    public void setSex(int sex) {
        this.sex = sex;
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public int getUserLevel() {
        return userLevel;
    }

    public void setUserLevel(int userLevel) {
        this.userLevel = userLevel;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public int getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(int userStatus) {
        this.userStatus = userStatus;
    }

    public String getUserUrl() {
        return userUrl;
    }

    public void setUserUrl(String userUrl) {
        this.userUrl = userUrl;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }
}
