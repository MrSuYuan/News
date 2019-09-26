package com.news.vo;

import java.util.Date;

public class ReportVo {
    private Long id;
    private Date createTime;
    private String adId;
    private String adSize;
    private String address;
    private String adName;
    private int lookPv;
    private double income;
    private int clickNum;
    private double ecpm;
    private double clickProbability;
    private double cpc;
    private String ecpm2;
    private String clickProbability2;
    private String cpc2;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getAdId() {
        return adId;
    }

    public void setAdId(String adId) {
        this.adId = adId;
    }

    public String getAdSize() {
        return adSize;
    }

    public void setAdSize(String adSize) {
        this.adSize = adSize;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAdName() {
        return adName;
    }

    public void setAdName(String adName) {
        this.adName = adName;
    }

    public int getLookPv() {
        return lookPv;
    }

    public void setLookPv(int lookPv) {
        this.lookPv = lookPv;
    }

    public double getIncome() {
        return income;
    }

    public void setIncome(double income) {
        this.income = income;
    }

    public int getClickNum() {
        return clickNum;
    }

    public void setClickNum(int clickNum) {
        this.clickNum = clickNum;
    }

    public double getEcpm() {
        return ecpm;
    }

    public void setEcpm(double ecpm) {
        this.ecpm = ecpm;
    }

    public double getClickProbability() {
        return clickProbability;
    }

    public void setClickProbability(double clickProbability) {
        this.clickProbability = clickProbability;
    }

    public double getCpc() {
        return cpc;
    }

    public void setCpc(double cpc) {
        this.cpc = cpc;
    }

    public String getEcpm2() {
        return ecpm2;
    }

    public void setEcpm2(String ecpm2) {
        this.ecpm2 = ecpm2;
    }

    public String getClickProbability2() {
        return clickProbability2;
    }

    public void setClickProbability2(String clickProbability2) {
        this.clickProbability2 = clickProbability2;
    }

    public String getCpc2() {
        return cpc2;
    }

    public void setCpc2(String cpc2) {
        this.cpc2 = cpc2;
    }
}
