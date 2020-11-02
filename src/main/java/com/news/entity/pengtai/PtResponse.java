package com.news.entity.pengtai;

import java.util.List;

public class PtResponse {

    private int resultCode;
    private String resultMessage;
    private List<PtApps> apps;

    public int getResultCode() {
        return resultCode;
    }

    public void setResultCode(int resultCode) {
        this.resultCode = resultCode;
    }

    public String getResultMessage() {
        return resultMessage;
    }

    public void setResultMessage(String resultMessage) {
        this.resultMessage = resultMessage;
    }

    public List<PtApps> getApps() {
        return apps;
    }

    public void setApps(List<PtApps> apps) {
        this.apps = apps;
    }
}
