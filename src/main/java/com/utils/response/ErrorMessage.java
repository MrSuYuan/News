package com.utils.response;

/**
 * 系统错误信息定义
 * @Date: 2019年7月10日16:22:52
 */
public enum ErrorMessage {

    /**
     * 成功
     */
    SUCCESS("200","SUCCESS")
    /**
     * 参数不合法
     */
    ,PARAMETER_ILLEGAL("100","参数不合法")
    /**
     * 系统处理错误
     */
    ,SERVER_ERROR("500","系统处理错误")
    /**
     * 失败
     */
    ,FAIL("400","失败")
    /**
     * 用户未登录
     */
    ,USER_NO_LOGIN("600","用户未登录")
    /**
     * 无效的登陆
     */
    ,INVALID_LOGIN("300","无效的登陆")
    ;

    //错误码
    private String code;
    //错误描述
    private String message;

    private ErrorMessage(String code,String message)
    {
        this.code=code;
        this.message=message;
    }

    /**
     * 错误描述
     * @return
     */
    public String getMessage()
    {
        return this.message;
    }
    /**
     * 错误码
     * @return
     */
    public String getCode() {
        return this.code;
    }




}
