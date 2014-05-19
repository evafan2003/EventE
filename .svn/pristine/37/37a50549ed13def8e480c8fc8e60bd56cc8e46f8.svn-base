//
//  URLDefine.h
//  modelTest
//
//  Created by mosh on 13-10-29.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JSONKEY     @"res"
#define JSONFEEDBACK    @"feedback"
#define Encrypt      YES
#define JSONLIST    @"list"

/*
 网址
 */

#define MOSHHOST   @"http://192.168.1.200:30206/iphone/" //host
//#define MOSHHOST                   @"http://e.mosh.cn/iphone/"


#define SERVERHOST                   @"www.mosh.cn" //servermanger检测网络状态使用
#define URL_LOGIN @"login?username=%@&password=%@"  //登录
#define URL_ACTIVITYLIST @"eventlist?uid=%@&page=%d"    //活动列表
#define URL_STATISTICALRESULT   @"eventcoutn?eid=%@&uid=%@"  //统计结果


//获取所有票信息
#define GET_ALL_LIST                @"list?eid=%@&uid=%@&time=%d&page=%d&isall=%@"
//验票
#define VALIDATE                    @"validate?ticket_id=%@&password=%@&eid=%@&uid=%@"

//上传(post方式data,eid,uid)
#define UPLOAD                      @"state?eid=%@&uid=%@"

//找回密码之获取验证码
#define URL_GETCHECKNUMBER              @"findpwd?username=%@&userType=%@"

//找回密码之修改密码
#define URL_CHANGEPASSWORD              @"updatepwd?username=%@&userType=%@&password=%@"

//账户概览
#define URL_USERINFO                    @"overview?uid=%@"

//全部报名信息
#define URL_MEMBERINFO                  @"reginfotest?uid=%@&eid=%@&tid=%@&page=%d&time=%d"

//单个报名信息
/*
    tid/uuid/eid/issentry从报名者信息中获得
    uid为登录者id
 */
#define URL_SINGLEMEMBERINFO            @"ticinfo?tid=%@&eid=%@&uuid=%@&isentry=%@&uid=%@"


/*
 缓存
 */
#define CACHE_ACTIVYTYLIST      @"ACTIVITYLIST%dUID%@"//活动列表
#define CACHE_STATISTICAL       @"STATISTICAL%@"//统计结果
#define CACHE_USERINFO          @"USERINFO%@"//账户概览

//加密
#define DESKEY                      @"d51da0e7ae40b437"
#define LOGINHOST                   @"http://api.mosh.cn/moshevent/"

/*
 分享
 */
//新浪
#define SINA_APPKEY             @"4131504527"
#define SINA_APPSECRET          @"f96fe8b50c08f31ee232ea5fa41f299b"
#define URI                     @"http://www.moshapp.com"

//本地保存的内容（不能修改）
#define SINA_USERINFO_ACCESSTOKEN       @"AccessTokenKey"
#define SINA_USERINFO_EXPITATIONDATE    @"ExpirationDateKey"
#define SINA_USERINFO_USERID            @"UserIDKey"

#define TENCENT_USERINFO_ACCESSTOKEN    @"TKSDKaccessToken"
#define TENCENT_USERINFO_EXPIRATIONDATE @"TKSDKexpireTime"
#define TENCENT_USERINFO_OPENID         @"TKSDKopenId"
#define TENCENT_USERINFO_REFRESHDATE    @"TKSDKrefreshToken"

//点击微信分享后进入的链接
#define LINKURL                 @"www.moshapp.com/mao"
//活动易购票链接 %@为eid
#define BUYURL                  @"http://e.mosh.cn/%@"

//微信
#define WEIXIN_APPKEY           @"wx965d46391450bba5"
#define WEIXIN_APPSECRET        @"ce35f0396b31ecedd4fa96bc7bbfc1d3"

