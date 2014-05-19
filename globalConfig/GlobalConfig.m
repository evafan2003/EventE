//
//  GlobalConfig.m
//  MoshActivity
//
//  Created by  evafan2003 on 12-12-20.
//  Copyright (c) 2012年 cn.mosh. All rights reserved.
//

#import "GlobalConfig.h"

//static SinaWeibo *instance = nil;
@implementation GlobalConfig

#pragma mark - 设备方法-
+ (BOOL)isIPodTouch
{
	NSString *deviceType = [UIDevice currentDevice].model;
	return [deviceType isEqualToString:iPodTouchString];
}

+ (BOOL) isIpad
{
    NSString *deviceType = [UIDevice currentDevice].model;
	return [deviceType isEqualToString:iPadString];
}

//返回设备型号
+ (NSString *)deviceType {
    
    return [UIDevice currentDevice].model;
}

//返回系统版本信息
+ (NSString *)systemVersion {
    
    return [UIDevice currentDevice].systemVersion;
    
}

//返回应用版本信息
+ (CGFloat)appVersion {
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *versions = [infoDic objectForKey:@"CFBundleVersion"];
    return [versions floatValue];
    
}

//是否ios7
+ (BOOL) versionIsIOS7
{
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        return YES;
    }
    return NO;
}

//打电话
+ (void)makeCall:(NSString *)phoneNumber
{
    if ([GlobalConfig isIPodTouch]){
        [GlobalConfig alert:kCallNotSupportOnIPod];
        return;
    }
    
    NSString* numberAfterClear = phoneNumber;
    
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", numberAfterClear]];
#ifdef DEBUGMODEL
	NSLog(@"make call, URL=%@", phoneNumberURL);
#endif
    [[UIApplication sharedApplication] openURL:phoneNumberURL];
}

//发短信
+ (void)sendSms:(NSString *)phoneNumber
{
    //    if ([GlobalConfig isIPodTouch]){
    //        [GlobalConfig alert:kSmsNotSupportOnIPod];
    //        return;
    //    }
    
    NSString* numberAfterClear = phoneNumber;
    
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", numberAfterClear]];
    [[UIApplication sharedApplication] openURL:phoneNumberURL];
}

//发邮件
+ (void)sendEmail:(NSString *)to cc:(NSString*)cc subject:(NSString*)subject body:(NSString*)body
{
    NSString* str = [NSString stringWithFormat:@"mailto:%@?cc=%@&subject=%@&body=%@",
                     to, cc, subject, body];
	
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

+(void)openUrl:(NSString *) url{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

#pragma mark - 动画方法 -
+ (void)HideViewWithAnimations:(UIView *)view Hide:(BOOL)hide {
    
    //动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];         //设置代理
    [UIView setAnimationDuration:0.8];          //动画持续的时间
    
    //这里添加你对UIView所做改变的代码
    view.alpha = (hide == YES) ? 0 : 1;
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:)];   //动画停止后，执行的方法
    [UIView commitAnimations];

    
}

+ (void)moveViewWithAnimations:(UIView *)view cgrect:(CGRect)rect Duration:(CGFloat)duration delegate:(id)sender {
    
    //动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:sender];         //设置代理
    [UIView setAnimationDuration:duration];          //动画持续的时间
    
    //这里添加你对UIView所做改变的代码
    view.frame = rect;
    
    [UIView setAnimationDidStopSelector:@selector(moveFinished:)];   //动画停止后，执行的方法
    [UIView commitAnimations];
}

