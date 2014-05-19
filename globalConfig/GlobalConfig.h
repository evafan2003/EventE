//
//  GlobalConfig.h
//  MoshActivity
//
//  Created by  evafan2003 on 12-12-20.
//  Copyright (c) 2012年 cn.mosh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import "MOSHDefine.h"
#import "URLDefine.h"
//#import "SinaWeibo.h"

//自定义navbutton;
typedef enum {
    NavButtonTypeBack,
    NavButtonTypeRefresh,
    NavButtonTypeShare,
    NavButtonTypeBuy,
    NavButtonTypeList,
    NavButtonTypeUser
}NavButtonType;

@interface GlobalConfig : NSObject
@property (nonatomic, assign) NavButtonType navButtonType;

#pragma mark - 设备方法-
//判断设备是否是 iPod Touch
+ (BOOL)isIPodTouch;

//判断设备是否是 ipad
+ (BOOL) isIpad;

//返回设备型号
+ (NSString *)deviceType;

//返回系统版本信息
+ (NSString *)systemVersion;

//判断是否ios7
+ (BOOL) versionIsIOS7;

//返回软件版本信息
+(CGFloat)appVersion;

//打电话
+ (void)makeCall:(NSString *)phoneNumber;

//发短信
+ (void)sendSms:(NSString *)phoneNumber;

//发邮件
+ (void)sendEmail:(NSString *)to cc:(NSString*)cc subject:(NSString*)subject body:(NSString*)body;

//访问网页
+(void)openUrl:(NSString *) url;

#pragma mark - 动画方法-
//动画消失
+(void)HideViewWithAnimations:(UIView *)view Hide:(BOOL)hide;
//动画移动
+ (void)moveViewWithAnimations:(UIView *)view cgrect:(CGRect)rect Duration:(CGFloat)duration delegate:(id)sender;
//页面之间的推送动画
+ (void) push:(BOOL)push viewController:(UIViewController *)ctl withNavigationCotroller:(UINavigationController *)navCtl animationType:(NSInteger)number1 subType:(NSInteger)number2 Duration:(CGFloat)time;
//动画添加controller
+ (void) add:(BOOL)add superViewController:(UIViewController *)superViewCtl viewController:(UIViewController *)viewCtl Duration:(CGFloat)time;

#pragma mark - 控件方法-
//自定义按钮
//+(UIBarButtonItem *) initwithType:(NavButtonType)type vc:(UIViewController *)vc;
+ (UIBarButtonItem *) createNavigationBarItemWithNormalImageName:(NSString *)normalImageName highlightImageName:(NSString *)highlightImageName title:(NSString *)title action:(SEL)action target:(UIViewController *)vtl;

//自定义UIActionSheet
+(UIActionSheet *) initWithTitle:(NSString *)title type:(NSString *)type sender:(UIViewController *)vc;

//创建假的navigationbar
+(UIView *) createNavigationbar:(CGRect)frame title:(NSString *)title withLeftButton:(BOOL)left rightButton:(BOOL)right vc:(UIViewController *)vc;
//创建UIView
+ (UIView*)createViewWithFrame:(CGRect)rect;

//创建UIImageView
+ (UIImageView*)createImageViewWithFrame:(CGRect)rect ImageName:(NSString*)imageName;

//创建Label
+ (UILabel *)createLabelWithFrame:(CGRect)rect Text:(NSString *)text FontSize:(CGFloat)fontSize textColor:(UIColor *)color;

//创建UITextField
+ (UITextField*)createTextFieldWithFrame:(CGRect)rect Placeholder:(NSString*)placeHolder;

//创建UIButton
+ (UIButton*)createButtonWithFrame:(CGRect)rect ImageName:(NSString*)imageName Title:(NSString*)title Target:(id)target Action:(SEL)action;

//解决textfield输入靠边问题
+ (void) textFieldAddLeftView:(UITextField *)view;

//创建并返回一个带菊花的view
+(UIView *) flowerWithFrame:(CGRect)frame style:(UIActivityIndicatorViewStyle)style;

#pragma mark - 时间方法-
//格式化日期 时间戳转换为YYYY-MM-dd HH:mm:ss格式
+(NSString *) dateFormater:(NSString *)timeStamp format:(NSString *)format;
+(NSString *) date:(NSDate *)date format:(NSString *)format;
//将YYYY-MM-dd HH:mm:ss的时间转化为时间戳
+(NSTimeInterval) datetoTimeStamp:(NSString *) date format:(NSString *)format;
//与现在时间比较
+ (NSComparisonResult) dateCompareWithCurrentDate:(NSString *)timeStamp;

#pragma mark - 其他方法-
//单一按钮提示
+ (void)alert:(NSString *)msg;
//获得缓存目录
+ (NSString *)getPath:(NSString *)string;
//MOSH图片服务器缩略图
+ (NSString *)thumbnailImageUrl:(NSString *)imageStr
                          width:(NSInteger)width
                         height:(NSInteger)height;
//压缩图片....分享用
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
//压缩图片，按空间大小压缩kb
+ (UIImage *) compressImage:(UIImage *)image withlenthKb:(NSInteger)kb;

//字符串数据优化....json解析时用
+ (NSString *) convertToString:(id)str;
+ (NSString *) convertToString:(NSString *)str withObject:(id)obj;
+ (NSArray *) convertToArray:(id)array;
+ (NSDictionary *) convertToDictionary:(id)dic;
+ (NSNumber *) convertToNumber:(id)num;
//判断是否是字符串并且长度大于零
+ (BOOL) isKindOfNSStringClassAndLenthGreaterThanZero:(NSString *)string;
//判断是否是数组并且数量大于零
+ (BOOL) isKindOfNSArrayClassAndCountGreaterThanZero:(NSArray *)array;
//判断是否是字典并且数量大于零
+ (BOOL) isKindOfNSDictionaryClassAndCountGreaterThanZero:(NSDictionary *)dic;
//判断是否是字符串并且长度大于零,如果为no则弹出警告
+ (BOOL) isKindOfNSStringClassAndLenthGreaterThanZero:(NSString *)string Alert:(NSString *)alert;

//获取文字高度....排版用
+ (CGSize) getAdjustHeightOfContent:(NSString *)text width:(CGFloat)width fontSize:(CGFloat)fontSize;

#pragma mark - userInfo -

/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL) isValidateMobile:(NSString *)mobile;
/*邮箱验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateEmail:(NSString *)email;

//设置textField的return键
+ (BOOL) textFieldReturnKeyWithArray:(NSArray *)array fistResponder:(UIView *)view andAnimationBlock:(void(^)(void))block;

//保存用户信息
+ (void) saveUserInfoWithUid:(NSString *)uid
                    userName:(NSString *)userName
                    passWord:(NSString *)passWord
                       phone:(NSString *)phone
                       email:(NSString *)email
                        city:(NSString *)city
                      gender:(NSString *)gender
                       image:(NSString *)image
                     binding:(NSArray *)array;

//删除用户信息
+ (void) deleteUserInfo;

//币种转换
+ (NSString *) currencyConver:(NSString *)currentcy;
+ (NSString *) priceConver:(id)price;


+(NSString *) getObjectWithKey:(NSString *)key;
/*
 连接失败读取缓存显示提示信息....提醒显示2秒后消失
 message 显示的信息 只能显示简短的信息
 superView 显示信息的视图 如果为空则在window上显示
 */
+ (void) showAlertViewWithMessage:(NSString *)message superView:(UIView *)superView;

//加密用(DES方式)
//+ (NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;

//新浪微博
//+ (SinaWeibo *)sinaweibo;

@end
