package com.news.service.impl;

import com.news.dao.NewsDao;
import com.news.entity.News;
import com.news.service.NewsService;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 新闻模块
 */
@Service("indexService")
public class NewsServiceImpl implements NewsService {

    @Resource
    private NewsDao newsDao;

    /**
     * 爬虫爬取新闻
     */
    @Override
    public ReqResponse getNews(int contentType) {
        ReqResponse req = new ReqResponse();
        List<News> list = new ArrayList<>();
        String url = "http://www.cnqiang.com/";
        String url2 = "";
        if(contentType == 1){
            url2 = "http://www.cnqiang.com/"; //1推荐
        }else if(contentType == 2){
            url2 = "http://www.cnqiang.com/hotnews/"; //2热点
        }else if(contentType == 3){
            url2 = "http://www.cnqiang.com/yule/"; //3娱乐
        }else if(contentType == 4){
            url2 = "http://www.cnqiang.com/keji2/"; //4科技
        }else if(contentType == 5){
            url2 = "http://www.cnqiang.com/tansuo/"; //5探索
        }else if(contentType == 6){
            url2 = "http://www.cnqiang.com/quwen/"; //6趣闻
        }else if(contentType == 7){
            url2 = "http://www.cnqiang.com/lishi/"; //7历史
        }else{
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的参数");
            return req;
        }

        try {
            //获取整个网页内容
            Document doc = Jsoup.connect(url2).get();
            //取得网页的li标签
            Elements liList = doc.select("li");
            for (Element element : liList) {
                News news = new News();
                //获取a标签
                Elements aList = element.getElementsByTag("a");
                //获取a标签的链接
                String hrefUrl = aList.attr("href");
                //判断hrefUrl的页面是以2开头的
                if(hrefUrl.indexOf("2")==0){
                    String newsUrl = url + hrefUrl;
                    //获取整个网页内容
                    Document d = Jsoup.connect(newsUrl).get();
                    //获取页面的标题
                    String title = d.select("h1").get(0).text();
                    news.setTitle(title);
                    //页面新闻内容
                    Element content = d.getElementById("article_content");
                    //时间和作者信息
                    String author = d.getElementsByClass("xg1").text();
                    news.setAuthor(author);
                    //内容图片需要拼接url路径
                    Elements imgs = content.getElementsByTag("img");
                    String pictureUrl = "";
                    for(Element img : imgs){
                        String src = img.attr("src");
                        if(src.indexOf("/")==0){
                            String imageUrl = "http://www.cnqiang.com" + img.attr("src");
                            img.attr("src",imageUrl);
                            pictureUrl = pictureUrl + imageUrl + ";";
                            continue;
                        }
                        pictureUrl = pictureUrl + src + ";";
                    }
                    news.setUrl(pictureUrl);
                    if(imgs.size()==0){
                        news.setType(0);
                    }else if(imgs.size()>=3){
                        news.setType(2);
                    }else{
                        news.setType(1);
                    }
                    news.setContent(content.toString());
                    news.setContentType(contentType);
                    list.add(news);
                }
            }
            //数据库批量新增
            newsDao.insertNews(list);
            req.setCode(ErrorMessage.SUCCESS.getCode());
            req.setMessage("完成");
        } catch (IOException e) {
            e.printStackTrace();
            req.setCode(ErrorMessage.SERVER_ERROR.getCode());
            req.setMessage("系统错误");
        }
        return req;
    }

    /**
     * 主页面-主列表
     */
    @Override
    public List<News> indexNews(String page, String contentType) {
        //contentType 1推荐 2热点 3娱乐 4科技 5探索 6趣闻 7历史
        Map<String,Object> map = new HashMap<>();
        if(null != page && !"".equals(page)){
            int num = (Integer.valueOf(page) - 1) * 10;
            map.put("num",num);
        }else{
            int num = 0;
            map.put("num",num);
        }
        map.put("contentType",Integer.valueOf(contentType));
        List<News> list = newsDao.indexNews(map);
        for(int i=0;i<list.size();i++){
            String [] pictureUrl = list.get(i).getUrl().split(";");
            List picture = new ArrayList();
            for(int j=0;j<pictureUrl.length;j++){
                picture.add(pictureUrl[j]);
            }
            list.get(i).setPictureUrl(picture);
        }
        return list;
    }

    /**
     * 主页面-热门列表
     */
    @Override
    public List<News> hotNews() {
        List<News> list = newsDao.hotNews();
        for(int i=0;i<list.size();i++){
            String [] pictureUrl = list.get(i).getUrl().split(";");
            list.get(i).setUrl(pictureUrl[0]);
        }
        return list;
    }

    /**
     * 新闻详情
     */
    @Override
    public News newDetails(Long newsId) {
        return newsDao.newsDetails(newsId);
    }

    /**
     * app端新闻数据加载
     */
    @Override
    public ReqResponse loadData(Integer currentPage, Integer sign) {
        ReqResponse req = new ReqResponse();
        Map<String,Object> map = new HashMap<>();
        map.put("currentPage",currentPage);
        map.put("sign",sign);
        List<News> newsList = newsDao.loadData(map);

        for(News n : newsList){
            String url = n.getUrl().split(";")[0];
            n.setUrl(url);
        }

        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setResult(newsList);
        req.setMessage("数据加载完成");
        return req;
    }
}
