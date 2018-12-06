package com.zthx.airtransporter.service.impl;

package com.travelsky.falcon.ws.api.ping;

import com.alibaba.fastjson.JSON;
import com.travelsky.falcon.core.util.BaseUtil;
import com.travelsky.falcon.core.util.MD5Util;
import com.travelsky.falcon.pojo.account.vo.sso.SSOVo;
import com.travelsky.falcon.pojo.base.BaseOperationRequest;
import com.travelsky.falcon.services.remote.util.HttpClientIgnoreCrt;
import com.travelsky.falcon.services.remote.util.WandaSSOUtil;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.params.ConnRouteParams;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.ssl.*;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpProtocolParams;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import sun.misc.BASE64Encoder;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import javax.net.ssl.*;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.KeyManagementException;
import java.security.KeyStore;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.util.Locale;
import java.util.ResourceBundle;

public class test33 {
    private final static String TEST_URL ="https://localhost:8443/books";

    private final static String KEYSTORE_FILE ="d:/Client_KeyStore.jks";

    private final static String TRUSTSTORE_FILE ="d:/Client_TrustStore.jks";

    private final static String KEYSTORE_PASSWORD ="keypass";
    private final static String TRUSTSTORE_PASSWORD ="storepass";

    private static Logger logger = LoggerFactory.getLogger(WandaSSOUtil.class);

    // 网络代理ip
    private static final String PROXY_HOST;

    // 网络搭理端口号
    private static final Integer PROXY_PORT;

    // 网络连接请求超时
    private static final Integer CONNECT_TIMEOUT;

    // 网络连接读取超时
    private static final Integer READ_TIMEOUT;

    // 默认编码:UTF-8
    private static final String DEFAULT_ENCODING = "UTF-8";

    // 系统登录接口
    private static final String URL_LOGINFROMETRIP ;

    // 确认授权登录接口
    private static final String URL_ASKINGFORPERMISSIONTOLOGIN ;

    static {
        ResourceBundle httpRb = ResourceBundle.getBundle("httpclient", Locale.US);
        PROXY_HOST = httpRb.getString("PROXY_HOST");
        PROXY_PORT = Integer.parseInt(httpRb.getString("PROXY_PORT"));
        CONNECT_TIMEOUT = Integer.parseInt(httpRb.getString("CONN_TIMEOUT"));
        READ_TIMEOUT = Integer.parseInt(httpRb.getString("READ_TIMEOUT"));

        ResourceBundle ssoRb = ResourceBundle.getBundle("sso", Locale.US);
        URL_LOGINFROMETRIP = ssoRb.getString("sso.wanda.loginFromEtrip");
        URL_ASKINGFORPERMISSIONTOLOGIN = ssoRb.getString("sso.wanda.askingForPermissionToLogin");
    }

    @Test
    public void testQuery1()  {
        /*String url = "http://172.24.111.249:8080/falcon-controller/sso/token.json";*/
        /*String url = "https://183.134.5.19:8443/falcon-controller/sso/token.json";*/
        String url = "http://localhost:8090/falcon-ws-api/app/sso/token.json";
        SSOVo ssoVo = new SSOVo();
        ssoVo.setPartenerId("thcs");
        ssoVo.setUsername("邓嘉杰");
        ssoVo.setUserType("1");
        BaseOperationRequest baseOperationRequest = new BaseOperationRequest();
        baseOperationRequest.setRequestObject(ssoVo);
        /*try {
            sendHttpsRequestByPost(url, JSON.toJSONString(baseOperationRequest));
        } catch (Exception e) {
            e.printStackTrace();
        }*/
        sendPost(url, JSON.toJSONString(baseOperationRequest)) ;
    }


    @Test
    public void testQuery()  {
        /*String url = "http://172.24.111.249:8080/falcon-ws-api/sso/check.json";*/
        String url = "http://localhost:8090/falcon-ws-api/sso/check.json";
        String data = "thcs-邓嘉杰-d0de4f3e-a42d-451e-9f92-67364f7cc080" + "thcs";
        String md5 = MD5Util.MD5(data);
        SSOVo ssoVo = new SSOVo();
        ssoVo.setFalconToken(md5);
        ssoVo.setToken("111");
        ssoVo.setPartenerId("thcs");
        ssoVo.setUsername("邓嘉杰");
        ssoVo.setUserType("1");
        ssoVo.setTargetType(1);

        BaseOperationRequest baseOperationRequest = new BaseOperationRequest();
        baseOperationRequest.setRequestObject(ssoVo);
        sendPost(url, JSON.toJSONString(baseOperationRequest)) ;
    }


