package com.news.vo;

import java.util.List;

/**
 * 渠道分时统计-求和
 */
public class ChannelStatisticsSumListVo {

    private String name;
    private String upstreamId;
    private int upstreamType;
    private int request;
    private int response;
    private int look;
    private int click;
    private int deeplink;
    private int t300;
    private int t400;
    private int t500;
    private int t1000;
    private List<ChannelStatisticsListVo> list;

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

    public List<ChannelStatisticsListVo> getList() {
        return list;
    }

    public void setList(List<ChannelStatisticsListVo> list) {
        this.list = list;
    }

    public String getUpstreamId() {
        return upstreamId;
    }

    public void setUpstreamId(String upstreamId) {
        this.upstreamId = upstreamId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getUpstreamType() {
        return upstreamType;
    }

    public void setUpstreamType(int upstreamType) {
        this.upstreamType = upstreamType;
    }

    public int getRequest() {
        return request;
    }

    public void setRequest(int request) {
        this.request = request;
    }

    public int getResponse() {
        return response;
    }

    public void setResponse(int response) {
        this.response = response;
    }

    public int getLook() {
        return look;
    }

    public void setLook(int look) {
        this.look = look;
    }

    public int getClick() {
        return click;
    }

    public void setClick(int click) {
        this.click = click;
    }

    public int getDeeplink() {
        return deeplink;
    }

    public void setDeeplink(int deeplink) {
        this.deeplink = deeplink;
    }
}