//mosh登录
//新浪微博
#define MOSH_SINA_APPKEY             @"89207806"
#define MOSH_SINA_APPSECRET          @"c37b635b2ec943e8bf08932e6036d205"
#define MOSH_SINA_REDIRECTURI        @"http://www.mosh.cn/binding/?custom=weibo"
//人人
#define MOSH_RENREN_APPID            @"237254"
#define MOSH_RENREN_APPKEY           @"1ec54fe39d3f43b887069ef1640f0911"
#define MOSH_RENREN_APPSECRET        @"66dac70a379a4221adfd2c9308ba0aa7"
#define MOSH_RENREN_REDIRECTURL      @"http://www.mosh.cn/binding/?custom=renren"

//QQ
#define MOSH_QQ_APPKEY               @"100263502"
#define MOSH_QQ_APPSECRET            @"f816e5c383abe9800f97de50d7410b67"
#define MOSH_QQ_REDIRECTURL          @"http://www.mosh.cn/binding/?custom=qq"

//豆瓣
#define MOSH_DOUBAN_APPKEY           @"01edb6fb77e5fb2105c924f267b1f163"
#define MOSH_DOUBAN_APPSECRET        @"a14688cdf9b7aca7"
#define MOSH_DOUBAN_REDIRECTURL      @"http://www.mosh.cn/binding/?custom=douban"

//淘宝
#define MOSH_TAOBAO_APPKEY           @"21551386"
#define MOSH_TAOBAO_APPSECRET        @"760426897433388725bc9195f562abd5"
#define MOSH_TAOBAO_REDIRECTURL      @"http://www.mosh.cn/binding/?custom=taobao"

//腾讯微博
#define MOSH_TENCENT_APPKEY          @"801336858"
#define MOSH_TENCENT_APPSECRET       @"9239362c664e906c13986c3a5d94a495"
#define MOSH_TENCENT_REDIRECTURL     @"http://www.mosh.cn/binding/?custom=t_weibo"


/*
 第三方登录使用
 本地保存 格式如下
 { USER_KEYSINA:{USER_THIRDACCESSTOKEN:@"",USER_THIRDUSERID:@"",USER_THIRDEXPDATE;@""},
 USER_KEYQQ:
 {USER_THIRDACCESSTOKEN:@"",USER_THIRDUSERID:@"",USER_THIRDEXPDATE;@""}}
 */
#define USER_THIRDINFO              @"userThirdLogin"//第三方登录信息
#define USER_KEYSINA                @"userSina"//第三方登录信息内字典key
#define USER_KEYRENREN              @"userRenren"
#define USER_KEYDOUBAN              @"userDouban"
#define USER_KEYQQ                  @"userQQ"
#define USER_KEYTAOBAO              @"userTaobao"
#define USER_KEYTENCENT             @"userTencent"
#define USER_THIRDACCESSTOKEN       @"userAccessToken"//第三方token
#define USER_THIRDUSERID            @"userthirdUserId"//第三方id
#define USER_THIRDEXPDATE           @"userExpiresDate"//有效期  过期时间 = 授权时间 + 有效期
#define USER_THIRDAUTHDATE          @"userAuthdate" //授权时间
#define USER_THIRDNICKNAME          @"userNickName" // 用户昵称
#define USER_USERID                 @"userId"       //用户id
#define USER_USERNAME               @"userName"     //用户名
#define USER_PASSWORD               @"userPassword" //密码
#define USER_PHONE                  @"userPhone"    //手机号
#define USER_EMAIL                  @"userEmail"    //邮箱
#define USER_CITY                   @"userCity"     //城市
#define USER_IMAGE                  @"userImage"    //头像
#define USER_BINDING                @"userBinding"  //绑定
#define USER_GENDER                 @"userGender"   //性别
#define CITYNAME                    @"CityName"     //gps城市名称
#define CITYID                      @"CityId"       //gps城市代码



@interface URLDefine : NSObject

@end