    /**
     * ssl
     * @throws Exception
     */
    public  void ssl() throws Exception {
        KeyStore keyStore  =KeyStore.getInstance(KeyStore.getDefaultType());
        FileInputStream instream = new FileInputStream(new File(KEYSTORE_FILE));
        try {
            keyStore.load(instream,TRUSTSTORE_PASSWORD.toCharArray());
        } finally {
            instream.close();
        }

        //load the trusted certs:
        KeyStore trustStore  = KeyStore.getInstance(KeyStore.getDefaultType());
        FileInputStream instream1= new FileInputStream(new File(TRUSTSTORE_FILE));
        try {
            trustStore.load(instream1,TRUSTSTORE_PASSWORD.toCharArray());
        } finally {
            instream1.close();
        }

        // Trust own CA and allself-signed certs
        SSLContext sslcontext= SSLContexts.custom()

                .loadKeyMaterial(keyStore,KEYSTORE_PASSWORD.toCharArray())

                .loadTrustMaterial(trustStore,new TrustSelfSignedStrategy())

                .build();

        // Allow TLSv1 protocol only
        SSLConnectionSocketFactory sslsf =

                new SSLConnectionSocketFactory(sslcontext,

                        new String[] {"TLSv1" },

                        null,

                        SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);

        CloseableHttpClient httpclient =HttpClients.custom()

                .setSSLSocketFactory(sslsf)

                .build();

        try {

            HttpGet httpget = new HttpGet(TEST_URL);

            System.out.println("ExecutingRequest:" + httpget.getRequestLine());

            CloseableHttpResponse response = httpclient.execute(httpget);

            try {

                HttpEntity entity =response.getEntity();

                System.out.println("-------------------------------------");

                System.out.println(response.getStatusLine());

                System.out.println(EntityUtils.toString(entity));

                EntityUtils.consume(entity);

            } finally {

                response.close();

            }

        } finally {

            httpclient.close();

        }

    }


    /**
     * This example demonstrates the use of the {@link org.apache.http.client.ResponseHandler} to simplify
     * the process of processing the HTTP response and releasing associated resources.
     * @throws Exception
     */
    public  void ClientWithResponseHandler () throws Exception {
        CloseableHttpClient httpclient = HttpClients.createDefault();
        try {
            HttpGet httpget = new HttpGet("http://localhost/");

            System.out.println("Executing request " + httpget.getRequestLine());

            // Create a custom response handler
            ResponseHandler<String> responseHandler = new ResponseHandler<String>() {

                public String handleResponse(
                        final HttpResponse response) throws ClientProtocolException, IOException {
                    int status = response.getStatusLine().getStatusCode();
                    if (status >= 200 && status < 300) {
                        HttpEntity entity = response.getEntity();
                        return entity != null ? EntityUtils.toString(entity) : null;
                    } else {
                        throw new ClientProtocolException("Unexpected response status: " + status);
                    }
                }

            };
            String responseBody = httpclient.execute(httpget, responseHandler);
            System.out.println("----------------------------------------");
            System.out.println(responseBody);
        } finally {
            httpclient.close();
        }

    }


