//
//  WebViewController.h
//  MusicFestival
//
//  Created by  evafan2003 on 12-12-20.
//  Copyright (c) 2012年 cn.mosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class MBProgressHUD;

@interface WebViewController : BaseViewController<UIWebViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) NSURL *URL;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIAlertView *alv;

@property (nonatomic, strong) MBProgressHUD *hud;

- (id)initWithTitle:(NSString *)title URL:(NSURL *)theUrl;
@end
