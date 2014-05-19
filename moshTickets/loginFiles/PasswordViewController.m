//
//  PasswordViewController.m
//  moshTickets
//
//  Created by 魔时网 on 14-2-17.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "PasswordViewController.h"
#import "ControllerFactory.h"   

static NSString *userType_email = @"email";
static NSString *userType_phone = @"phone";
static NSInteger autoTimer = 60;

@interface PasswordViewController ()

@end

@implementation PasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
}

- (void) showView:(UIView *)showview
{
    NSArray *array = @[_checkNumberView,_passwordView,_usernameView,_emailAlertView];
    for (UIView *view in array) {
        if (view == showview) {
            view.hidden = NO;
            NSInteger index = [array indexOfObject:view];
            switch (index) {
                case 0:
                    _currentView = PasswordView_checkNumberView;
                    break;
                case 1:
                    _currentView = PasswordView_passwordView;
                    break;
                case 2:
                    _currentView = PasswordView_usernameView;
                    [self checkNumberRandom];
                    self.userNameView_checkNumber.text = nil;
                    break;
                case 3:
                    _currentView = PasswordView_emailAlertView;
                    break;
                default:
                    break;
            }
        }
        else {
            view.hidden = YES;
        }
    }
}

- (void) navBackClick
{
    switch (_currentView) {
        case PasswordView_emailAlertView:
            [self showView:_usernameView];
            break;
        case PasswordView_usernameView:
//            [self.navigationController popViewControllerAnimated:YES];
            [GlobalConfig push:NO viewController:self withNavigationCotroller:self.navigationController animationType:ANIMATIONTYPE_POP subType:ANIMATIONSUBTYPE_POP Duration:DURATION];

            break;
        case PasswordView_passwordView:
            [self showView:_checkNumberView];
            break;
        case PasswordView_checkNumberView:
            [self showView:_usernameView];
            break;
        default:
            break;
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self keyboardHidden];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createBarWithLeftBarItem:MoshNavigationBarItemBack rightBarItem:MoshNavigationBarItemNone title:NAVTITLE_FINDPASSWORD];
    
    [self.view addSubview:_passwordView];
    [self.view addSubview:_emailAlertView];
    [self.view addSubview:_usernameView];
    [self.view addSubview:_checkNumberView];
    [self showView:_usernameView];
    [self checkNumberRandom];
    
    
    NSArray *array = @[self.usernameView_username,self.userNameView_checkNumber,self.passwordView_confirmPassword,self.passwordView_password,self.checkNumberView_ckeckNumber];
    for (UITextField *text in array) {
        [GlobalConfig textFieldAddLeftView:text];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)usernameViewButtonPress:(id)sender {
    [self keyboardHidden];
    
    //是否为空
    if (![GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:self.usernameView_username.text Alert:ERROR_USERNAME] || ![GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:self.userNameView_checkNumber.text Alert:ERROR_CHECKNUMBER]) {
        return;
    }
    
    //是否邮箱或手机
    if ([GlobalConfig isValidateEmail:self.usernameView_username.text]) {
        self.userType = userType_email;
        
    }
    else if ([GlobalConfig isValidateMobile:self.usernameView_username.text]) {
        self.userType = userType_phone;
    }
    else {
        [GlobalConfig alert:ERROR_USERNAME2];
        return;
    }
    
    if (![self.userNameView_checkNumber.text isEqualToString:self.userNameView_checkButton.titleLabel.text]) {
        [GlobalConfig alert:ERROR_CHECKNUMBER2];
        return;
    }
    

    //获取验证码
    [self showLoadingView];
    [[HTTPClient shareHTTPClient] findPasswordWithUsername:self.usernameView_username.text userType:self.userType success:^(id jsondata){
        [self hideLoadingView];
        [self checkNumberRandom];
        if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:jsondata]) {
            NSString *feedback = [GlobalConfig convertToString:jsondata[JSONFEEDBACK]];
            NSString *checkNumber = [GlobalConfig convertToString:jsondata[JSONKEY]];
            if ([feedback isEqualToString:@"1"]) {
                //联网成功后进入下一页
                
                if (self.userType == userType_email) {
                    [self showView:_emailAlertView];
                }
                else {
                    [self showView:_checkNumberView];
                    //开始倒计时
                    //重新获取按钮设置无效，开始倒计时
                    [self getCheckNUmberValid:NO];
                    [self checkNumberStartTimer];
                }
                self.checkNumber = checkNumber;
            }
            else if ([feedback isEqualToString:@"2"]){
                [GlobalConfig alert:ERROR_LOGINFAIL2];
            }
            else {
                [GlobalConfig alert:ERROR_LOGINFAIL3];
            }
            
        }
        else {
            [GlobalConfig alert:ERROR_LOGINFAIL3];
        }
        
    } fail:^{
                [self hideLoadingView];
        [self checkNumberRandom];
                 [GlobalConfig showAlertViewWithMessage:ERROR superView:self.view];
    }];
    
}



//点击随机生成验证码
- (IBAction)userNameViewCheckButtonPress:(id)sender {
    [self checkNumberRandom];
}

- (IBAction)passwordViewButtonPress:(id)sender {
    [self keyboardHidden];
    
    if (![GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:self.passwordView_password.text] || ![GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:self.passwordView_confirmPassword.text]) {
        [GlobalConfig alert:ERROR_PASSWORD];
        return;
    }
    
    if (![self.passwordView_confirmPassword.text isEqualToString:self.passwordView_password.text]) {
        [GlobalConfig alert:ERROR_PASSWORD2];
        return;
    }
    
    if (self.passwordView_password.text.length < 6) {
        [GlobalConfig alert:ALERT_PASSWORD];
    }
    
    [self showLoadingView];
    
    [[HTTPClient shareHTTPClient] updatePasswordWithUsername:self.usernameView_username.text
                                                    userType:self.userType
                                                    password:self.passwordView_password.text
                                                     success:^(id json){
                                                    [self hideLoadingView];
                                                    
                                                    [self requestSuccess:json];
        
    }
                                                        fail:^{
                                                            
                                                            [self hideLoadingView];
                                                            [GlobalConfig showAlertViewWithMessage:ERROR superView:self.view];
                                                        }];
    
}