    //post请求方法
    public String sendPost(String url,String data) {
        String response = null;
        System.out.println("url: " + url);
        System.out.println("request: " + JSON.toJSONString(data));
        try {
            CloseableHttpClient httpclient = null;
            CloseableHttpResponse httpresponse = null;
            try {
                httpclient = HttpClients.createDefault();
                HttpPost httppost = new HttpPost(url);

                StringEntity stringentity = new StringEntity(data, ContentType.create("application/json", "UTF-8"));
                httppost.setEntity(stringentity);
                httpresponse = httpclient.execute(httppost);
                response = EntityUtils
                        .toString(httpresponse.getEntity());
                System.out.println("response: " + response);
            } finally {
                if (httpclient != null) {
                    httpclient.close();
                }
                if (httpresponse != null) {
                    httpresponse.close();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return response;
    }
    /**
     * @Description 发送https 请求
     * @param url 请求地址
     * @param data 请求json
     * @param ignoreSSLCrt 是否忽略ssl 证书
     * @author zonggf
     * @date 2017年6月9日-下午1:40:01
     */
    private static String httpsPostRequest(String url, String data, boolean ignoreSSLCrt) throws Exception{

        // 创建请求
        HttpPost httpPost = createPostRequest(data,url);

        // 设置代理
        HttpClient httpClient = getHttpClient(ignoreSSLCrt);

        // 执行post 请求
        HttpResponse httpResponse = httpClient.execute(httpPost);
        String result = EntityUtils.toString(httpResponse.getEntity(), "utf-8");

        return result;
    }


    /**
     * @Description 创建http请求
     * @param data 请求json 字符串
     * @param requestUrl 请求地址
     * @return HttpUriRequest
     * @throws Exception
     * @author zonggf
     * @date 2017年6月9日-下午1:44:45
     */
    private static HttpPost createPostRequest(String data, String requestUrl) throws Exception {
        HttpPost httpPost = new HttpPost(requestUrl);

        StringEntity stringEntity = new StringEntity(data);
        stringEntity.setContentEncoding(DEFAULT_ENCODING);
        stringEntity.setContentType("application/json");

        //设置请求数据
        httpPost.setEntity(stringEntity);
        HttpProtocolParams.setContentCharset(httpPost.getParams(), DEFAULT_ENCODING);

        // 设置超时时间
        if (BaseUtil.objectNotNull(CONNECT_TIMEOUT)) {
            HttpConnectionParams.setConnectionTimeout(httpPost.getParams(), CONNECT_TIMEOUT);
        }
        if (BaseUtil.objectNotNull(READ_TIMEOUT)) {
            HttpConnectionParams.setSoTimeout(httpPost.getParams(), READ_TIMEOUT);
        }
        return httpPost;
    }

    /**
     * @Description 获取免证书的https Client, 并设置代理
     * @return HttpClient
     * @author zonggf
     * @date 2017年6月9日-下午1:52:48
     */
    private static HttpClient getHttpClient(boolean ignoreSSLCrt) throws Exception {

        HttpClient httpClient ;

        if(ignoreSSLCrt){
            httpClient = new HttpClientIgnoreCrt();
        }else{
            httpClient = new DefaultHttpClient();
        }

        if (BaseUtil.stringNotNull(PROXY_HOST) && BaseUtil.objectNotNull(PROXY_PORT)) {
            HttpHost proxy = new HttpHost(PROXY_HOST, PROXY_PORT);
            httpClient.getParams().setParameter(ConnRouteParams.DEFAULT_PROXY, proxy);
        }
        return httpClient;
    }

    /**
     * @Description 万达专用 3Des 加密
     * @param originalText 原字符串
     * @return 加密后字符串
     * @throws Exception
     * @author zonggf
     * @date 2017年6月9日-下午2:50:33
     */
    private static String threeDesEncrypt(String originalText) throws Exception {

        String result = "";
        try {
            SecretKey desKey = new SecretKeySpec("F8830CD4DAB8464839D233B5".getBytes("UTF-8"), "DESede");
            Cipher cipher = Cipher.getInstance("DESede");
            cipher.init(Cipher.ENCRYPT_MODE, desKey);

            byte[] bytes = cipher.doFinal(originalText.getBytes("UTF-8"));
            BASE64Encoder encoder = new BASE64Encoder();
            result = encoder.encode(bytes).replaceAll("\r", "").replaceAll("\n", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static String sendHttpsRequestByPost(String url, String json) {
        String responseContent = null;
        HttpClient httpClient = new DefaultHttpClient();
        //创建TrustManager
        X509TrustManager xtm = new X509TrustManager() {
            public void checkClientTrusted(X509Certificate[] chain, String authType){}
            public void checkServerTrusted(X509Certificate[] chain, String authType){}
            public X509Certificate[] getAcceptedIssuers() {
                return null;
            }
        };
        //HOST验证
        X509HostnameVerifier hostnameVerifier = new X509HostnameVerifier() {
            public boolean verify(String arg0, SSLSession arg1) {
                return true;
            }
            public void verify(String arg0, SSLSocket arg1) throws IOException {}
            public void verify(String arg0, String[] arg1, String[] arg2) throws SSLException {}
            public void verify(String arg0, X509Certificate arg1) throws SSLException {}
        };
        try {
            //TLS1.0与SSL3.0基本上没有太大的差别，可粗略理解为TLS是SSL的继承者，但它们使用的是相同的SSLContext
            SSLContext ctx = SSLContext.getInstance("TLS");
            //使用TrustManager来初始化该上下文，TrustManager只是被SSL的Socket所使用
            ctx.init(null, new TrustManager[] { xtm }, null);
            //创建SSLSocketFactory
            org.apache.http.conn.ssl.SSLSocketFactory socketFactory = new org.apache.http.conn.ssl.SSLSocketFactory(ctx);
            socketFactory.setHostnameVerifier(hostnameVerifier);
            //通过SchemeRegistry将SSLSocketFactory注册到我们的HttpClient上
            httpClient.getConnectionManager().getSchemeRegistry().register(new Scheme("https", socketFactory, 443));
            HttpPost httpPost = new HttpPost(url);
            httpPost.addHeader("Content-Type", "application/json");
            httpPost.setEntity(new StringEntity(json, HTTP.UTF_8));
            HttpResponse response = httpClient.execute(httpPost);
            HttpEntity entity = response.getEntity(); // 获取响应实体
            if (entity != null) {
                responseContent = EntityUtils.toString(entity, "UTF-8");
            }
        } catch (KeyManagementException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            // 关闭连接,释放资源
            httpClient.getConnectionManager().shutdown();
        }
        return responseContent;
    }


}

