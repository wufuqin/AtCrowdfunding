package com.atguigu.atcrowdfunding.util;

import java.io.FileWriter;
import java.io.IOException;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *修改日期：2017-04-05
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */

public class AlipayConfig {

//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

	// 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
	public static String app_id = "2016102300747444";

	// 商户私钥，您的PKCS8格式RSA2私钥
	public static String merchant_private_key = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCN3jdQ6naqRX063DZPQ7QF/ZLlmbcF3+GnxFHcFHPyfyGJuGEdD1s09QA0C8PcP+1SUQOn7mRv19OX5UdWjS1RWNTZrMFm8/F1ZPf5NAYNwi8NkxGBivaJdRNK8Ft0nShXOKa3V0v7wsi6QibOT9+ZQH4Ql2Y2ahINtD4OkIEJ4uHmOqDPFS6XiY6UPkvhJHChB2Czbh20aWRLWs1NT6c6tRIFu9rsB795OK1MbaUeFeax3es4v+AXKd+ldeZ21U/ptgpl6k6Jd9R9iYmtk5fRmJgwuVWyQlYlgy4ezKNXZ6sk4uLNRNtCD3IubiHyhXZ59L1koA9tXSrbzraagLlJAgMBAAECggEAM4Aa1p327AMD3g05DfdG7/HIlN8DaPeIJG4JRXqLSNnL5AHyByme84+JPluTA26ViY9tY1YQUeWoo3iROCNR8zjrNAYZw3UFD5fSyT2QgQggKq5b6Yn3y5ibo1Wz7ZZroZYoN2BSbhec5LjE+5pVUn3uBbngWhqRaTYoXQMqRNryHaCvtamOZ3TL5cnH+cfytkcjlbx/A3dfUWxFVwN3gGMx3oq6wh12nB8XRQvkXrI33WhxZU/BTPRlcJX2UBi9LRTd4cw2vUd4fYEyaMWMhYMz6QE0jqPwOcKsJHFMTNp+YrkC9ie596d9DfWT7XILKA3C5czEOofTAX+5uNng8QKBgQDnz2KehFTQFs0s0m+pRglOIDwHWlzOmh9444Elx/UBXkxxrQss9JCGH/36D6yI8IwJi3IwNRl6OfUJgFzEEHguXyojTXtZQ1HahiNsqmkNwgHP3DZDiP0AVS6GJjCzxAZ/fZppAIGqASBzgOVUpQfrcexCZIKIOlXrnw2AVX/qzQKBgQCcrBpgE11tRBaXz5V6hzi99Kyj8K4tJ3SN8XrTZg3jfLhQnWvEVBEs9QKqq6umP6cVP3e4PaAQcMyFbnrGa2jr5FSgiFRaSX4YeOoBDqigTUq8BJ1wRejcrUDC4a9Oqdl1SMrBR3ojj/auTcgjg7kVonpFnLm0L2xKudYQLrDAbQKBgB28fcMl6JdVBXble8t0H4d1HR44WkVqgfUJAi0tjGFjjlzavN9EdDGwcu0cC575dI1Y5QoIFb+XJbbVT5EbJ7+TF521t8gImbx1jp/G8HkCVScr8Y4SSZo8Ux6EUaUN1WOPYjpsBTYgtN/8Pe7wyKZMU+lkaVY+XX0/RwUacrFVAoGAdwohBCzSiMn6LKDR34ZMq6/zWKDvhml7GrqG64aYOOezl7T0g/ioEDOdMhY71pZ4miFeEoPoUXWTQDLAYHCOCOW1E0BibzN19pwwmFsN7rareQ48nWjQ1JNjKG+X5roQ+xcyzwZDHDAvayK4VZupDnIkWy4Iv4pkyqZGqob/T0UCgYEA1RZ5IfleAb8AWRAwvsO1iETMeAmJLjhpYP+5bkuqzWqRF4JlJwTtb8eqkd1qt7eWnct9tLlSH6ewU+MhkRwQb0gPgqTGzRGxdWwx27KYuCfM7scSnFfZKGxNcbKuWD370XDvgUForEh0Upj52sjmLlUpbmFF48bKg991e/teaqk=";

	// 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
	public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyKnukKDAQdazA3yVfWN7pEfP0AVbNaJXfkhgW0eqyLxDBvQHNoepq+c1eJ4ZhsXiSzYTdy+YXlFKZN+nQPrp54FAxv16NmeKuIvit8VWFEEHPI4ZIAbRmeb4ZCYUt1Njkza4TlKBGqbGP7z2JWB3bKbBI06rSEjX8Yjh5Pmbvs5ysoFh2rQ5lGYgh/xTwGAUwulEmqVPw07u2K902LDcJr81ZnfzpVveUYWNCgpuSHj2lNnTaAvCrXxwKzwZ80k21qcufzPmGZnb9db8VSj7X8Fe9UGF/888QK3dbN9G0nV6BMs39vSsnJtU9bZAXaUaaZ1lm0o7U65xEKfJFUoNywIDAQAB";

	// 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static String notify_url = "http://"+Const.path+"/potalProject/fishPay.do";

	// 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static String return_url = "http://"+Const.path+"/potalProject/fishPay.do";

	// 签名方式
	public static String sign_type = "RSA2";

	// 字符编码格式
	public static String charset = "utf-8";

	// 支付宝网关
	public static String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";

}