//推入动画
+ (void) push:(BOOL)push viewController:(UIViewController *)ctl withNavigationCotroller:(UINavigationController *)navCtl animationType:(NSInteger)number1 subType:(NSInteger)number2 Duration:(CGFloat)time
{
    /*
     ￼公开type:
     fade, moveIn, push and reveal 
     未公开type:
     cube, suckEffect, oglFlip, rippleEffect, pageCurl, pageUnCurl, cameraIrisHollowOpen, cameraIrisHollowClose
     subtype:
     kCATransitionFromRight kCATransitionFromLeft 
     kCATransitionFromTop kCATransitionFromBottom
     */
    NSDictionary *allType = @{@1:kCATransitionPush,
                              @2:kCATransitionMoveIn,
                              @3:kCATransitionFade,
                              @4:kCATransitionReveal};
    NSDictionary *allSubType = @{@1:kCATransitionFromLeft,
                                 @2:kCATransitionFromRight,
                                 @3:kCATransitionFromTop,
                                 @4:kCATransitionFromBottom};
    
    CATransition *ca = [CATransition animation];
    NSNumber *type = [NSNumber numberWithInteger:number1];
    NSNumber *subtype = [NSNumber numberWithInteger:number2];
    
    if (allType[type]) {
        [ca setType:allType[type]];
    }
    if (allSubType[subtype]) {
        [ca setSubtype:allSubType[subtype]];
    }
    [ca setDuration:time?time:1.0f];
    [navCtl.view.layer  addAnimation:ca forKey:@"animation"];
    
    if (push) {
        [navCtl pushViewController:ctl animated:YES];
    }
    else {
        [navCtl popViewControllerAnimated:YES];
    }
}

+ (void) add:(BOOL)add superViewController:(UIViewController *)superViewCtl viewController:(UIViewController *)viewCtl Duration:(CGFloat)time
{
    if (add) {
        viewCtl.view.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT - STATEHEIGHT);
        [superViewCtl addChildViewController:viewCtl];
        [superViewCtl.view addSubview:viewCtl.view];
        [GlobalConfig moveViewWithAnimations:viewCtl.view cgrect:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - STATEHEIGHT) Duration:time delegate:nil];
    }
    else {
        [GlobalConfig moveViewWithAnimations:viewCtl.view cgrect:CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT - STATEHEIGHT) Duration:time delegate:nil];
        [viewCtl.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:time];
        [viewCtl performSelector:@selector(removeFromParentViewController) withObject:nil afterDelay:time];
//        [viewCtl removeFromParentViewController];
//        [viewCtl.view removeFromSuperview];
    }
}

#pragma mark - 控件方法 -
//+(UIBarButtonItem *) initwithType:(NavButtonType)type vc:(UIViewController *)vc {
//    
//      UIButton *search = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    if (type == NavButtonTypeBack) {
//        //返回
//        [search setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
//        [search setBackgroundImage:[UIImage imageNamed:@"nav_back_h"] forState:UIControlStateHighlighted];
//        [search addTarget:vc action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    }else if (type == NavButtonTypeShare) {
//        //分享
//        [search setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
//        [search setBackgroundImage:[UIImage imageNamed:@"share_h"] forState:UIControlStateHighlighted];
//        [search addTarget:vc action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
//    } else if (type == NavButtonTypeRefresh) {
//        //注销
//        [search setBackgroundImage:[UIImage imageNamed:@"logout"] forState:UIControlStateNormal];
//        [search setBackgroundImage:[UIImage imageNamed:@"logout_h"] forState:UIControlStateHighlighted];
//        [search addTarget:vc action:@selector(userExited) forControlEvents:UIControlEventTouchUpInside];
//        
//    } else if (type == NavButtonTypeList){
//        //菜单
//        [search setBackgroundImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
//        [search setBackgroundImage:[UIImage imageNamed:@"list_h"] forState:UIControlStateHighlighted];
//        [search addTarget:vc action:@selector(list) forControlEvents:UIControlEventTouchUpInside];
//    }
//    else if (type == NavButtonTypeUser) {
//        //用户
//        [search setBackgroundImage:[UIImage imageNamed:@"user"] forState:UIControlStateNormal];
//        [search setBackgroundImage:[UIImage imageNamed:@"user_h"] forState:UIControlStateHighlighted];
//        [search addTarget:vc action:@selector(user) forControlEvents:UIControlEventTouchUpInside];
//    }
//    else if (type == NavButtonTypeBuy) {
//        //用户
//        [search setBackgroundImage:[UIImage imageNamed:@"nav_buy"] forState:UIControlStateNormal];
//        [search setBackgroundImage:[UIImage imageNamed:@"nav_buy_h"] forState:UIControlStateHighlighted];
//        [search addTarget:vc action:@selector(buyTicket) forControlEvents:UIControlEventTouchUpInside];
//    }
//    search.frame = CGRectMake(0, 0, 86/2, 60/2);
//    UIBarButtonItem *iteml = [[UIBarButtonItem alloc] initWithCustomView:search];
//    return iteml;
//}

