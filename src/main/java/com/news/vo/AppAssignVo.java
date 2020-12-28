package com.news.vo;

public class AppAssignVo {

    private int upstreamType;
    private int probability;
    private String vendorDivision;

    public String getVendorDivision() {
        return vendorDivision;
    }

    public void setVendorDivision(String vendorDivision) {
        this.vendorDivision = vendorDivision;
    }

    public int getUpstreamType() {
        return upstreamType;
    }

    public void setUpstreamType(int upstreamType) {
        this.upstreamType = upstreamType;
    }

    public int getProbability() {
        return probability;
    }

    public void setProbability(int probability) {
        this.probability = probability;
    }
}
