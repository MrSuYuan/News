package com.news.vo;

/**
 * 用户列表
 */
public class UserListVo {

    /**
     * id
     */
    private Long userId;
    /**
     * 用户名
     */
    private String loginName;
    /**
     * 昵称
     */
    private String nickName;
    /**
     * 上级id
     */
    private String parentName;
    /**
     * 用户等级(1超管 2管理员 3普通用户)
     */
    private int userLevel;
    /**
     * 创建时间
     */
    private String createTime;
    /**
     * 用户状态 0正常 1禁用
     */
    private int userStatus;

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

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public int getUserLevel() {
        return userLevel;
    }

    public void setUserLevel(int userLevel) {
        this.userLevel = userLevel;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public int getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(int userStatus) {
        this.userStatus = userStatus;
    }
}
