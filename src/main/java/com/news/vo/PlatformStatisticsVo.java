package com.news.vo;

import java.util.List;

/**
 * 平台分时统计
 */
public class PlatformStatisticsVo {

    //总请求
    private int sumRequest;
    //总返回
    private int sumResponse;
    //总曝光
    private int sumLook;
    //总点击
    private int sumClick;
    //总deepLink
    private int sumDeeplink;
    private int t300;
    private int t400;
    private int t500;
    private int t1000;
    private List<PlatformStatisticsListVo> list;

    public int getT300() {
        return t300;
    }

    public void setT300(int t300) {
        this.t300 = t300;
    }

    public int getT400() {
        return t400;
    }

    public void setT400(int t400) {
        this.t400 = t400;
    }

    public int getT500() {
        return t500;
    }

    public void setT500(int t500) {
        this.t500 = t500;
    }

    public int getT1000() {
        return t1000;
    }

    public void setT1000(int t1000) {
        this.t1000 = t1000;
    }

    public List<PlatformStatisticsListVo> getList() {
        return list;
    }

    public void setList(List<PlatformStatisticsListVo> list) {
        this.list = list;
    }

    public int getSumRequest() {
        return sumRequest;
    }

    public void setSumRequest(int sumRequest) {
        this.sumRequest = sumRequest;
    }

    public int getSumResponse() {
        return sumResponse;
    }

    public void setSumResponse(int sumResponse) {
        this.sumResponse = sumResponse;
    }

    public int getSumLook() {
        return sumLook;
    }

    public void setSumLook(int sumLook) {
        this.sumLook = sumLook;
    }

    public int getSumClick() {
        return sumClick;
    }

    public void setSumClick(int sumClick) {
        this.sumClick = sumClick;
    }

    public int getSumDeeplink() {
        return sumDeeplink;
    }

    public void setSumDeeplink(int sumDeeplink) {
        this.sumDeeplink = sumDeeplink;
    }
}