- (IBAction)emailAlertViewButtonPress:(id)sender {
    [self keyboardHidden];
//    [self.navigationController popViewControllerAnimated:YES];
    [GlobalConfig push:NO viewController:self withNavigationCotroller:self.navigationController animationType:ANIMATIONTYPE_POP subType:ANIMATIONSUBTYPE_POP Duration:DURATION];
}

- (IBAction)checkNumberViewButtonPress:(id)sender {
    [self keyboardHidden];
    //不为空
    if (![GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:self.checkNumberView_ckeckNumber.text Alert:ERROR_CHECKNUMBER]) {
        return;
    };
    if ([self.checkNumberView_ckeckNumber.text isEqualToString:self.checkNumber]) {
        [self showView:_passwordView];
    }
    else {
        [GlobalConfig alert:ERROR_CHECKNUMBER2];
    }
}

- (IBAction)checkNumberViewGetNumberPress:(id)sender {
    [self keyboardHidden];
    
    //获取验证码
    [self showLoadingView];
    [[HTTPClient shareHTTPClient] findPasswordWithUsername:self.usernameView_username.text
                                                  userType:self.userType
                                                   success:^(id jsondata){
        [self hideLoadingView];
        
        if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:jsondata]) {
            NSString *feedback = [GlobalConfig convertToString:jsondata[JSONFEEDBACK]];
            NSString *checkNumber = [GlobalConfig convertToString:jsondata[JSONKEY]];
            if ([feedback isEqualToString:@"1"]) {
            
                //成功
                //重新获取按钮设置无效，开始倒计时
                [self getCheckNUmberValid:NO];
                self.checkNumber = checkNumber;
            }
            else {
                [GlobalConfig alert:ERROR_LOGINFAIL3];
            }
        }
        else {
            [GlobalConfig alert:ERROR_LOGINFAIL3];
        }
        
    }
                                                      fail:^{
        [self hideLoadingView];
                                                          
        [GlobalConfig showAlertViewWithMessage:ERROR superView:self.view];
    }];
    
}

//设置重新获取按钮有效或无效
- (void) getCheckNUmberValid:(BOOL)valid
{
    if (!valid) {
    //    开始倒计时
        [GlobalConfig alert:ALERT_CHECKNUMBER];
        autoTimer = 60;
        self.checkNumberView_getNumberButton.enabled = NO;
        [self.checkNumberView_getNumberButton setBackgroundImage:[UIImage imageNamed:@"checkNumberButton_G"] forState:UIControlStateNormal];
        [self.checkNumberView_getNumberButton setBackgroundImage:[UIImage imageNamed:@"checkNumberButton_G"] forState:UIControlStateHighlighted];
        
    }
    else {
        self.checkNumberView_getNumberButton.enabled = YES;
        [self.checkNumberView_getNumberButton setBackgroundImage:[UIImage imageNamed:@"checkNumberButton_B"] forState:UIControlStateNormal];
        [self.checkNumberView_getNumberButton setBackgroundImage:[UIImage imageNamed:@"checkNumberButton_B"] forState:UIControlStateHighlighted];
    }
}

- (void) checkNumberStartTimer
{
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(checkViewTimerLabelAutoChange) userInfo:nil repeats:YES];
}

//自动倒计时是否可获取验证码
- (void) checkViewTimerLabelAutoChange
{
    if (autoTimer > 0) {
        self.checkNumberView_SecondLabel.text = [NSString stringWithFormat:@"%d秒后可重新获取验证码",autoTimer];
        autoTimer--;
    }
    else {
        self.checkNumberView_SecondLabel.text = [NSString stringWithFormat:@"可重新获取验证码"];
        [self getCheckNUmberValid:YES];
    }
}

//键盘隐藏
- (void) keyboardHidden
{
    NSArray *array = @[self.userNameView_checkNumber,self.usernameView_username,self.checkNumberView_ckeckNumber,self.passwordView_confirmPassword,self.passwordView_password];
    for (UITextField *field in array) {
        [field resignFirstResponder];
    }
}


//验证码随机变化
- (void) checkNumberRandom
{
    NSString *number = [NSString stringWithFormat:@"%04d",arc4random()%10000];
    [self.userNameView_checkButton setTitle:number forState:UIControlStateNormal];
    [self.userNameView_checkNumber setText:nil];
}

- (void) requestSuccess:(id)json
{
    if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:json]) {
        NSDictionary *res = json[JSONKEY];
        NSString *uid = [GlobalConfig convertToString:res[@"uid"]];
        if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:uid]) {
            //保存用户信息
            [GlobalConfig saveUserInfoWithUid:uid
                                     userName:self.usernameView_username.text
                                     passWord:self.passwordView_password.text
                                        phone:nil
                                        email:nil
                                         city:nil
                                       gender:nil
                                        image:nil
                                      binding:nil];
            [GlobalConfig showAlertViewWithMessage:ALERT_PASSWORDSUC  superView:self.view];
            //登录成功 进入下一个controller
            [self.navigationController pushViewController:[ControllerFactory controllerWithLoginSuccess] animated:YES];
        }
        else {
            [GlobalConfig showAlertViewWithMessage:ERROR_LOGINFAIL4 superView:self.view];
        }
    }
}

@end
