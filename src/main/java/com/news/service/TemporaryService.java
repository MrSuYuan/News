package com.news.service;

import com.news.entity.YKAd;
import com.news.entity.YKAdvertiser;
import com.utils.response.ReqResponse;
import org.apache.poi.ss.usermodel.Sheet;

import java.util.List;

public interface TemporaryService {

    /**
     * 上传统计信息
     */
    ReqResponse addReport(String reportList)throws Exception;

    /**
     * 查看APP统计列表-管理
     */
    ReqResponse reportList(String adId, String startTime, String endTime,Integer currentPage, Integer pageSize);

    /**
     * 删除
     */
    ReqResponse deleteReport(long id);

    /**
     * 读取百度表格数据
     */
    ReqResponse readBDExcel(Sheet sheet);

    /**
     * 上传统计信息
     */
    ReqResponse addCopy(String copyList)throws Exception;

    /**
     * 读取百度表格数据
     */
    ReqResponse readBDExcelCopy(Sheet sheet) throws Exception;

    /**
     * 查看APP统计列表-管理
     */
    ReqResponse copyList(String adId, String startTime, String endTime,Integer currentPage, Integer pageSize);

    /**
     * 展示所有广告主信息
     */
    ReqResponse ykAdvertiserList();

    /**
     * 添加新广告主信息
     */
    ReqResponse addAdvertiser(YKAdvertiser advertiser) throws Exception ;

    /**
     * 删除新广告主信息
     */
    ReqResponse deleteAdvertiser(int id) throws Exception;

    /**
     * 展示所有广告信息
     */
    ReqResponse ykAdList();

    /**
     * 添加新广告信息
     */
    ReqResponse addYKAd(YKAd ykAd) throws Exception ;

    /**
     * 删除新广告信息
     */
    ReqResponse deleteAd(int crid);
}