+ (UIBarButtonItem *) createNavigationBarItemWithNormalImageName:(NSString *)normalImageName highlightImageName:(NSString *)highlightImageName title:(NSString *)title action:(SEL)action target:(UIViewController *)vtl
{
    UIImage *image = [UIImage imageNamed:normalImageName];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    if ([title length] != 0) {
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    [button addTarget:vtl action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0,0,image.size.width,image.size.height);
    UIBarButtonItem *iteml = [[UIBarButtonItem alloc] initWithCustomView:button];
    return iteml;
}

+(UIActionSheet *) initWithTitle:(NSString *)title type:(NSString *)type sender:(UIViewController *)vc{
    //ios7
    if ([GlobalConfig versionIsIOS7]) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
        bgView.backgroundColor = [UIColor colorWithRed:52/255.0f green:52/255.0f blue:52/255.0f alpha:1];
        UILabel *label = [GlobalConfig createLabelWithFrame:CGRectMake(0, 0, 320, 30) Text:@"分享" FontSize:17 textColor:BLACKCOLOR];
        label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"asLabelBg"]];
        label.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:label];
        
        UIButton *button = [GlobalConfig createButtonWithFrame:CGRectMake((320 - 84)/2, 220, 84, 38) ImageName:@"cancleButton" Title:@"" Target:vc Action:@selector(actionSheetCancle)];
        [button setImage:[UIImage imageNamed:@"cancleButton_h"] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [bgView addSubview:button];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 320, 170)];
        view.backgroundColor = [UIColor clearColor];
        int x = 0;
        for (int i= 0; i<4; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor grayColor];
            button.tag = i;
            if (i==3) {
                x=0;
            }
            
            button.frame = CGRectMake(37+x*95, i<3?10:102, 58, 73);
            button.tag = i*100;
            [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"share_icon0%d",i+1]] forState:UIControlStateNormal];
            [button addTarget:vc action:@selector(shareMethod:) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor clearColor];
            [view addSubview:button];
            x++;
        }
        [bgView addSubview:view];
        
        UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"分享" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"",@"",@"",@"", nil];
        as.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        as.cancelButtonIndex = as.numberOfButtons-1;
        
        [as addSubview:bgView];
        return as;
    }
    else {//ios6.5保持原来风格
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 320, 170)];
        view.backgroundColor = [UIColor blackColor];
        int x = 0;
        for (int i= 0; i<4; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor grayColor];
            button.tag = i;
            if (i==3) {
                x=0;
            }
            
            button.frame = CGRectMake(37+x*95, i<3?10:102, 58, 73);
            button.tag = i*100;
            [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"share_icon0%d",i+1]] forState:UIControlStateNormal];
            [button addTarget:vc action:@selector(shareMethod:) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor clearColor];
            [view addSubview:button];
            x++;
        }
        UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"分享" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"",@"",@"", nil];
        as.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        as.cancelButtonIndex = as.numberOfButtons-1;
        [as addSubview:view];
        return as;
    }
}

//创建假的navigationbar
+(UIView *) createNavigationbar:(CGRect)frame title:(NSString *)title withLeftButton:(BOOL)left rightButton:(BOOL)right vc:(UIViewController *)vc {
    
    if (CGRectIsNull(frame)) {
        frame = CGRectMake(0, 0, 320, 44);
    }
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_title"]]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 240, 44)];
    label.textColor = WHITECOLOR;
    label.font = NAV_FONT;
    label.backgroundColor = CLEARCOLOR;
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    if (left) {
        //返回
        UIButton *search = [UIButton buttonWithType:UIButtonTypeCustom];
        [search setBackgroundImage:[UIImage imageNamed:@"cate"] forState:UIControlStateNormal];
        [search setBackgroundImage:[UIImage imageNamed:@"cate_h"] forState:UIControlStateHighlighted];
        [search addTarget:vc action:@selector(showCate) forControlEvents:UIControlEventTouchUpInside];
        search.frame = CGRectMake(5, 7, 52, 30);
        [view addSubview:search];
        
    }
    if (right) {
        
    }
    
    return view;
}

