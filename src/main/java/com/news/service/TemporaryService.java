package com.news.service;

import com.utils.response.ReqResponse;
import org.apache.poi.ss.usermodel.Sheet;

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

}
