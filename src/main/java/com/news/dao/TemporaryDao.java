package com.news.dao;

import com.news.entity.Copy;
import com.news.entity.Report;
import com.news.entity.YKAd;
import com.news.entity.YKAdvertiser;
import com.news.vo.CopyVo;
import com.news.vo.ReportVo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("temporaryDao")
public interface TemporaryDao {

    void addReport(List<Report> list);

    List<ReportVo> reportList(Map<String,Object> map);

    int reportListNum(Map<String,Object> map);

    void addCopy(List<Copy> list);

    List<CopyVo> copyList(Map<String,Object> map);

    int copyListNum(Map<String,Object> map);

    void deleteReport(long id);

    List<YKAdvertiser> ykAdvertiserList();

    void deleteAdvertiser(int id);

    void addAdvertiser(YKAdvertiser advertiser);

    YKAdvertiser ykAdvertiser(int id);

    List<YKAd> ykAdList();

    void addYKAd(YKAd ykAd);

    void deleteAd(int id);

}