//创建基础控件
+ (UIView *)createViewWithFrame:(CGRect)rect{
    UIView* view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

+ (UIImageView *)createImageViewWithFrame:(CGRect)rect ImageName:(NSString *)imageName{
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}

+ (UILabel *)createLabelWithFrame:(CGRect)rect Text:(NSString *)text FontSize:(CGFloat)fontSize textColor:(UIColor *)color{
    UILabel* label = [[UILabel alloc] initWithFrame:rect];
    label.text = text;
    label.textColor = color;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.backgroundColor = [UIColor clearColor];
    return label;
}

+ (UITextField *)createTextFieldWithFrame:(CGRect)rect Placeholder:(NSString *)placeHolder{
    UITextField* textField = [[UITextField alloc] initWithFrame:rect];
    textField.placeholder = placeHolder;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    return textField;
}

+ (UIButton *)createButtonWithFrame:(CGRect)rect ImageName:(NSString *)imageName Title:(NSString *)title Target:(id)target Action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return button;
}

+ (void) textFieldAddLeftView:(UITextField *)view
{
    if ([view isKindOfClass:[UITextField class]]) {
        view.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5, view.frame.size.height)];
        view.leftViewMode = UITextFieldViewModeAlways;
    }
}

//创建并返回一个带菊花的view
+ (UIView *) flowerWithFrame:(CGRect)frame style:(UIActivityIndicatorViewStyle)style {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    UIActivityIndicatorView *flower = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [flower setCenter:CGPointMake(frame.size.width/2, frame.size.height/2)];
    [view addSubview:flower];
    [flower startAnimating];
    return view;
}

#pragma mark - 时间方法 - 
//格式化日期 时间戳转换为YYYY-MM-dd HH:mm:ss格式
+(NSString *) dateFormater:(NSString *)timeStamp format:(NSString *)format {
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (format == nil) {
        format = DATEFORMAT_01;
    }
    [formatter setDateFormat:format];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[timeStamp intValue]];
    NSString *str = [formatter stringFromDate:date];
    return str;
    
}

+(NSString *) date:(NSDate *)date format:(NSString *)format {
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (format == nil) {
        format = DATEFORMAT_01;
    }
    [formatter setDateFormat:format];
    NSString *str = [formatter stringFromDate:date];
    return str;
    
}

//将YYYY-MM-dd HH:mm:ss的时间转化为时间戳
+(NSTimeInterval) datetoTimeStamp:(NSString *) date format:(NSString *)format {
    //2012-11-22 00:00
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (format == nil) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    
    [formatter setDateFormat:format];
    NSDate *dateStr = [formatter dateFromString:date];
    NSTimeInterval aaa = [dateStr timeIntervalSince1970];
    return aaa;
}

+ (NSComparisonResult) dateCompareWithCurrentDate:(NSString *)timeStamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];
    NSDate *currentDate = [NSDate date];
    return [date compare:currentDate];
}

//缩略图(默认200像素)
+ (NSString *)thumbnailImageUrl:(NSString *)imageStr width:(NSInteger)width height:(NSInteger)height
{
    NSString *replaceStr = @"/200/200";
    if (height >0) {
        replaceStr = [NSString stringWithFormat:@"/%d/%d",width,height];
    }
    if (imageStr.length > 0) {
        NSMutableString *str = [NSMutableString stringWithString:imageStr];
        NSRange range = [str rangeOfString:@"/0/0"];
        if (range.location != NSNotFound) {
            [str replaceCharactersInRange:range withString:replaceStr];
        }
        return str;
    }
    return nil;

}

#pragma mark - 其他方法 -
//单一按钮提示
+ (void)alert:(NSString *)msg
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:msg message:@"" delegate:self cancelButtonTitle:BUTTON_OK otherButtonTitles:nil, nil];
    [alertView show];
}

//获得缓存目录
+ (NSString *)getPath:(NSString *)string {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dataPath = [paths objectAtIndex:0];
    NSString *absPath = [dataPath stringByAppendingPathComponent:string];
    return absPath;
}

//判断是否是字符串并且长度大于零
+ (BOOL) isKindOfNSStringClassAndLenthGreaterThanZero:(NSString *)string
{
    return ([string isKindOfClass:NSStringClass] && string.length > 0);
}
//判断是否是数组并且数量大于零
+ (BOOL) isKindOfNSArrayClassAndCountGreaterThanZero:(NSArray *)array
{
    return ([array isKindOfClass:NSArrayClass] && array.count > 0);
}
//判断是否是字典并且数量大于零
+ (BOOL) isKindOfNSDictionaryClassAndCountGreaterThanZero:(NSDictionary *)dic
{
    return ([dic isKindOfClass:NSDictionaryClass] && dic.count > 0);
}

