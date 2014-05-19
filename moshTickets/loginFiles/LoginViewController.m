//
//  LoginViewController.m
//  moshTicket
//
//  Created by 魔时网 on 13-11-12.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "LoginViewController.h"
#import "ControllerFactory.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

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
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建导航按钮
    [self createBarWithLeftBarItem:MoshNavigationBarItemNone rightBarItem:MoshNavigationBarItemNone title:NAVTITLE_LOGIN];
    
    [self setUserInfo];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setUserInfo
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userName = [user objectForKey:USER_USERNAME];
    NSString *password = [user objectForKey:USER_PASSWORD];
    if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:userName]){
        self.userName.text = userName;
        self.password.text = password;
    }
}

- (IBAction)login:(id)sender {

    if (![GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:self.userName.text Alert:ERROR_USERNAME]) {
        return;
    }
    if (![GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:self.password.text Alert:ERROR_PASSWORD]) {
        return;
    }
    
    [self showLoadingView];
    [[HTTPClient shareHTTPClient] loginWithUserName:self.userName.text
                                           password:self.password.text
                                            success:^(id json){
                                                [self hideLoadingView];
                                                
                                                [self requestSuccess:json];
                                               
    }
                                               fail:^{
                                                   
                                                   [self hideLoadingView];
                                                   [GlobalConfig showAlertViewWithMessage:ERROR superView:self.view];
    }];
}

- (IBAction)forgetPassword:(id)sender {
    
    [self.navigationController pushViewController:[ControllerFactory controllerWithForgetPassWord] animated:YES];
//    [GlobalConfig push:YES viewController:[ControllerFactory controllerWithForgetPassWord] withNavigationCotroller:self.navigationController animationType:ANIMATIONTYPE_PUSH subType:ANIMATIONSUBTYPE_PUSH Duration:DURATION];
}

- (IBAction)urlButtonPress:(id)sender {
//    @"http://e.mosh.cn/23024"
    [self.navigationController pushViewController:[ControllerFactory webViewControllerWithTitle:NAVTITLE_ACTIVITYLIST Url:@"http://www.evente.cn"] animated:YES];
}

- (void) requestSuccess:(id)json
{
    if ([GlobalConfig isKindOfNSDictionaryClassAndCountGreaterThanZero:json]) {
        NSString *uid = json[JSONKEY];
        if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:uid]) {
            //保存用户信息
            [GlobalConfig saveUserInfoWithUid:uid
                                     userName:self.userName.text
                                     passWord:self.password.text
                                        phone:nil
                                        email:nil
                                         city:nil
                                       gender:nil
                                        image:nil
                                      binding:nil];
            //登录成功 进入下一个controller
            [self.navigationController pushViewController:[ControllerFactory controllerWithLoginSuccess] animated:YES];
        }
        else {
            [GlobalConfig showAlertViewWithMessage:ERROR_LOGINFAIL superView:self.view];
        }
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
}

#pragma mark uitextFieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userName) {
        [self.userName resignFirstResponder];
        [self.password becomeFirstResponder];
    }
    else if (textField == self.password) {
        [self.password resignFirstResponder];
        [self login:nil];
    }
    return YES;
}

@end
