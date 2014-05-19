//
//  WebViewController.h
//  MusicFestival
//
//  Created by  evafan2003 on 12-12-20.
//  Copyright (c) 2012年 cn.mosh. All rights reserved.
//

#import "WebViewController.h"
#import "GlobalConfig.h"
#import "MBProgressHUD.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithTitle:(NSString *)title URL:(NSURL *)theUrl
{
    self = [super init];
    if (self) {
        self.title = title;
        self.URL = theUrl;
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self createBarWithLeftBarItem:MoshNavigationBarItemBack rightBarItem:MoshNavigationBarItemNone title:self.title];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, SCREENHEIGHT - NAVHEIGHT - STATEHEIGHT)];
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor clearColor];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.URL]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.webView = nil;
}

#pragma mark - webViewDelegate -
- (void) webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    if (self.URL && !self.alv) {
        [self.webView stopLoading];
        self.alv = [[UIAlertView alloc] initWithTitle:@"加载失败" message:@"加载失败，请检查网络连接！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"再试一次",nil];
        [self.alv show];
    }
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.alv = nil;
    if (buttonIndex == 1) {
        //再试一次
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.URL]];
        
    }
    else {
        //取消
//        [self.navigationController popViewControllerAnimated:YES];
        [GlobalConfig push:NO viewController:self withNavigationCotroller:self.navigationController animationType:ANIMATIONTYPE_POP subType:ANIMATIONSUBTYPE_POP Duration:DURATION];
    }
}

- (void) navBackClick
{
    [GlobalConfig push:NO viewController:self withNavigationCotroller:self.navigationController animationType:ANIMATIONTYPE_POP subType:ANIMATIONSUBTYPE_POP Duration:DURATION];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