//判断是否是字符串并且长度大于零,如果为no则弹出警告
+ (BOOL) isKindOfNSStringClassAndLenthGreaterThanZero:(NSString *)string Alert:(NSString *)alert
{
    if ([string isKindOfClass:NSStringClass] && string.length > 0) {
        return YES;
    }
    else {
        [GlobalConfig alert:alert];
        return NO;
    }
}

//数据优化
+ (NSString *) convertToString:(id)str
{
    if (![GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:str]) {
        return @"";
    }
    return (NSString *)str;
}

+ (NSString *) convertToString:(NSString *)str withObject:(id)obj
{
    if (![GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:str]) {
        return str;
    }
    return (NSString *)obj;
}

+ (NSArray *) convertToArray:(id)array
{
    if (![GlobalConfig isKindOfNSArrayClassAndCountGreaterThanZero:array]) {
        return @[];
    }
    return array;
}
+ (NSDictionary *) convertToDictionary:(id)dic
{
    if (![GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:dic]) {
        return @{};
    }
    return dic;
}

+ (NSNumber *) convertToNumber:(id)num
{
    if ([num isKindOfClass:[NSNumber class]]) {
        return num;
    }
    return [[NSNumber alloc] initWithBool:NO];
}

//获取文字高度
+ (CGSize) getAdjustHeightOfContent:(NSString *)text width:(CGFloat)width fontSize:(CGFloat)fontSize
{
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width,10000) lineBreakMode:NSLineBreakByWordWrapping];
    
    size = CGSizeMake(size.width, size.height + 10);
    return size;
}

/*邮箱验证 MODIFIED BY HELENSONG*/
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

//压缩图片,按尺寸大小压缩size
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//压缩图片，按空间大小压缩kb
+ (UIImage *) compressImage:(UIImage *)image withlenthKb:(NSInteger)kb
{
    NSData *data = UIImageJPEGRepresentation(image, 1);
    
    if (data.length / 1024 > kb)
    {
        float ratio = (kb * 104) / data.length ;
        data = UIImageJPEGRepresentation(image, ratio);
        return [UIImage imageWithData:data];
    }
    return image;
}


//保存用户信息
+ (void) saveUserInfoWithUid:(NSString *)uid
                    userName:(NSString *)userName
                    passWord:(NSString *)passWord
                       phone:(NSString *)phone
                       email:(NSString *)email
                        city:(NSString *)city
                      gender:(NSString *)gender
                       image:(NSString *)image
                     binding:(NSArray *)array
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:uid forKey:USER_USERID];
    [defaults setObject:userName forKey:USER_USERNAME];
    [defaults setObject:passWord forKey:USER_PASSWORD];
    [defaults setObject:phone forKey:USER_PHONE];
    [defaults setObject:email forKey:USER_EMAIL];
    [defaults setObject:city forKey:USER_CITY];
    [defaults setObject:gender forKey:USER_GENDER];
    [defaults setObject:image forKey:USER_IMAGE];
    [defaults setObject:array forKey:USER_BINDING];
    
    [defaults synchronize];
    
}
//清除用户信息
+ (void) deleteUserInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:nil forKey:USER_USERID];
    [defaults setObject:nil forKey:USER_USERNAME];
    [defaults setObject:nil forKey:USER_PASSWORD];
    [defaults setObject:nil forKey:USER_PHONE];
    [defaults setObject:nil forKey:USER_EMAIL];
    [defaults setObject:nil forKey:USER_CITY];
    [defaults setObject:nil forKey:USER_GENDER];
    [defaults setObject:nil forKey:USER_IMAGE];
    [defaults setObject:nil forKey:USER_BINDING];
    [defaults setObject:nil forKey:USER_THIRDINFO];
    
    [defaults synchronize];
}
//textField 设置换行键
+ (BOOL) textFieldReturnKeyWithArray:(NSArray *)array fistResponder:(UIView *)view andAnimationBlock:(void(^)(void))block
{
        NSInteger index = [array indexOfObject:view];
        if ([view isFirstResponder] && index != NSNotFound) {
            if (index == [array count] - 1) {
                [[array objectAtIndex:index] resignFirstResponder];
            }
            else {
                [view resignFirstResponder];
                [[array objectAtIndex:index + 1] becomeFirstResponder];
            }
            
            [UIView animateWithDuration:0.5 animations:block];
            return YES;
        }
        else {
            return NO;
        }
}

