package com.utils.http;

import org.apache.http.HttpEntity;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.config.Registry;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.conn.socket.ConnectionSocketFactory;
import org.apache.http.conn.socket.PlainConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.TrustSelfSignedStrategy;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpRequestRetryHandler;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.ssl.SSLContextBuilder;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

public class TestConnectionPool {

    private static PoolingHttpClientConnectionManager poolConnManager = null;

    private static CloseableHttpClient httpClient;

    private static RequestConfig requestConfig;

    static {
        SSLContextBuilder builder = new SSLContextBuilder();
        try {
            builder.loadTrustMaterial(null, new TrustSelfSignedStrategy());
            SSLConnectionSocketFactory sslConnectionSocketFactory = new SSLConnectionSocketFactory(builder.build());
            // 配置同时支持 HTTP 和 HTPPS
            Registry<ConnectionSocketFactory> socketFactoryRegistry = RegistryBuilder.<ConnectionSocketFactory>create().register(
                    "http", PlainConnectionSocketFactory.getSocketFactory()).register(
                    "https", sslConnectionSocketFactory).build();

            // 初始化连接管理器
            poolConnManager = new PoolingHttpClientConnectionManager(
                    socketFactoryRegistry);
            // 将最大连接数增加到200，实际项目最好从配置文件中读取这个值
            poolConnManager.setMaxTotal(500);
            // 设置最大路由
            poolConnManager.setDefaultMaxPerRoute(20);
            // 根据默认超时限制初始化requestConfig
            int socketTimeout = 400;
            int connectTimeout = 400;
            int connectionRequestTimeout = 400;
            requestConfig = RequestConfig.custom().setConnectionRequestTimeout(
                    connectionRequestTimeout).setSocketTimeout(socketTimeout).setConnectTimeout(
                    connectTimeout)
                    .build();

            // 初始化httpClient
            httpClient = getConnection();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (KeyStoreException e) {
            e.printStackTrace();
        } catch (KeyManagementException e) {
            e.printStackTrace();
        }
    }

    public static CloseableHttpClient getConnection() {
        CloseableHttpClient httpClient = HttpClients.custom()
                // 设置连接池管理
                .setConnectionManager(poolConnManager)
                // 设置请求配置
                .setDefaultRequestConfig(requestConfig)
                // 设置重试次数
                .setRetryHandler(new DefaultHttpRequestRetryHandler(0, false))
                .build();

        if (poolConnManager != null && poolConnManager.getTotalStats() != null) {
            System.out.println("now client pool " + poolConnManager.getTotalStats().toString());
        }

        return httpClient;
    }

    /**
     * 设置头信息
     * @param httpRequestBase
     */
    private static void config(HttpRequestBase httpRequestBase, List<HeaderEntity> list) {
        httpRequestBase.setHeader("Accept-Encoding", "utf-8");
        if (null != list){
            for (HeaderEntity he : list){
                httpRequestBase.addHeader(he.getJian(), he.getZhi());
            }
        }
        //httpRequestBase.setHeader("Accept-Encoding", "utf-8");
        //httpRequestBase.setHeader("User-Agent", "Mozilla/5.0");
        // httpRequestBase
        // .setHeader("Accept",
        // "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
        // httpRequestBase.setHeader("Accept-Language",
        // "zh-CN,zh;q=0.8,en-US;q=0.5,en;q=0.3");// "en-US,en;q=0.5");
        // httpRequestBase.setHeader("Accept-Charset",
        // "ISO-8859-1,utf-8,gbk,gb2312;q=0.7,*;q=0.7");

    }

    /**
     * get 请求
     */
    public static String get(String url, List<HeaderEntity> list) {
        HttpGet httpget = new HttpGet(url);
        // 设置请求头，可以根据不同的请求设置不同的请求头 具体根据需求
        httpget.addHeader("Content-Type","application/json");
        httpget.addHeader("Accept", "application/json");
        config(httpget, list);

        CloseableHttpResponse response = null;
        try {
            response = httpClient.execute(httpget,
                    HttpClientContext.create());
            HttpEntity entity = response.getEntity();
            String result = EntityUtils.toString(entity, "utf-8");
            EntityUtils.consume(entity);
            return result;
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (response != null) {
                    response.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }


    /**
     * post请求
     */
    public static String post(String url, String params, List<HeaderEntity> list) throws IOException {
        HttpPost httpPost = new HttpPost(url);
        httpPost.addHeader("Content-Type","application/json");
        httpPost.addHeader("Accept", "application/json");
        config(httpPost,list);

        //setPostParams(httpPost, params);
        HttpEntity entity = new StringEntity(params,"utf-8");
        httpPost.setEntity(entity);
        CloseableHttpResponse response = null;
        try {
            response = httpClient.execute(httpPost, HttpClientContext.create());
            HttpEntity e = response.getEntity();
            String result = EntityUtils.toString(e, "utf-8");
            // 关闭流
            EntityUtils.consume(entity);
            return result;
        } catch (IOException e) {
            throw e;
        } finally {
            try {
                if (response != null) {
                    response.close();
                }

            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * post-protobuf请求
     */
    public static HttpEntity postProtobuf(String url, byte[] bytes, List<HeaderEntity> list) throws IOException {

        HttpPost httpPost = new HttpPost(url);

        //封装头参数
        httpPost.addHeader("Content-Type", "application/x-protobuf");
        httpPost.addHeader("Accept", "application/x-protobuf");
        config(httpPost, list);

        CloseableHttpResponse response;
        HttpEntity entity = new ByteArrayEntity(bytes);
        httpPost.setEntity(entity);
        response = httpClient.execute(httpPost, HttpClientContext.create());

        HttpEntity result = response.getEntity();

        return result;
    }

    /**
     * 设置post参数
     *
     * @param post
     * @param paramas
     */
    private static void setPostParams(HttpPost post, String paramas) {
        HttpEntity entity = new StringEntity(paramas,"utf-8");
        post.setEntity(entity);

        /*List<NameValuePair> nameValuePairList = new ArrayList<>();
        Set<String> keySets = paramas.keySet();
        for (String key : keySets) {
            nameValuePairList.add(new BasicNameValuePair(key, paramas.get(key).toString()));
        }

        try {
            post.setEntity(new UrlEncodedFormEntity(nameValuePairList, "utf-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }*/

    }

}