//连接失败读取缓存显示提示信息
+ (void) showAlertViewWithMessage:(NSString *)message superView:(UIView *)superView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((SCREENWIDTH - 205)/2, (SCREENHEIGHT - 40)/2 - STATEHEIGHT - NAVHEIGHT, 205, 40)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loding_error"]];
    UILabel *label = [GlobalConfig createLabelWithFrame:CGRectMake(0, 0, 205, 40) Text:@"" FontSize:14 textColor:WHITECOLOR];
    if (message) {
        label.text = message;
    }
    label.textAlignment = UITextAlignmentCenter;
    [view  addSubview:label];
    
    if (superView) {
        [superView addSubview:view];
    }
    else {
        [[[UIApplication sharedApplication] keyWindow] addSubview:view];
    }
    
    [view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:2.0f];
    
}


//加密用(DES方式)

//+ (NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key
//{
//    NSData *data = [clearText dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//    unsigned char buffer[1024];
//    memset(buffer, 0, sizeof(char));
//    size_t numBytesEncrypted = 0;
//    
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
//                                          kCCAlgorithmDES,
//                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
//                                          [key UTF8String],
//                                          kCCKeySizeDES,
//                                          nil,
//                                          [data bytes],
//                                          [data length],
//                                          buffer,
//                                          1024,
//                                          &numBytesEncrypted);
//    
//    NSString* plainText = nil;
//    if (cryptStatus == kCCSuccess) {
//        NSData *dataTemp = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
//        plainText = [GTMBase64 stringByEncodingData:dataTemp];
//        ASIFormDataRequest *form = [ASIFormDataRequest requestWithURL:nil];
//        plainText = [form encodeURL:plainText];
//    }else{
//        NSLog(@"DES加密失败");
//    }
//    return plainText;
//}

//+ (SinaWeibo *)sinaweibo
//{
//    
//    if (!instance) {
//            instance = [[SinaWeibo alloc] initWithAppKey:SINA_APPKEY appSecret:SINA_APPSECRET appRedirectURI:URI andDelegate:nil];
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            if ([defaults objectForKey:SINA_USERINFO_ACCESSTOKEN] && [defaults objectForKey:SINA_USERINFO_EXPITATIONDATE] && [defaults objectForKey:SINA_USERINFO_USERID])
//            {
//                instance.accessToken = [defaults objectForKey:SINA_USERINFO_ACCESSTOKEN];
//                instance.expirationDate = [defaults objectForKey:SINA_USERINFO_EXPITATIONDATE];
//                instance.userID = [defaults objectForKey:SINA_USERINFO_USERID];
//            }
//            return instance;
//    }
//    return instance;
//    
//}


+(NSString *) getObjectWithKey:(NSString *)key
{
    return [GlobalConfig convertToString:[[NSUserDefaults standardUserDefaults] objectForKey:key]];

}

+ (NSString *) currencyConver:(NSString *)currentcy
{
    if ([currentcy isEqualToString:@"CNY"]) {
        return @"元";
    }
    else if ([currentcy isEqualToString:@"USD"]) {
        return @"美元";
    }
    else if ([currentcy isEqualToString:@"HKD"]) {
        return @"港币";
    }
    else if ([currentcy isEqualToString:@"TWD"]) {
        return @"台币";
    }
    return @"";
}

+ (NSString *) priceConver:(id)price
{
    long int integer = 0;
    if ([price isKindOfClass:[NSString class]]) {
        
        integer = [[GlobalConfig convertToString:price] intValue];
        if (integer >= 1000) {
            return [NSString stringWithFormat:@"%ld",integer];
        }
        else {
            return price;
        }
      
    }
    else if ([price isKindOfClass:[NSNumber class]]){
        NSNumber *p = price;
        integer = [[GlobalConfig convertToNumber:p] intValue];
        if (integer >= 1000) {
            return [NSString stringWithFormat:@"%ld",integer];
        }
        else {
            return [NSString stringWithFormat:@"%.2f",[p floatValue]];
        }
    }
    
    return @"";
    
}


@end
